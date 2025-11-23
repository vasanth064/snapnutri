import '../core/database/database.dart';
import '../core/constants/nutrition_rda.dart';

class DeficiencyDetector {
  static Future<List<NutrientDeficiency>> analyzeWeeklyDeficiencies(
    AppDatabase db,
    UserProfile profile,
  ) async {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));

    // Get weekly summaries
    final summaries = await db.getWeeklySummaries(now);

    if (summaries.isEmpty) {
      return [];
    }

    // Calculate weekly averages
    final totalDays = summaries.length;
    double avgProtein = 0;
    double avgFiber = 0;
    double avgVitA = 0;
    double avgVitC = 0;
    double avgVitD = 0;
    double avgIron = 0;
    double avgCalcium = 0;
    double avgMagnesium = 0;
    double avgPotassium = 0;

    for (final summary in summaries) {
      avgProtein += summary.totalProteinG;
      avgFiber += summary.totalFiberG;
      avgVitA += summary.totalVitaminAMcg;
      avgVitC += summary.totalVitaminCMg;
      avgVitD += summary.totalVitaminDMcg;
      avgIron += summary.totalIronMg;
      avgCalcium += summary.totalCalciumMg;
      avgMagnesium += summary.totalMagnesiumMg;
      avgPotassium += summary.totalPotassiumMg;
    }

    avgProtein /= totalDays;
    avgFiber /= totalDays;
    avgVitA /= totalDays;
    avgVitC /= totalDays;
    avgVitD /= totalDays;
    avgIron /= totalDays;
    avgCalcium /= totalDays;
    avgMagnesium /= totalDays;
    avgPotassium /= totalDays;

    // Get RDA goals
    final proteinGoal = NutritionRDA.calculateProteinGoal(profile.weight);
    final microGoals = NutritionRDA.getMicronutrientGoals(profile.gender);

    final deficiencies = <NutrientDeficiency>[];

    // Check each nutrient
    _checkNutrient(
      deficiencies,
      'Protein',
      avgProtein,
      proteinGoal,
      'g',
    );

    _checkNutrient(
      deficiencies,
      'Fiber',
      avgFiber,
      NutritionRDA.fiberDaily,
      'g',
    );

    _checkNutrient(
      deficiencies,
      'Vitamin A',
      avgVitA,
      microGoals['vitaminA']!,
      'mcg',
    );

    _checkNutrient(
      deficiencies,
      'Vitamin C',
      avgVitC,
      microGoals['vitaminC']!,
      'mg',
    );

    _checkNutrient(
      deficiencies,
      'Vitamin D',
      avgVitD,
      microGoals['vitaminD']!,
      'mcg',
    );

    _checkNutrient(
      deficiencies,
      'Iron',
      avgIron,
      microGoals['iron']!,
      'mg',
    );

    _checkNutrient(
      deficiencies,
      'Calcium',
      avgCalcium,
      microGoals['calcium']!,
      'mg',
    );

    _checkNutrient(
      deficiencies,
      'Magnesium',
      avgMagnesium,
      microGoals['magnesium']!,
      'mg',
    );

    _checkNutrient(
      deficiencies,
      'Potassium',
      avgPotassium,
      microGoals['potassium']!,
      'mg',
    );

    // Sort by severity (critical first)
    deficiencies.sort((a, b) {
      const severityOrder = {
        'critical': 0,
        'moderate': 1,
        'mild': 2,
      };
      return severityOrder[a.level]!.compareTo(severityOrder[b.level]!);
    });

    return deficiencies;
  }

  static void _checkNutrient(
    List<NutrientDeficiency> deficiencies,
    String nutrientName,
    double actual,
    double rda,
    String unit,
  ) {
    final level = NutritionRDA.getDeficiencyLevel(actual, rda);

    // Only add if there's a deficiency (not good or optimal)
    if (level != 'good' && level != 'optimal') {
      final percentage = (actual / rda * 100).round();
      final nutrientKey = _getNutrientKey(nutrientName);
      final message = NutritionRDA.getDeficiencyMessage(nutrientKey, level);

      deficiencies.add(
        NutrientDeficiency(
          nutrient: nutrientName,
          level: level,
          actual: actual,
          recommended: rda,
          percentage: percentage,
          message: message,
          unit: unit,
        ),
      );
    }
  }

  static String _getNutrientKey(String nutrientName) {
    final map = {
      'Protein': 'protein',
      'Fiber': 'fiber',
      'Vitamin A': 'vitaminA',
      'Vitamin C': 'vitaminC',
      'Vitamin D': 'vitaminD',
      'Iron': 'iron',
      'Calcium': 'calcium',
      'Magnesium': 'magnesium',
      'Potassium': 'potassium',
    };
    return map[nutrientName] ?? 'fiber';
  }
}

class NutrientDeficiency {
  final String nutrient;
  final String level; // critical, moderate, mild
  final double actual;
  final double recommended;
  final int percentage;
  final String message;
  final String unit;

  NutrientDeficiency({
    required this.nutrient,
    required this.level,
    required this.actual,
    required this.recommended,
    required this.percentage,
    required this.message,
    required this.unit,
  });

  String get statusColor {
    switch (level) {
      case 'critical':
        return 'red';
      case 'moderate':
        return 'orange';
      case 'mild':
        return 'yellow';
      default:
        return 'green';
    }
  }
}
