import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:drift/drift.dart' as drift;
import 'package:image/image.dart' as img;

import '../../main.dart';
import '../../core/database/database.dart';
import '../../services/background_processor.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isInitialized = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No cameras available')),
          );
        }
        return;
      }

      // Use back camera by default
      final camera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras.first,
      );

      _controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _controller!.initialize();

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to initialize camera: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _captureAndQueue() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      // Capture image
      final XFile imageFile = await _controller!.takePicture();

      // Compress and save image
      final compressedPath = await _compressAndSaveImage(imageFile.path);

      // Queue for processing
      final db = ref.read(databaseProvider);
      await db.insertPendingAnalysis(
        PendingAnalysisCompanion(
          imagePath: drift.Value(compressedPath),
          isProcessing: const drift.Value(false),
          retryCount: const drift.Value(0),
        ),
      );

      // Trigger background processing
      await BackgroundProcessor.scheduleImmediateProcessing();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Photo captured! Processing in background...'),
            duration: Duration(seconds: 2),
          ),
        );

        // Close the screen (Fire and Forget)
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to capture photo: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<String> _compressAndSaveImage(String originalPath) async {
    // Read original image
    final bytes = await File(originalPath).readAsBytes();
    final image = img.decodeImage(bytes);

    if (image == null) {
      throw Exception('Failed to decode image');
    }

    // Resize to max 1920px width (maintain aspect ratio)
    final resized = image.width > 1920
        ? img.copyResize(image, width: 1920)
        : image;

    // Compress to JPEG (quality 85)
    final compressed = img.encodeJpg(resized, quality: 85);

    // Save to app directory
    final appDir = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = 'food_$timestamp.jpg';
    final filePath = path.join(appDir.path, 'images', fileName);

    // Create directory if it doesn't exist
    final imageDir = Directory(path.dirname(filePath));
    if (!await imageDir.exists()) {
      await imageDir.create(recursive: true);
    }

    // Write compressed image
    final file = File(filePath);
    await file.writeAsBytes(compressed);

    // Delete original
    await File(originalPath).delete();

    return filePath;
  }

  Future<void> _pickFromGallery() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image == null) {
        setState(() {
          _isProcessing = false;
        });
        return;
      }

      // Compress and save image
      final compressedPath = await _compressAndSaveImage(image.path);

      // Queue for processing
      final db = ref.read(databaseProvider);
      await db.insertPendingAnalysis(
        PendingAnalysisCompanion(
          imagePath: drift.Value(compressedPath),
          isProcessing: const drift.Value(false),
          retryCount: const drift.Value(0),
        ),
      );

      // Trigger background processing
      await BackgroundProcessor.scheduleImmediateProcessing();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Photo selected! Processing in background...'),
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick photo: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Capture Food'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: _isProcessing ? null : _pickFromGallery,
            tooltip: 'Choose from gallery',
          ),
        ],
      ),
      body: _isInitialized
          ? Stack(
              children: [
                // Camera Preview
                Center(
                  child: CameraPreview(_controller!),
                ),

                // Processing overlay
                if (_isProcessing)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(color: Colors.white),
                          SizedBox(height: 16),
                          Text(
                            'Processing...',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
      floatingActionButton: _isInitialized && !_isProcessing
          ? FloatingActionButton.large(
              onPressed: _captureAndQueue,
              backgroundColor: colorScheme.primary,
              child: const Icon(Icons.camera_alt, size: 32),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
