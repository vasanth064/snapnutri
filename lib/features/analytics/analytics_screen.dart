import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../main.dart';
import '../../core/database/database.dart';
import '../../services/deficiency_detector.dart';

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  DailyNutritionSummar? _todaySummary;
  UserProfile? _profile;
  List<NutrientDeficiency> _deficiencies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final db = ref.read(databaseProvider);
    final today = DateTime.now();

    final summary = await db.getDailySummary(today);
    final profile = await db.getCurrentUserProfile();

    List<NutrientDeficiency> deficiencies = [];
    if (profile != null) {
      deficiencies = await DeficiencyDetector.analyzeWeeklyDeficiencies(
        db,
        profile,
      );
    }

    if (mounted) {
      setState(() {
        _todaySummary = summary;
        _profile = profile;
        _deficiencies = deficiencies;
        _isLoading = false;
      });
    }
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

    final hasSummary = _todaySummary != null;
    final totalProtein = _todaySummary?.totalProteinG ?? 0;
    final totalCarbs = _todaySummary?.totalCarbsG ?? 0;
    final totalFat = _todaySummary?.totalFatG ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Analytics'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Macros Pie Chart
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s Macros',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (hasSummary && (totalProtein + totalCarbs + totalFat) > 0)
                        SizedBox(
                          height: 250,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: PieChart(
                                  PieChartData(
                                    sectionsSpace: 2,
                                    centerSpaceRadius: 40,
                                    sections: [
                                      PieChartSectionData(
                                        value: totalProtein,
                                        title: '${totalProtein.toStringAsFixed(0)}g',
                                        color: colorScheme.secondary,
                                        radius: 80,
                                        titleStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      PieChartSectionData(
                                        value: totalCarbs,
                                        title: '${totalCarbs.toStringAsFixed(0)}g',
                                        color: colorScheme.tertiary,
                                        radius: 80,
                                        titleStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      PieChartSectionData(
                                        value: totalFat,
                                        title: '${totalFat.toStringAsFixed(0)}g',
                                        color: colorScheme.error,
                                        radius: 80,
                                        titleStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _LegendItem(
                                      color: colorScheme.secondary,
                                      label: 'Protein',
                                      value: '${totalProtein.toStringAsFixed(1)}g',
                                    ),
                                    const SizedBox(height: 12),
                                    _LegendItem(
                                      color: colorScheme.tertiary,
                                      label: 'Carbs',
                                      value: '${totalCarbs.toStringAsFixed(1)}g',
                                    ),
                                    const SizedBox(height: 12),
                                    _LegendItem(
                                      color: colorScheme.error,
                                      label: 'Fat',
                                      value: '${totalFat.toStringAsFixed(1)}g',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Container(
                          height: 200,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.pie_chart_outline,
                                size: 64,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No data yet today',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Micronutrient Traffic Lights
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekly Nutrient Status',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '7-day average vs recommended daily allowance',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (_deficiencies.isEmpty)
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 48,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'All Good!',
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[700],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'No nutrient deficiencies detected',
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        ...(_deficiencies.map((deficiency) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _NutrientTrafficLight(deficiency: deficiency),
                          );
                        }).toList()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NutrientTrafficLight extends StatelessWidget {
  final NutrientDeficiency deficiency;

  const _NutrientTrafficLight({required this.deficiency});

  Color _getColor() {
    switch (deficiency.level) {
      case 'critical':
        return Colors.red;
      case 'moderate':
        return Colors.orange;
      case 'mild':
        return Colors.yellow[700]!;
      default:
        return Colors.green;
    }
  }

  IconData _getIcon() {
    switch (deficiency.level) {
      case 'critical':
        return Icons.cancel;
      case 'moderate':
        return Icons.warning;
      case 'mild':
        return Icons.info;
      default:
        return Icons.check_circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _getColor();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Row(
        children: [
          Icon(_getIcon(), color: color, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      deficiency.nutrient,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${deficiency.percentage}%',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${deficiency.actual.toStringAsFixed(1)} / ${deficiency.recommended.toStringAsFixed(0)} ${deficiency.unit}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  deficiency.message,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
