import 'dart:io';
import 'package:workmanager/workmanager.dart';
import 'package:drift/drift.dart' as drift;

import '../core/database/database.dart';
import 'gemini_service.dart';
import 'notification_service.dart';

class BackgroundProcessor {
  static const String processImagesTask = 'processImagesTask';
  static const String checkPendingTask = 'checkPendingTask';

  static Future<void> initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
  }

  static Future<void> scheduleImmediateProcessing() async {
    await Workmanager().registerOneOffTask(
      'process-immediate',
      processImagesTask,
      initialDelay: const Duration(seconds: 2),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  static Future<void> schedulePeriodicCheck() async {
    await Workmanager().registerPeriodicTask(
      'check-pending',
      checkPendingTask,
      frequency: const Duration(hours: 1),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  static Future<void> processAllPendingImages(AppDatabase db) async {
    final pending = await db.getAllPendingAnalysis();

    for (final item in pending) {
      await _processImage(db, item);
    }
  }

  static Future<void> _processImage(
    AppDatabase db,
    PendingAnalysi item,
  ) async {
    try {
      // Mark as processing
      await db.markAsProcessing(item.id);

      // Check if file exists
      final imageFile = File(item.imagePath);
      if (!await imageFile.exists()) {
        await db.updateAnalysisError(item.id, 'Image file not found');
        return;
      }

      // Analyze with Gemini
      final gemini = GeminiService();
      final result = await gemini.analyzeFood(imageFile);

      // Check confidence score
      if (result.confidenceScore < 20) {
        await db.updateAnalysisError(
          item.id,
          'Low confidence: ${result.foodName}',
        );

        // Send notification about low confidence
        await NotificationService.showLowConfidenceNotification(
          result.foodName,
        );

        await db.deletePendingAnalysis(item.id);
        return;
      }

      // Create food entry (not approved yet)
      await db.insertFoodEntry(
        FoodEntriesCompanion(
          foodName: drift.Value(result.foodName),
          imagePath: drift.Value(item.imagePath),
          calories: drift.Value(result.calories),
          proteinG: drift.Value(result.macros.proteinG),
          carbsG: drift.Value(result.macros.carbsG),
          fatG: drift.Value(result.macros.fatG),
          fiberG: drift.Value(result.micros.fiberG),
          vitaminAMcg: drift.Value(result.micros.vitaminAMcg),
          vitaminCMg: drift.Value(result.micros.vitaminCMg),
          vitaminDMcg: drift.Value(result.micros.vitaminDMcg),
          ironMg: drift.Value(result.micros.ironMg),
          calciumMg: drift.Value(result.micros.calciumMg),
          magnesiumMg: drift.Value(result.micros.magnesiumMg),
          potassiumMg: drift.Value(result.micros.potassiumMg),
          quantityDescription: drift.Value(result.quantityDescription),
          portionMultiplier: const drift.Value(1.0),
          confidenceScore: drift.Value(result.confidenceScore),
          healthTip: drift.Value(result.healthTip),
          isApproved: const drift.Value(false),
        ),
      );

      // Delete from pending queue
      await db.deletePendingAnalysis(item.id);

      // Send notification
      await NotificationService.showAnalysisCompleteNotification(
        result.foodName,
        result.calories,
      );
    } on RateLimitException catch (e) {
      // Rate limit hit - will retry later
      await db.updateAnalysisError(item.id, 'Rate limit: ${e.message}');
    } on FoodAnalysisException catch (e) {
      // Analysis failed
      final newRetryCount = item.retryCount + 1;

      if (newRetryCount >= 3) {
        // Max retries reached, delete
        await db.deletePendingAnalysis(item.id);
        await NotificationService.showAnalysisFailedNotification();
      } else {
        await db.updateAnalysisError(item.id, e.message);
      }
    } catch (e) {
      // Unknown error
      await db.updateAnalysisError(item.id, 'Unknown error: $e');
    }
  }
}

// This callback runs in a separate isolate
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      // Initialize database in this isolate
      final db = AppDatabase();

      if (task == BackgroundProcessor.processImagesTask ||
          task == BackgroundProcessor.checkPendingTask) {
        await BackgroundProcessor.processAllPendingImages(db);
      }

      return true;
    } catch (e) {
      // Task failed
      return false;
    }
  });
}
