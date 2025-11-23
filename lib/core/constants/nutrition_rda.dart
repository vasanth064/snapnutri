// Recommended Dietary Allowances based on age, weight, and gender

class NutritionRDA {
  static const int baseCaloriesMale = 2500;
  static const int baseCaloriesFemale = 2000;

  // Macronutrients (grams per day)
  static const double proteinPerKgBodyWeight = 0.8; // 0.8g per kg
  static const double fiberDaily = 25.0;

  // Micronutrients RDA
  static const Map<String, Map<String, double>> micronutrients = {
    'male': {
      'vitaminA': 900.0, // mcg
      'vitaminC': 90.0, // mg
      'vitaminD': 15.0, // mcg
      'iron': 8.0, // mg
      'calcium': 1000.0, // mg
      'magnesium': 400.0, // mg
      'potassium': 3400.0, // mg
    },
    'female': {
      'vitaminA': 700.0, // mcg
      'vitaminC': 75.0, // mg
      'vitaminD': 15.0, // mcg
      'iron': 18.0, // mg (higher due to menstruation)
      'calcium': 1000.0, // mg
      'magnesium': 310.0, // mg
      'potassium': 2600.0, // mg
    },
  };

  static int calculateDailyCalories({
    required int age,
    required double weight,
    required String gender,
  }) {
    // Simplified Mifflin-St Jeor Equation
    // BMR = 10 * weight(kg) + 6.25 * height(cm) - 5 * age + s
    // where s = +5 for males, -161 for females
    // Assuming average height for simplification

    final baseCalories =
        gender.toLowerCase() == 'male' ? baseCaloriesMale : baseCaloriesFemale;

    // Adjust based on weight (rough approximation)
    final weightAdjustment = (weight - 70) * 10; // Adjust from 70kg baseline
    final ageAdjustment = (age - 30) * -5; // Decrease 5 cal per year over 30

    return (baseCalories + weightAdjustment + ageAdjustment).round();
  }

  static double calculateProteinGoal(double weight) {
    return weight * proteinPerKgBodyWeight;
  }

  static Map<String, double> getMicronutrientGoals(String gender) {
    return micronutrients[gender.toLowerCase()] ?? micronutrients['male']!;
  }

  // Deficiency thresholds (percentage of RDA)
  static const double criticalDeficiency = 0.3; // < 30% of RDA
  static const double moderateDeficiency = 0.5; // < 50% of RDA
  static const double mildDeficiency = 0.7; // < 70% of RDA

  static String getDeficiencyLevel(double actual, double rda) {
    final percentage = actual / rda;

    if (percentage < criticalDeficiency) {
      return 'critical';
    } else if (percentage < moderateDeficiency) {
      return 'moderate';
    } else if (percentage < mildDeficiency) {
      return 'mild';
    } else if (percentage >= 1.0) {
      return 'optimal';
    } else {
      return 'good';
    }
  }

  static String getDeficiencyMessage(String nutrient, String level) {
    final messages = {
      'critical': {
        'vitaminA':
            'Critical Vitamin A deficiency detected. May affect vision and immunity. Consider eating carrots, sweet potatoes, or spinach.',
        'vitaminC':
            'Critical Vitamin C deficiency detected. Risk of scurvy and weakened immunity. Add citrus fruits, berries, or bell peppers.',
        'vitaminD':
            'Critical Vitamin D deficiency detected. May affect bone health. Get sunlight exposure or consider fatty fish.',
        'iron':
            'Critical iron deficiency detected. May cause fatigue and anemia. Eat red meat, beans, or fortified cereals.',
        'calcium':
            'Critical calcium deficiency detected. Risk of weak bones. Consume dairy, fortified plant milk, or leafy greens.',
        'magnesium':
            'Critical magnesium deficiency detected. May cause muscle cramps. Eat nuts, seeds, or whole grains.',
        'potassium':
            'Critical potassium deficiency detected. Affects heart function. Add bananas, potatoes, or avocados.',
        'fiber':
            'Critical fiber deficiency detected. May cause digestive issues. Eat more whole grains, vegetables, and legumes.',
      },
      'moderate': {
        'vitaminA':
            'Low Vitamin A intake. Try adding more orange vegetables to your diet.',
        'vitaminC':
            'Low Vitamin C intake. Consider eating more fruits daily.',
        'vitaminD':
            'Low Vitamin D intake. Spend more time outdoors or eat fatty fish.',
        'iron':
            'Low iron intake. You might feel more tired than usual. Add iron-rich foods.',
        'calcium': 'Low calcium intake. Important for bone health.',
        'magnesium':
            'Low magnesium intake. May affect sleep quality and muscle function.',
        'potassium':
            'Low potassium intake. Important for heart and muscle function.',
        'fiber':
            'Low fiber intake. May affect digestion and satiety.',
      },
      'mild': {
        'vitaminA': 'Vitamin A intake could be improved slightly.',
        'vitaminC': 'Vitamin C intake could be improved slightly.',
        'vitaminD': 'Vitamin D intake could be improved slightly.',
        'iron': 'Iron intake could be improved slightly.',
        'calcium': 'Calcium intake could be improved slightly.',
        'magnesium': 'Magnesium intake could be improved slightly.',
        'potassium': 'Potassium intake could be improved slightly.',
        'fiber': 'Fiber intake could be improved slightly.',
      },
    };

    return messages[level]?[nutrient] ?? 'Nutrient intake could be improved.';
  }
}
