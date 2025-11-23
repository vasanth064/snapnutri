import 'package:drift/drift.dart';

// User Profile Table
class UserProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get age => integer()();
  RealColumn get weight => real()();
  TextColumn get gender => text().withLength(min: 1, max: 10)();
  IntColumn get dailyCalorieGoal => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// Food Entries Table
class FoodEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get foodName => text().withLength(min: 1, max: 200)();
  TextColumn get imagePath => text()();
  IntColumn get calories => integer()();
  RealColumn get proteinG => real()();
  RealColumn get carbsG => real()();
  RealColumn get fatG => real()();
  RealColumn get fiberG => real().nullable()();
  RealColumn get vitaminAMcg => real().nullable()();
  RealColumn get vitaminCMg => real().nullable()();
  RealColumn get vitaminDMcg => real().nullable()();
  RealColumn get ironMg => real().nullable()();
  RealColumn get calciumMg => real().nullable()();
  RealColumn get magnesiumMg => real().nullable()();
  RealColumn get potassiumMg => real().nullable()();
  TextColumn get quantityDescription => text()();
  RealColumn get portionMultiplier => real().withDefault(const Constant(1.0))();
  IntColumn get confidenceScore => integer()();
  TextColumn get healthTip => text().nullable()();
  BoolColumn get isApproved => boolean().withDefault(const Constant(false))();
  DateTimeColumn get capturedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get approvedAt => dateTime().nullable()();
}

// Pending Analysis Queue (for offline support)
class PendingAnalysis extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get imagePath => text()();
  BoolColumn get isProcessing => boolean().withDefault(const Constant(false))();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
}

// Chat History Table
class ChatMessages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get role => text().withLength(min: 1, max: 20)(); // 'user' or 'assistant'
  TextColumn get message => text()();
  TextColumn get contextData => text().nullable()(); // JSON string of nutrition data used as context
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Daily Nutrition Summary (for quick analytics)
class DailyNutritionSummary extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get totalCalories => integer()();
  RealColumn get totalProteinG => real()();
  RealColumn get totalCarbsG => real()();
  RealColumn get totalFatG => real()();
  RealColumn get totalFiberG => real()();
  RealColumn get totalVitaminAMcg => real()();
  RealColumn get totalVitaminCMg => real()();
  RealColumn get totalVitaminDMcg => real()();
  RealColumn get totalIronMg => real()();
  RealColumn get totalCalciumMg => real()();
  RealColumn get totalMagnesiumMg => real()();
  RealColumn get totalPotassiumMg => real()();
  IntColumn get mealCount => integer()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {date},
  ];
}
