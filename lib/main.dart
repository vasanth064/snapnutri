import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'core/theme/material_you_theme.dart';
import 'core/database/database.dart';
import 'features/dashboard/home_screen.dart';
import 'features/onboarding/onboarding_screen.dart';

// Global database provider
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: SnapNutriApp(),
    ),
  );
}

class SnapNutriApp extends StatelessWidget {
  const SnapNutriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'SnapNutri',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(lightDynamic),
          darkTheme: AppTheme.darkTheme(darkDynamic),
          themeMode: ThemeMode.system,
          home: const AppShell(),
        );
      },
    );
  }
}

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  bool _isOnboarded = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    final db = ref.read(databaseProvider);
    final profile = await db.getCurrentUserProfile();

    setState(() {
      _isOnboarded = profile != null;
      _isLoading = false;
    });
  }

  void _completeOnboarding() {
    setState(() {
      _isOnboarded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!_isOnboarded) {
      return OnboardingScreen(onComplete: _completeOnboarding);
    }

    return const HomeScreen();
  }
}
