import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;

import '../../main.dart';
import '../../core/database/database.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({
    super.key,
    required this.onComplete,
  });

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  String _gender = 'male';
  bool _isLoading = false;

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final age = int.parse(_ageController.text);
      final weight = double.parse(_weightController.text);

      final db = ref.read(databaseProvider);

      // Calculate daily calorie goal based on user metrics
      final calorieGoal = _calculateDailyCalories(age, weight, _gender);

      await db.insertOrUpdateUserProfile(
        UserProfilesCompanion(
          age: drift.Value(age),
          weight: drift.Value(weight),
          gender: drift.Value(_gender),
          dailyCalorieGoal: drift.Value(calorieGoal),
        ),
      );

      widget.onComplete();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving profile: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  int _calculateDailyCalories(int age, double weight, String gender) {
    // Simplified Mifflin-St Jeor Equation
    final base = gender == 'male' ? 2500 : 2000;
    final weightAdjustment = (weight - 70) * 10;
    final ageAdjustment = (age - 30) * -5;
    return (base + weightAdjustment + ageAdjustment).round();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Icon(
                  Icons.restaurant_menu,
                  size: 80,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome to SnapNutri',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'AI-powered calorie tracking made simple',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                Text(
                  'Tell us about yourself',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    hintText: 'Enter your age',
                    prefixIcon: Icon(Icons.cake),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 1 || age > 120) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _weightController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Weight (kg)',
                    hintText: 'Enter your weight',
                    prefixIcon: Icon(Icons.monitor_weight),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    final weight = double.tryParse(value);
                    if (weight == null || weight < 20 || weight > 300) {
                      return 'Please enter a valid weight';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Gender',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment<String>(
                      value: 'male',
                      label: Text('Male'),
                      icon: Icon(Icons.male),
                    ),
                    ButtonSegment<String>(
                      value: 'female',
                      label: Text('Female'),
                      icon: Icon(Icons.female),
                    ),
                  ],
                  selected: {_gender},
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() {
                      _gender = newSelection.first;
                    });
                  },
                ),
                const SizedBox(height: 48),
                FilledButton(
                  onPressed: _isLoading ? null : _saveProfile,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'We use this information to calculate your personalized nutrition goals and detect deficiencies.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
