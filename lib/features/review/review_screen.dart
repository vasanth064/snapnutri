import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../../core/database/database.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key});

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  List<FoodEntry> _pendingEntries = [];
  int _currentIndex = 0;
  double _portionMultiplier = 1.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPendingEntries();
  }

  Future<void> _loadPendingEntries() async {
    final db = ref.read(databaseProvider);
    final entries = await db.getPendingReviewEntries();

    setState(() {
      _pendingEntries = entries;
      _isLoading = false;
    });

    if (_pendingEntries.isEmpty && mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _approveEntry() async {
    if (_pendingEntries.isEmpty) return;

    final entry = _pendingEntries[_currentIndex];
    final db = ref.read(databaseProvider);

    await db.approveFoodEntry(entry.id, _portionMultiplier);

    // Update daily summary
    await db.updateDailySummary(DateTime.now());

    if (_currentIndex < _pendingEntries.length - 1) {
      setState(() {
        _currentIndex++;
        _portionMultiplier = 1.0;
      });
    } else {
      // All done
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    }
  }

  Future<void> _deleteEntry() async {
    if (_pendingEntries.isEmpty) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Entry'),
        content: const Text('Are you sure you want to delete this entry?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final entry = _pendingEntries[_currentIndex];
    final db = ref.read(databaseProvider);

    await db.deleteFoodEntry(entry.id);

    setState(() {
      _pendingEntries.removeAt(_currentIndex);
      if (_currentIndex >= _pendingEntries.length && _currentIndex > 0) {
        _currentIndex--;
      }
    });

    if (_pendingEntries.isEmpty && mounted) {
      Navigator.of(context).pop(true);
    }
  }

  int get _displayCalories {
    if (_pendingEntries.isEmpty) return 0;
    return (_pendingEntries[_currentIndex].calories * _portionMultiplier).round();
  }

  double get _displayProtein {
    if (_pendingEntries.isEmpty) return 0;
    return _pendingEntries[_currentIndex].proteinG * _portionMultiplier;
  }

  double get _displayCarbs {
    if (_pendingEntries.isEmpty) return 0;
    return _pendingEntries[_currentIndex].carbsG * _portionMultiplier;
  }

  double get _displayFat {
    if (_pendingEntries.isEmpty) return 0;
    return _pendingEntries[_currentIndex].fatG * _portionMultiplier;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_pendingEntries.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No items to review')),
      );
    }

    final entry = _pendingEntries[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Review (${_currentIndex + 1}/${_pendingEntries.length})'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _deleteEntry,
            tooltip: 'Delete',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Food Image
            AspectRatio(
              aspectRatio: 4 / 3,
              child: File(entry.imagePath).existsSync()
                  ? Image.file(
                      File(entry.imagePath),
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.image_not_supported, size: 64),
                    ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food Name
                  Text(
                    entry.foodName,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        entry.quantityDescription,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${entry.confidenceScore}% confident',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Calories Display
                  Card(
                    color: colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            size: 40,
                            color: colorScheme.onPrimaryContainer,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$_displayCalories kcal',
                                style: theme.textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onPrimaryContainer,
                                ),
                              ),
                              Text(
                                'Total Calories',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Macros
                  Row(
                    children: [
                      Expanded(
                        child: _MacroCard(
                          label: 'Protein',
                          value: _displayProtein.toStringAsFixed(1),
                          unit: 'g',
                          icon: Icons.egg_outlined,
                          color: colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _MacroCard(
                          label: 'Carbs',
                          value: _displayCarbs.toStringAsFixed(1),
                          unit: 'g',
                          icon: Icons.grain,
                          color: colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _MacroCard(
                          label: 'Fat',
                          value: _displayFat.toStringAsFixed(1),
                          unit: 'g',
                          icon: Icons.water_drop_outlined,
                          color: colorScheme.error,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Portion Size Slider
                  Text(
                    'Adjust Portion Size',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '50%',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                              Text(
                                '${(_portionMultiplier * 100).round()}%',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                              ),
                              Text(
                                '150%',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: _portionMultiplier,
                            min: 0.5,
                            max: 1.5,
                            divisions: 20,
                            label: '${(_portionMultiplier * 100).round()}%',
                            onChanged: (value) {
                              setState(() {
                                _portionMultiplier = value;
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Less',
                                style: theme.textTheme.bodySmall,
                              ),
                              Text(
                                'As shown',
                                style: theme.textTheme.bodySmall,
                              ),
                              Text(
                                'More',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Health Tip
                  if (entry.healthTip != null && entry.healthTip!.isNotEmpty)
                    Card(
                      color: colorScheme.tertiaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: colorScheme.onTertiaryContainer,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                entry.healthTip!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onTertiaryContainer,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 32),

                  // Approve Button
                  FilledButton.icon(
                    onPressed: _approveEntry,
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Approve & Add to Log'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MacroCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  const _MacroCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              unit,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
