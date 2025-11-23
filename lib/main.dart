import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'core/theme/material_you_theme.dart';
import 'core/database/database.dart';
import 'features/dashboard/home_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/review/review_screen.dart';
import 'services/background_processor.dart';
import 'services/notification_service.dart';

// Global database provider
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await BackgroundProcessor.initialize();
  await NotificationService.initialize();
  await NotificationService.requestPermissions();

  // Schedule periodic check for pending images
  await BackgroundProcessor.schedulePeriodicCheck();

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
  bool _hasPendingReviews = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    final db = ref.read(databaseProvider);
    final profile = await db.getCurrentUserProfile();
    final pending = await db.getPendingReviewEntries();

    setState(() {
      _isOnboarded = profile != null;
      _hasPendingReviews = pending.isNotEmpty;
      _isLoading = false;
    });
  }

  void _completeOnboarding() {
    setState(() {
      _isOnboarded = true;
    });
  }

  Future<void> _onReviewComplete() async {
    await _checkOnboarding();
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

    // Forced Review: Block access to home until all pending items reviewed
    if (_hasPendingReviews) {
      return Scaffold(
        body: Stack(
          children: [
            const HomeScreen(),
            Container(
              color: Colors.black54,
              child: SafeArea(
                child: Center(
                  child: Card(
                    margin: const EdgeInsets.all(24),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.rate_review,
                            size: 64,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Review Pending',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'You have food entries waiting for review. Please review them before continuing.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 24),
                          FilledButton.icon(
                            onPressed: () async {
                              final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ReviewScreen(),
                                ),
                              );
                              if (result == true) {
                                await _onReviewComplete();
                              }
                            },
                            icon: const Icon(Icons.check_circle),
                            label: const Text('Review Now'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const HomeScreen();
  }
}
