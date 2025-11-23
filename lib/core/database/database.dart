import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  UserProfiles,
  FoodEntries,
  PendingAnalysis,
  ChatMessages,
  DailyNutritionSummary,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Handle future migrations here
        },
      );

  // Food Entries Queries
  Future<List<FoodEntry>> getPendingReviewEntries() {
    return (select(foodEntries)
          ..where((tbl) => tbl.isApproved.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.capturedAt)]))
        .get();
  }

  Future<List<FoodEntry>> getApprovedEntriesByDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (select(foodEntries)
          ..where((tbl) =>
              tbl.isApproved.equals(true) &
              tbl.capturedAt.isBiggerOrEqualValue(startOfDay) &
              tbl.capturedAt.isSmallerThanValue(endOfDay))
          ..orderBy([(t) => OrderingTerm.desc(t.capturedAt)]))
        .get();
  }

  Future<List<FoodEntry>> getEntriesInDateRange(
      DateTime startDate, DateTime endDate) {
    return (select(foodEntries)
          ..where((tbl) =>
              tbl.isApproved.equals(true) &
              tbl.capturedAt.isBiggerOrEqualValue(startDate) &
              tbl.capturedAt.isSmallerOrEqualValue(endDate))
          ..orderBy([(t) => OrderingTerm.desc(t.capturedAt)]))
        .get();
  }

  Future<int> approveFoodEntry(int id, double portionMultiplier) {
    return (update(foodEntries)..where((tbl) => tbl.id.equals(id))).write(
      FoodEntriesCompanion(
        isApproved: const Value(true),
        portionMultiplier: Value(portionMultiplier),
        approvedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> insertFoodEntry(FoodEntriesCompanion entry) {
    return into(foodEntries).insert(entry);
  }

  Future<void> deleteFoodEntry(int id) {
    return (delete(foodEntries)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Pending Analysis Queries
  Future<List<PendingAnalysi>> getAllPendingAnalysis() {
    return (select(pendingAnalysis)
          ..where((tbl) => tbl.isProcessing.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
  }

  Future<int> insertPendingAnalysis(PendingAnalysisCompanion entry) {
    return into(pendingAnalysis).insert(entry);
  }

  Future<int> markAsProcessing(int id) {
    return (update(pendingAnalysis)..where((tbl) => tbl.id.equals(id))).write(
      PendingAnalysisCompanion(
        isProcessing: const Value(true),
        lastAttemptAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> updateAnalysisError(int id, String error) {
    return (update(pendingAnalysis)..where((tbl) => tbl.id.equals(id))).write(
      PendingAnalysisCompanion(
        isProcessing: const Value(false),
        errorMessage: Value(error),
        retryCount: Value(1), // Will be handled by query to increment
        lastAttemptAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deletePendingAnalysis(int id) {
    return (delete(pendingAnalysis)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Chat Messages Queries
  Future<List<ChatMessage>> getRecentChatMessages(int limit) {
    return (select(chatMessages)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .get();
  }

  Future<int> insertChatMessage(ChatMessagesCompanion message) {
    return into(chatMessages).insert(message);
  }

  Future<void> clearChatHistory() {
    return delete(chatMessages).go();
  }

  // User Profile Queries
  Future<UserProfile?> getCurrentUserProfile() {
    return (select(userProfiles)..limit(1)).getSingleOrNull();
  }

  Future<int> insertOrUpdateUserProfile(UserProfilesCompanion profile) async {
    final existing = await getCurrentUserProfile();
    if (existing != null) {
      return (update(userProfiles)..where((tbl) => tbl.id.equals(existing.id)))
          .write(profile);
    } else {
      return into(userProfiles).insert(profile);
    }
  }

  // Daily Summary Queries
  Future<DailyNutritionSummar?> getDailySummary(DateTime date) {
    final targetDate = DateTime(date.year, date.month, date.day);
    return (select(dailyNutritionSummary)
          ..where((tbl) => tbl.date.equals(targetDate)))
        .getSingleOrNull();
  }

  Future<void> updateDailySummary(DateTime date) async {
    final entries = await getApprovedEntriesByDate(date);

    if (entries.isEmpty) {
      // Delete summary if no entries
      final targetDate = DateTime(date.year, date.month, date.day);
      await (delete(dailyNutritionSummary)
            ..where((tbl) => tbl.date.equals(targetDate)))
          .go();
      return;
    }

    int totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    double totalFiber = 0;
    double totalVitA = 0;
    double totalVitC = 0;
    double totalVitD = 0;
    double totalIron = 0;
    double totalCalcium = 0;
    double totalMagnesium = 0;
    double totalPotassium = 0;

    for (final entry in entries) {
      final multiplier = entry.portionMultiplier;
      totalCalories += (entry.calories * multiplier).round();
      totalProtein += entry.proteinG * multiplier;
      totalCarbs += entry.carbsG * multiplier;
      totalFat += entry.fatG * multiplier;
      totalFiber += (entry.fiberG ?? 0) * multiplier;
      totalVitA += (entry.vitaminAMcg ?? 0) * multiplier;
      totalVitC += (entry.vitaminCMg ?? 0) * multiplier;
      totalVitD += (entry.vitaminDMcg ?? 0) * multiplier;
      totalIron += (entry.ironMg ?? 0) * multiplier;
      totalCalcium += (entry.calciumMg ?? 0) * multiplier;
      totalMagnesium += (entry.magnesiumMg ?? 0) * multiplier;
      totalPotassium += (entry.potassiumMg ?? 0) * multiplier;
    }

    final targetDate = DateTime(date.year, date.month, date.day);
    final companion = DailyNutritionSummaryCompanion.insert(
      date: targetDate,
      totalCalories: totalCalories,
      totalProteinG: totalProtein,
      totalCarbsG: totalCarbs,
      totalFatG: totalFat,
      totalFiberG: totalFiber,
      totalVitaminAMcg: totalVitA,
      totalVitaminCMg: totalVitC,
      totalVitaminDMcg: totalVitD,
      totalIronMg: totalIron,
      totalCalciumMg: totalCalcium,
      totalMagnesiumMg: totalMagnesium,
      totalPotassiumMg: totalPotassium,
      mealCount: entries.length,
      updatedAt: Value(DateTime.now()),
    );

    await into(dailyNutritionSummary).insertOnConflictUpdate(companion);
  }

  Future<List<DailyNutritionSummar>> getWeeklySummaries(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: 7));
    return (select(dailyNutritionSummary)
          ..where((tbl) => tbl.date.isBiggerOrEqualValue(startOfWeek))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'snapnutri.db'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase(file);
  });
}
