import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';
import '../../core/database/database.dart';
import '../camera/camera_screen.dart';
import '../review/review_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomePage(),
          JournalPage(),
          CoachPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'UPI',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_outlined),
            selectedIcon: Icon(Icons.restaurant),
            label: 'Card',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            selectedIcon: Icon(Icons.chat),
            label: 'Account',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: 'Rewards',
          ),
        ],
      ),
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _pendingCount = 0;
  int _todayCalories = 0;
  int _calorieGoal = 2000;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final db = ref.read(databaseProvider);

    // Get pending review count
    final pending = await db.getPendingReviewEntries();

    // Get today's summary
    final today = DateTime.now();
    final summary = await db.getDailySummary(today);

    // Get user profile for calorie goal
    final profile = await db.getCurrentUserProfile();

    if (mounted) {
      setState(() {
        _pendingCount = pending.length;
        _todayCalories = summary?.totalCalories ?? 0;
        _calorieGoal = profile?.dailyCalorieGoal ?? 2000;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          child: CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                floating: true,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: colorScheme.primaryContainer,
                      child: Icon(
                        Icons.person,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SnapNutri',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                actions: [
                  if (_pendingCount > 0)
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.notifications, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            '$_pendingCount Review',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () async {
                      // Navigate to review screen if pending
                      if (_pendingCount > 0) {
                        final result = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ReviewScreen(),
                          ),
                        );
                        if (result == true && mounted) {
                          await _loadData();
                        }
                      }
                    },
                  ),
                ],
              ),

              // Main Content
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Main Card - Daily Calorie Ring
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            // Calorie Ring
                            SizedBox(
                              height: 200,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: 180,
                                    width: 180,
                                    child: CircularProgressIndicator(
                                      value: _todayCalories / _calorieGoal,
                                      strokeWidth: 12,
                                      backgroundColor:
                                          colorScheme.surfaceContainerHighest,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '$_todayCalories',
                                        style: theme.textTheme.headlineLarge
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                      Text(
                                        'of $_calorieGoal kcal',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Quick Actions
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () async {
                                      final result = await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const CameraScreen(),
                                        ),
                                      );
                                      if (result == true && mounted) {
                                        await _loadData();
                                      }
                                    },
                                    icon: const Icon(Icons.camera_alt),
                                    label: const Text('Capture'),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.all(16),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: FilledButton.icon(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('History screen coming soon!'),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.history),
                                    label: const Text('History'),
                                    style: FilledButton.styleFrom(
                                      padding: const EdgeInsets.all(16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Service Cards Row
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        colorScheme.secondaryContainer,
                                    child: Icon(
                                      Icons.track_changes,
                                      color: colorScheme.onSecondaryContainer,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Daily Goals',
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Track macros',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Card(
                            color: colorScheme.tertiaryContainer,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: colorScheme.tertiary,
                                    child: Icon(
                                      Icons.local_fire_department,
                                      color: colorScheme.onTertiary,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Insights',
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.onTertiaryContainer,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Nutrient tips',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onTertiaryContainer,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder pages
class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Journal Page - Coming Soon'));
  }
}

class CoachPage extends StatelessWidget {
  const CoachPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('AI Coach Page - Coming Soon'));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Page - Coming Soon'));
  }
}
