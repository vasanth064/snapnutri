// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dailyCalorieGoalMeta =
      const VerificationMeta('dailyCalorieGoal');
  @override
  late final GeneratedColumn<int> dailyCalorieGoal = GeneratedColumn<int>(
      'daily_calorie_goal', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, age, weight, gender, dailyCalorieGoal, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<UserProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('daily_calorie_goal')) {
      context.handle(
          _dailyCalorieGoalMeta,
          dailyCalorieGoal.isAcceptableOrUnknown(
              data['daily_calorie_goal']!, _dailyCalorieGoalMeta));
    } else if (isInserting) {
      context.missing(_dailyCalorieGoalMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      dailyCalorieGoal: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}daily_calorie_goal'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final int id;
  final int age;
  final double weight;
  final String gender;
  final int dailyCalorieGoal;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserProfile(
      {required this.id,
      required this.age,
      required this.weight,
      required this.gender,
      required this.dailyCalorieGoal,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['age'] = Variable<int>(age);
    map['weight'] = Variable<double>(weight);
    map['gender'] = Variable<String>(gender);
    map['daily_calorie_goal'] = Variable<int>(dailyCalorieGoal);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      age: Value(age),
      weight: Value(weight),
      gender: Value(gender),
      dailyCalorieGoal: Value(dailyCalorieGoal),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<int>(json['id']),
      age: serializer.fromJson<int>(json['age']),
      weight: serializer.fromJson<double>(json['weight']),
      gender: serializer.fromJson<String>(json['gender']),
      dailyCalorieGoal: serializer.fromJson<int>(json['dailyCalorieGoal']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'age': serializer.toJson<int>(age),
      'weight': serializer.toJson<double>(weight),
      'gender': serializer.toJson<String>(gender),
      'dailyCalorieGoal': serializer.toJson<int>(dailyCalorieGoal),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserProfile copyWith(
          {int? id,
          int? age,
          double? weight,
          String? gender,
          int? dailyCalorieGoal,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      UserProfile(
        id: id ?? this.id,
        age: age ?? this.age,
        weight: weight ?? this.weight,
        gender: gender ?? this.gender,
        dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      age: data.age.present ? data.age.value : this.age,
      weight: data.weight.present ? data.weight.value : this.weight,
      gender: data.gender.present ? data.gender.value : this.gender,
      dailyCalorieGoal: data.dailyCalorieGoal.present
          ? data.dailyCalorieGoal.value
          : this.dailyCalorieGoal,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('age: $age, ')
          ..write('weight: $weight, ')
          ..write('gender: $gender, ')
          ..write('dailyCalorieGoal: $dailyCalorieGoal, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, age, weight, gender, dailyCalorieGoal, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.age == this.age &&
          other.weight == this.weight &&
          other.gender == this.gender &&
          other.dailyCalorieGoal == this.dailyCalorieGoal &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<int> id;
  final Value<int> age;
  final Value<double> weight;
  final Value<String> gender;
  final Value<int> dailyCalorieGoal;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.age = const Value.absent(),
    this.weight = const Value.absent(),
    this.gender = const Value.absent(),
    this.dailyCalorieGoal = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    required int age,
    required double weight,
    required String gender,
    required int dailyCalorieGoal,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : age = Value(age),
        weight = Value(weight),
        gender = Value(gender),
        dailyCalorieGoal = Value(dailyCalorieGoal);
  static Insertable<UserProfile> custom({
    Expression<int>? id,
    Expression<int>? age,
    Expression<double>? weight,
    Expression<String>? gender,
    Expression<int>? dailyCalorieGoal,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (age != null) 'age': age,
      if (weight != null) 'weight': weight,
      if (gender != null) 'gender': gender,
      if (dailyCalorieGoal != null) 'daily_calorie_goal': dailyCalorieGoal,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserProfilesCompanion copyWith(
      {Value<int>? id,
      Value<int>? age,
      Value<double>? weight,
      Value<String>? gender,
      Value<int>? dailyCalorieGoal,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (dailyCalorieGoal.present) {
      map['daily_calorie_goal'] = Variable<int>(dailyCalorieGoal.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('age: $age, ')
          ..write('weight: $weight, ')
          ..write('gender: $gender, ')
          ..write('dailyCalorieGoal: $dailyCalorieGoal, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FoodEntriesTable extends FoodEntries
    with TableInfo<$FoodEntriesTable, FoodEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _foodNameMeta =
      const VerificationMeta('foodName');
  @override
  late final GeneratedColumn<String> foodName = GeneratedColumn<String>(
      'food_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _caloriesMeta =
      const VerificationMeta('calories');
  @override
  late final GeneratedColumn<int> calories = GeneratedColumn<int>(
      'calories', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _proteinGMeta =
      const VerificationMeta('proteinG');
  @override
  late final GeneratedColumn<double> proteinG = GeneratedColumn<double>(
      'protein_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _carbsGMeta = const VerificationMeta('carbsG');
  @override
  late final GeneratedColumn<double> carbsG = GeneratedColumn<double>(
      'carbs_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fatGMeta = const VerificationMeta('fatG');
  @override
  late final GeneratedColumn<double> fatG = GeneratedColumn<double>(
      'fat_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fiberGMeta = const VerificationMeta('fiberG');
  @override
  late final GeneratedColumn<double> fiberG = GeneratedColumn<double>(
      'fiber_g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _vitaminAMcgMeta =
      const VerificationMeta('vitaminAMcg');
  @override
  late final GeneratedColumn<double> vitaminAMcg = GeneratedColumn<double>(
      'vitamin_a_mcg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _vitaminCMgMeta =
      const VerificationMeta('vitaminCMg');
  @override
  late final GeneratedColumn<double> vitaminCMg = GeneratedColumn<double>(
      'vitamin_c_mg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _vitaminDMcgMeta =
      const VerificationMeta('vitaminDMcg');
  @override
  late final GeneratedColumn<double> vitaminDMcg = GeneratedColumn<double>(
      'vitamin_d_mcg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _ironMgMeta = const VerificationMeta('ironMg');
  @override
  late final GeneratedColumn<double> ironMg = GeneratedColumn<double>(
      'iron_mg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _calciumMgMeta =
      const VerificationMeta('calciumMg');
  @override
  late final GeneratedColumn<double> calciumMg = GeneratedColumn<double>(
      'calcium_mg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _magnesiumMgMeta =
      const VerificationMeta('magnesiumMg');
  @override
  late final GeneratedColumn<double> magnesiumMg = GeneratedColumn<double>(
      'magnesium_mg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _potassiumMgMeta =
      const VerificationMeta('potassiumMg');
  @override
  late final GeneratedColumn<double> potassiumMg = GeneratedColumn<double>(
      'potassium_mg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _quantityDescriptionMeta =
      const VerificationMeta('quantityDescription');
  @override
  late final GeneratedColumn<String> quantityDescription =
      GeneratedColumn<String>('quantity_description', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _portionMultiplierMeta =
      const VerificationMeta('portionMultiplier');
  @override
  late final GeneratedColumn<double> portionMultiplier =
      GeneratedColumn<double>('portion_multiplier', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(1.0));
  static const VerificationMeta _confidenceScoreMeta =
      const VerificationMeta('confidenceScore');
  @override
  late final GeneratedColumn<int> confidenceScore = GeneratedColumn<int>(
      'confidence_score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _healthTipMeta =
      const VerificationMeta('healthTip');
  @override
  late final GeneratedColumn<String> healthTip = GeneratedColumn<String>(
      'health_tip', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isApprovedMeta =
      const VerificationMeta('isApproved');
  @override
  late final GeneratedColumn<bool> isApproved = GeneratedColumn<bool>(
      'is_approved', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_approved" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _capturedAtMeta =
      const VerificationMeta('capturedAt');
  @override
  late final GeneratedColumn<DateTime> capturedAt = GeneratedColumn<DateTime>(
      'captured_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _approvedAtMeta =
      const VerificationMeta('approvedAt');
  @override
  late final GeneratedColumn<DateTime> approvedAt = GeneratedColumn<DateTime>(
      'approved_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        foodName,
        imagePath,
        calories,
        proteinG,
        carbsG,
        fatG,
        fiberG,
        vitaminAMcg,
        vitaminCMg,
        vitaminDMcg,
        ironMg,
        calciumMg,
        magnesiumMg,
        potassiumMg,
        quantityDescription,
        portionMultiplier,
        confidenceScore,
        healthTip,
        isApproved,
        capturedAt,
        approvedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_entries';
  @override
  VerificationContext validateIntegrity(Insertable<FoodEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('food_name')) {
      context.handle(_foodNameMeta,
          foodName.isAcceptableOrUnknown(data['food_name']!, _foodNameMeta));
    } else if (isInserting) {
      context.missing(_foodNameMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(_caloriesMeta,
          calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta));
    } else if (isInserting) {
      context.missing(_caloriesMeta);
    }
    if (data.containsKey('protein_g')) {
      context.handle(_proteinGMeta,
          proteinG.isAcceptableOrUnknown(data['protein_g']!, _proteinGMeta));
    } else if (isInserting) {
      context.missing(_proteinGMeta);
    }
    if (data.containsKey('carbs_g')) {
      context.handle(_carbsGMeta,
          carbsG.isAcceptableOrUnknown(data['carbs_g']!, _carbsGMeta));
    } else if (isInserting) {
      context.missing(_carbsGMeta);
    }
    if (data.containsKey('fat_g')) {
      context.handle(
          _fatGMeta, fatG.isAcceptableOrUnknown(data['fat_g']!, _fatGMeta));
    } else if (isInserting) {
      context.missing(_fatGMeta);
    }
    if (data.containsKey('fiber_g')) {
      context.handle(_fiberGMeta,
          fiberG.isAcceptableOrUnknown(data['fiber_g']!, _fiberGMeta));
    }
    if (data.containsKey('vitamin_a_mcg')) {
      context.handle(
          _vitaminAMcgMeta,
          vitaminAMcg.isAcceptableOrUnknown(
              data['vitamin_a_mcg']!, _vitaminAMcgMeta));
    }
    if (data.containsKey('vitamin_c_mg')) {
      context.handle(
          _vitaminCMgMeta,
          vitaminCMg.isAcceptableOrUnknown(
              data['vitamin_c_mg']!, _vitaminCMgMeta));
    }
    if (data.containsKey('vitamin_d_mcg')) {
      context.handle(
          _vitaminDMcgMeta,
          vitaminDMcg.isAcceptableOrUnknown(
              data['vitamin_d_mcg']!, _vitaminDMcgMeta));
    }
    if (data.containsKey('iron_mg')) {
      context.handle(_ironMgMeta,
          ironMg.isAcceptableOrUnknown(data['iron_mg']!, _ironMgMeta));
    }
    if (data.containsKey('calcium_mg')) {
      context.handle(_calciumMgMeta,
          calciumMg.isAcceptableOrUnknown(data['calcium_mg']!, _calciumMgMeta));
    }
    if (data.containsKey('magnesium_mg')) {
      context.handle(
          _magnesiumMgMeta,
          magnesiumMg.isAcceptableOrUnknown(
              data['magnesium_mg']!, _magnesiumMgMeta));
    }
    if (data.containsKey('potassium_mg')) {
      context.handle(
          _potassiumMgMeta,
          potassiumMg.isAcceptableOrUnknown(
              data['potassium_mg']!, _potassiumMgMeta));
    }
    if (data.containsKey('quantity_description')) {
      context.handle(
          _quantityDescriptionMeta,
          quantityDescription.isAcceptableOrUnknown(
              data['quantity_description']!, _quantityDescriptionMeta));
    } else if (isInserting) {
      context.missing(_quantityDescriptionMeta);
    }
    if (data.containsKey('portion_multiplier')) {
      context.handle(
          _portionMultiplierMeta,
          portionMultiplier.isAcceptableOrUnknown(
              data['portion_multiplier']!, _portionMultiplierMeta));
    }
    if (data.containsKey('confidence_score')) {
      context.handle(
          _confidenceScoreMeta,
          confidenceScore.isAcceptableOrUnknown(
              data['confidence_score']!, _confidenceScoreMeta));
    } else if (isInserting) {
      context.missing(_confidenceScoreMeta);
    }
    if (data.containsKey('health_tip')) {
      context.handle(_healthTipMeta,
          healthTip.isAcceptableOrUnknown(data['health_tip']!, _healthTipMeta));
    }
    if (data.containsKey('is_approved')) {
      context.handle(
          _isApprovedMeta,
          isApproved.isAcceptableOrUnknown(
              data['is_approved']!, _isApprovedMeta));
    }
    if (data.containsKey('captured_at')) {
      context.handle(
          _capturedAtMeta,
          capturedAt.isAcceptableOrUnknown(
              data['captured_at']!, _capturedAtMeta));
    }
    if (data.containsKey('approved_at')) {
      context.handle(
          _approvedAtMeta,
          approvedAt.isAcceptableOrUnknown(
              data['approved_at']!, _approvedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      foodName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_name'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      calories: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}calories'])!,
      proteinG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}protein_g'])!,
      carbsG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}carbs_g'])!,
      fatG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat_g'])!,
      fiberG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fiber_g']),
      vitaminAMcg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}vitamin_a_mcg']),
      vitaminCMg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}vitamin_c_mg']),
      vitaminDMcg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}vitamin_d_mcg']),
      ironMg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}iron_mg']),
      calciumMg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}calcium_mg']),
      magnesiumMg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}magnesium_mg']),
      potassiumMg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}potassium_mg']),
      quantityDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}quantity_description'])!,
      portionMultiplier: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}portion_multiplier'])!,
      confidenceScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}confidence_score'])!,
      healthTip: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}health_tip']),
      isApproved: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_approved'])!,
      capturedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}captured_at'])!,
      approvedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}approved_at']),
    );
  }

  @override
  $FoodEntriesTable createAlias(String alias) {
    return $FoodEntriesTable(attachedDatabase, alias);
  }
}

class FoodEntry extends DataClass implements Insertable<FoodEntry> {
  final int id;
  final String foodName;
  final String imagePath;
  final int calories;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final double? fiberG;
  final double? vitaminAMcg;
  final double? vitaminCMg;
  final double? vitaminDMcg;
  final double? ironMg;
  final double? calciumMg;
  final double? magnesiumMg;
  final double? potassiumMg;
  final String quantityDescription;
  final double portionMultiplier;
  final int confidenceScore;
  final String? healthTip;
  final bool isApproved;
  final DateTime capturedAt;
  final DateTime? approvedAt;
  const FoodEntry(
      {required this.id,
      required this.foodName,
      required this.imagePath,
      required this.calories,
      required this.proteinG,
      required this.carbsG,
      required this.fatG,
      this.fiberG,
      this.vitaminAMcg,
      this.vitaminCMg,
      this.vitaminDMcg,
      this.ironMg,
      this.calciumMg,
      this.magnesiumMg,
      this.potassiumMg,
      required this.quantityDescription,
      required this.portionMultiplier,
      required this.confidenceScore,
      this.healthTip,
      required this.isApproved,
      required this.capturedAt,
      this.approvedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['food_name'] = Variable<String>(foodName);
    map['image_path'] = Variable<String>(imagePath);
    map['calories'] = Variable<int>(calories);
    map['protein_g'] = Variable<double>(proteinG);
    map['carbs_g'] = Variable<double>(carbsG);
    map['fat_g'] = Variable<double>(fatG);
    if (!nullToAbsent || fiberG != null) {
      map['fiber_g'] = Variable<double>(fiberG);
    }
    if (!nullToAbsent || vitaminAMcg != null) {
      map['vitamin_a_mcg'] = Variable<double>(vitaminAMcg);
    }
    if (!nullToAbsent || vitaminCMg != null) {
      map['vitamin_c_mg'] = Variable<double>(vitaminCMg);
    }
    if (!nullToAbsent || vitaminDMcg != null) {
      map['vitamin_d_mcg'] = Variable<double>(vitaminDMcg);
    }
    if (!nullToAbsent || ironMg != null) {
      map['iron_mg'] = Variable<double>(ironMg);
    }
    if (!nullToAbsent || calciumMg != null) {
      map['calcium_mg'] = Variable<double>(calciumMg);
    }
    if (!nullToAbsent || magnesiumMg != null) {
      map['magnesium_mg'] = Variable<double>(magnesiumMg);
    }
    if (!nullToAbsent || potassiumMg != null) {
      map['potassium_mg'] = Variable<double>(potassiumMg);
    }
    map['quantity_description'] = Variable<String>(quantityDescription);
    map['portion_multiplier'] = Variable<double>(portionMultiplier);
    map['confidence_score'] = Variable<int>(confidenceScore);
    if (!nullToAbsent || healthTip != null) {
      map['health_tip'] = Variable<String>(healthTip);
    }
    map['is_approved'] = Variable<bool>(isApproved);
    map['captured_at'] = Variable<DateTime>(capturedAt);
    if (!nullToAbsent || approvedAt != null) {
      map['approved_at'] = Variable<DateTime>(approvedAt);
    }
    return map;
  }

  FoodEntriesCompanion toCompanion(bool nullToAbsent) {
    return FoodEntriesCompanion(
      id: Value(id),
      foodName: Value(foodName),
      imagePath: Value(imagePath),
      calories: Value(calories),
      proteinG: Value(proteinG),
      carbsG: Value(carbsG),
      fatG: Value(fatG),
      fiberG:
          fiberG == null && nullToAbsent ? const Value.absent() : Value(fiberG),
      vitaminAMcg: vitaminAMcg == null && nullToAbsent
          ? const Value.absent()
          : Value(vitaminAMcg),
      vitaminCMg: vitaminCMg == null && nullToAbsent
          ? const Value.absent()
          : Value(vitaminCMg),
      vitaminDMcg: vitaminDMcg == null && nullToAbsent
          ? const Value.absent()
          : Value(vitaminDMcg),
      ironMg:
          ironMg == null && nullToAbsent ? const Value.absent() : Value(ironMg),
      calciumMg: calciumMg == null && nullToAbsent
          ? const Value.absent()
          : Value(calciumMg),
      magnesiumMg: magnesiumMg == null && nullToAbsent
          ? const Value.absent()
          : Value(magnesiumMg),
      potassiumMg: potassiumMg == null && nullToAbsent
          ? const Value.absent()
          : Value(potassiumMg),
      quantityDescription: Value(quantityDescription),
      portionMultiplier: Value(portionMultiplier),
      confidenceScore: Value(confidenceScore),
      healthTip: healthTip == null && nullToAbsent
          ? const Value.absent()
          : Value(healthTip),
      isApproved: Value(isApproved),
      capturedAt: Value(capturedAt),
      approvedAt: approvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(approvedAt),
    );
  }

  factory FoodEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodEntry(
      id: serializer.fromJson<int>(json['id']),
      foodName: serializer.fromJson<String>(json['foodName']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      calories: serializer.fromJson<int>(json['calories']),
      proteinG: serializer.fromJson<double>(json['proteinG']),
      carbsG: serializer.fromJson<double>(json['carbsG']),
      fatG: serializer.fromJson<double>(json['fatG']),
      fiberG: serializer.fromJson<double?>(json['fiberG']),
      vitaminAMcg: serializer.fromJson<double?>(json['vitaminAMcg']),
      vitaminCMg: serializer.fromJson<double?>(json['vitaminCMg']),
      vitaminDMcg: serializer.fromJson<double?>(json['vitaminDMcg']),
      ironMg: serializer.fromJson<double?>(json['ironMg']),
      calciumMg: serializer.fromJson<double?>(json['calciumMg']),
      magnesiumMg: serializer.fromJson<double?>(json['magnesiumMg']),
      potassiumMg: serializer.fromJson<double?>(json['potassiumMg']),
      quantityDescription:
          serializer.fromJson<String>(json['quantityDescription']),
      portionMultiplier: serializer.fromJson<double>(json['portionMultiplier']),
      confidenceScore: serializer.fromJson<int>(json['confidenceScore']),
      healthTip: serializer.fromJson<String?>(json['healthTip']),
      isApproved: serializer.fromJson<bool>(json['isApproved']),
      capturedAt: serializer.fromJson<DateTime>(json['capturedAt']),
      approvedAt: serializer.fromJson<DateTime?>(json['approvedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'foodName': serializer.toJson<String>(foodName),
      'imagePath': serializer.toJson<String>(imagePath),
      'calories': serializer.toJson<int>(calories),
      'proteinG': serializer.toJson<double>(proteinG),
      'carbsG': serializer.toJson<double>(carbsG),
      'fatG': serializer.toJson<double>(fatG),
      'fiberG': serializer.toJson<double?>(fiberG),
      'vitaminAMcg': serializer.toJson<double?>(vitaminAMcg),
      'vitaminCMg': serializer.toJson<double?>(vitaminCMg),
      'vitaminDMcg': serializer.toJson<double?>(vitaminDMcg),
      'ironMg': serializer.toJson<double?>(ironMg),
      'calciumMg': serializer.toJson<double?>(calciumMg),
      'magnesiumMg': serializer.toJson<double?>(magnesiumMg),
      'potassiumMg': serializer.toJson<double?>(potassiumMg),
      'quantityDescription': serializer.toJson<String>(quantityDescription),
      'portionMultiplier': serializer.toJson<double>(portionMultiplier),
      'confidenceScore': serializer.toJson<int>(confidenceScore),
      'healthTip': serializer.toJson<String?>(healthTip),
      'isApproved': serializer.toJson<bool>(isApproved),
      'capturedAt': serializer.toJson<DateTime>(capturedAt),
      'approvedAt': serializer.toJson<DateTime?>(approvedAt),
    };
  }

  FoodEntry copyWith(
          {int? id,
          String? foodName,
          String? imagePath,
          int? calories,
          double? proteinG,
          double? carbsG,
          double? fatG,
          Value<double?> fiberG = const Value.absent(),
          Value<double?> vitaminAMcg = const Value.absent(),
          Value<double?> vitaminCMg = const Value.absent(),
          Value<double?> vitaminDMcg = const Value.absent(),
          Value<double?> ironMg = const Value.absent(),
          Value<double?> calciumMg = const Value.absent(),
          Value<double?> magnesiumMg = const Value.absent(),
          Value<double?> potassiumMg = const Value.absent(),
          String? quantityDescription,
          double? portionMultiplier,
          int? confidenceScore,
          Value<String?> healthTip = const Value.absent(),
          bool? isApproved,
          DateTime? capturedAt,
          Value<DateTime?> approvedAt = const Value.absent()}) =>
      FoodEntry(
        id: id ?? this.id,
        foodName: foodName ?? this.foodName,
        imagePath: imagePath ?? this.imagePath,
        calories: calories ?? this.calories,
        proteinG: proteinG ?? this.proteinG,
        carbsG: carbsG ?? this.carbsG,
        fatG: fatG ?? this.fatG,
        fiberG: fiberG.present ? fiberG.value : this.fiberG,
        vitaminAMcg: vitaminAMcg.present ? vitaminAMcg.value : this.vitaminAMcg,
        vitaminCMg: vitaminCMg.present ? vitaminCMg.value : this.vitaminCMg,
        vitaminDMcg: vitaminDMcg.present ? vitaminDMcg.value : this.vitaminDMcg,
        ironMg: ironMg.present ? ironMg.value : this.ironMg,
        calciumMg: calciumMg.present ? calciumMg.value : this.calciumMg,
        magnesiumMg: magnesiumMg.present ? magnesiumMg.value : this.magnesiumMg,
        potassiumMg: potassiumMg.present ? potassiumMg.value : this.potassiumMg,
        quantityDescription: quantityDescription ?? this.quantityDescription,
        portionMultiplier: portionMultiplier ?? this.portionMultiplier,
        confidenceScore: confidenceScore ?? this.confidenceScore,
        healthTip: healthTip.present ? healthTip.value : this.healthTip,
        isApproved: isApproved ?? this.isApproved,
        capturedAt: capturedAt ?? this.capturedAt,
        approvedAt: approvedAt.present ? approvedAt.value : this.approvedAt,
      );
  FoodEntry copyWithCompanion(FoodEntriesCompanion data) {
    return FoodEntry(
      id: data.id.present ? data.id.value : this.id,
      foodName: data.foodName.present ? data.foodName.value : this.foodName,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      calories: data.calories.present ? data.calories.value : this.calories,
      proteinG: data.proteinG.present ? data.proteinG.value : this.proteinG,
      carbsG: data.carbsG.present ? data.carbsG.value : this.carbsG,
      fatG: data.fatG.present ? data.fatG.value : this.fatG,
      fiberG: data.fiberG.present ? data.fiberG.value : this.fiberG,
      vitaminAMcg:
          data.vitaminAMcg.present ? data.vitaminAMcg.value : this.vitaminAMcg,
      vitaminCMg:
          data.vitaminCMg.present ? data.vitaminCMg.value : this.vitaminCMg,
      vitaminDMcg:
          data.vitaminDMcg.present ? data.vitaminDMcg.value : this.vitaminDMcg,
      ironMg: data.ironMg.present ? data.ironMg.value : this.ironMg,
      calciumMg: data.calciumMg.present ? data.calciumMg.value : this.calciumMg,
      magnesiumMg:
          data.magnesiumMg.present ? data.magnesiumMg.value : this.magnesiumMg,
      potassiumMg:
          data.potassiumMg.present ? data.potassiumMg.value : this.potassiumMg,
      quantityDescription: data.quantityDescription.present
          ? data.quantityDescription.value
          : this.quantityDescription,
      portionMultiplier: data.portionMultiplier.present
          ? data.portionMultiplier.value
          : this.portionMultiplier,
      confidenceScore: data.confidenceScore.present
          ? data.confidenceScore.value
          : this.confidenceScore,
      healthTip: data.healthTip.present ? data.healthTip.value : this.healthTip,
      isApproved:
          data.isApproved.present ? data.isApproved.value : this.isApproved,
      capturedAt:
          data.capturedAt.present ? data.capturedAt.value : this.capturedAt,
      approvedAt:
          data.approvedAt.present ? data.approvedAt.value : this.approvedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodEntry(')
          ..write('id: $id, ')
          ..write('foodName: $foodName, ')
          ..write('imagePath: $imagePath, ')
          ..write('calories: $calories, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('fiberG: $fiberG, ')
          ..write('vitaminAMcg: $vitaminAMcg, ')
          ..write('vitaminCMg: $vitaminCMg, ')
          ..write('vitaminDMcg: $vitaminDMcg, ')
          ..write('ironMg: $ironMg, ')
          ..write('calciumMg: $calciumMg, ')
          ..write('magnesiumMg: $magnesiumMg, ')
          ..write('potassiumMg: $potassiumMg, ')
          ..write('quantityDescription: $quantityDescription, ')
          ..write('portionMultiplier: $portionMultiplier, ')
          ..write('confidenceScore: $confidenceScore, ')
          ..write('healthTip: $healthTip, ')
          ..write('isApproved: $isApproved, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('approvedAt: $approvedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        foodName,
        imagePath,
        calories,
        proteinG,
        carbsG,
        fatG,
        fiberG,
        vitaminAMcg,
        vitaminCMg,
        vitaminDMcg,
        ironMg,
        calciumMg,
        magnesiumMg,
        potassiumMg,
        quantityDescription,
        portionMultiplier,
        confidenceScore,
        healthTip,
        isApproved,
        capturedAt,
        approvedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodEntry &&
          other.id == this.id &&
          other.foodName == this.foodName &&
          other.imagePath == this.imagePath &&
          other.calories == this.calories &&
          other.proteinG == this.proteinG &&
          other.carbsG == this.carbsG &&
          other.fatG == this.fatG &&
          other.fiberG == this.fiberG &&
          other.vitaminAMcg == this.vitaminAMcg &&
          other.vitaminCMg == this.vitaminCMg &&
          other.vitaminDMcg == this.vitaminDMcg &&
          other.ironMg == this.ironMg &&
          other.calciumMg == this.calciumMg &&
          other.magnesiumMg == this.magnesiumMg &&
          other.potassiumMg == this.potassiumMg &&
          other.quantityDescription == this.quantityDescription &&
          other.portionMultiplier == this.portionMultiplier &&
          other.confidenceScore == this.confidenceScore &&
          other.healthTip == this.healthTip &&
          other.isApproved == this.isApproved &&
          other.capturedAt == this.capturedAt &&
          other.approvedAt == this.approvedAt);
}

class FoodEntriesCompanion extends UpdateCompanion<FoodEntry> {
  final Value<int> id;
  final Value<String> foodName;
  final Value<String> imagePath;
  final Value<int> calories;
  final Value<double> proteinG;
  final Value<double> carbsG;
  final Value<double> fatG;
  final Value<double?> fiberG;
  final Value<double?> vitaminAMcg;
  final Value<double?> vitaminCMg;
  final Value<double?> vitaminDMcg;
  final Value<double?> ironMg;
  final Value<double?> calciumMg;
  final Value<double?> magnesiumMg;
  final Value<double?> potassiumMg;
  final Value<String> quantityDescription;
  final Value<double> portionMultiplier;
  final Value<int> confidenceScore;
  final Value<String?> healthTip;
  final Value<bool> isApproved;
  final Value<DateTime> capturedAt;
  final Value<DateTime?> approvedAt;
  const FoodEntriesCompanion({
    this.id = const Value.absent(),
    this.foodName = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.calories = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.carbsG = const Value.absent(),
    this.fatG = const Value.absent(),
    this.fiberG = const Value.absent(),
    this.vitaminAMcg = const Value.absent(),
    this.vitaminCMg = const Value.absent(),
    this.vitaminDMcg = const Value.absent(),
    this.ironMg = const Value.absent(),
    this.calciumMg = const Value.absent(),
    this.magnesiumMg = const Value.absent(),
    this.potassiumMg = const Value.absent(),
    this.quantityDescription = const Value.absent(),
    this.portionMultiplier = const Value.absent(),
    this.confidenceScore = const Value.absent(),
    this.healthTip = const Value.absent(),
    this.isApproved = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.approvedAt = const Value.absent(),
  });
  FoodEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String foodName,
    required String imagePath,
    required int calories,
    required double proteinG,
    required double carbsG,
    required double fatG,
    this.fiberG = const Value.absent(),
    this.vitaminAMcg = const Value.absent(),
    this.vitaminCMg = const Value.absent(),
    this.vitaminDMcg = const Value.absent(),
    this.ironMg = const Value.absent(),
    this.calciumMg = const Value.absent(),
    this.magnesiumMg = const Value.absent(),
    this.potassiumMg = const Value.absent(),
    required String quantityDescription,
    this.portionMultiplier = const Value.absent(),
    required int confidenceScore,
    this.healthTip = const Value.absent(),
    this.isApproved = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.approvedAt = const Value.absent(),
  })  : foodName = Value(foodName),
        imagePath = Value(imagePath),
        calories = Value(calories),
        proteinG = Value(proteinG),
        carbsG = Value(carbsG),
        fatG = Value(fatG),
        quantityDescription = Value(quantityDescription),
        confidenceScore = Value(confidenceScore);
  static Insertable<FoodEntry> custom({
    Expression<int>? id,
    Expression<String>? foodName,
    Expression<String>? imagePath,
    Expression<int>? calories,
    Expression<double>? proteinG,
    Expression<double>? carbsG,
    Expression<double>? fatG,
    Expression<double>? fiberG,
    Expression<double>? vitaminAMcg,
    Expression<double>? vitaminCMg,
    Expression<double>? vitaminDMcg,
    Expression<double>? ironMg,
    Expression<double>? calciumMg,
    Expression<double>? magnesiumMg,
    Expression<double>? potassiumMg,
    Expression<String>? quantityDescription,
    Expression<double>? portionMultiplier,
    Expression<int>? confidenceScore,
    Expression<String>? healthTip,
    Expression<bool>? isApproved,
    Expression<DateTime>? capturedAt,
    Expression<DateTime>? approvedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodName != null) 'food_name': foodName,
      if (imagePath != null) 'image_path': imagePath,
      if (calories != null) 'calories': calories,
      if (proteinG != null) 'protein_g': proteinG,
      if (carbsG != null) 'carbs_g': carbsG,
      if (fatG != null) 'fat_g': fatG,
      if (fiberG != null) 'fiber_g': fiberG,
      if (vitaminAMcg != null) 'vitamin_a_mcg': vitaminAMcg,
      if (vitaminCMg != null) 'vitamin_c_mg': vitaminCMg,
      if (vitaminDMcg != null) 'vitamin_d_mcg': vitaminDMcg,
      if (ironMg != null) 'iron_mg': ironMg,
      if (calciumMg != null) 'calcium_mg': calciumMg,
      if (magnesiumMg != null) 'magnesium_mg': magnesiumMg,
      if (potassiumMg != null) 'potassium_mg': potassiumMg,
      if (quantityDescription != null)
        'quantity_description': quantityDescription,
      if (portionMultiplier != null) 'portion_multiplier': portionMultiplier,
      if (confidenceScore != null) 'confidence_score': confidenceScore,
      if (healthTip != null) 'health_tip': healthTip,
      if (isApproved != null) 'is_approved': isApproved,
      if (capturedAt != null) 'captured_at': capturedAt,
      if (approvedAt != null) 'approved_at': approvedAt,
    });
  }

  FoodEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? foodName,
      Value<String>? imagePath,
      Value<int>? calories,
      Value<double>? proteinG,
      Value<double>? carbsG,
      Value<double>? fatG,
      Value<double?>? fiberG,
      Value<double?>? vitaminAMcg,
      Value<double?>? vitaminCMg,
      Value<double?>? vitaminDMcg,
      Value<double?>? ironMg,
      Value<double?>? calciumMg,
      Value<double?>? magnesiumMg,
      Value<double?>? potassiumMg,
      Value<String>? quantityDescription,
      Value<double>? portionMultiplier,
      Value<int>? confidenceScore,
      Value<String?>? healthTip,
      Value<bool>? isApproved,
      Value<DateTime>? capturedAt,
      Value<DateTime?>? approvedAt}) {
    return FoodEntriesCompanion(
      id: id ?? this.id,
      foodName: foodName ?? this.foodName,
      imagePath: imagePath ?? this.imagePath,
      calories: calories ?? this.calories,
      proteinG: proteinG ?? this.proteinG,
      carbsG: carbsG ?? this.carbsG,
      fatG: fatG ?? this.fatG,
      fiberG: fiberG ?? this.fiberG,
      vitaminAMcg: vitaminAMcg ?? this.vitaminAMcg,
      vitaminCMg: vitaminCMg ?? this.vitaminCMg,
      vitaminDMcg: vitaminDMcg ?? this.vitaminDMcg,
      ironMg: ironMg ?? this.ironMg,
      calciumMg: calciumMg ?? this.calciumMg,
      magnesiumMg: magnesiumMg ?? this.magnesiumMg,
      potassiumMg: potassiumMg ?? this.potassiumMg,
      quantityDescription: quantityDescription ?? this.quantityDescription,
      portionMultiplier: portionMultiplier ?? this.portionMultiplier,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      healthTip: healthTip ?? this.healthTip,
      isApproved: isApproved ?? this.isApproved,
      capturedAt: capturedAt ?? this.capturedAt,
      approvedAt: approvedAt ?? this.approvedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (foodName.present) {
      map['food_name'] = Variable<String>(foodName.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (calories.present) {
      map['calories'] = Variable<int>(calories.value);
    }
    if (proteinG.present) {
      map['protein_g'] = Variable<double>(proteinG.value);
    }
    if (carbsG.present) {
      map['carbs_g'] = Variable<double>(carbsG.value);
    }
    if (fatG.present) {
      map['fat_g'] = Variable<double>(fatG.value);
    }
    if (fiberG.present) {
      map['fiber_g'] = Variable<double>(fiberG.value);
    }
    if (vitaminAMcg.present) {
      map['vitamin_a_mcg'] = Variable<double>(vitaminAMcg.value);
    }
    if (vitaminCMg.present) {
      map['vitamin_c_mg'] = Variable<double>(vitaminCMg.value);
    }
    if (vitaminDMcg.present) {
      map['vitamin_d_mcg'] = Variable<double>(vitaminDMcg.value);
    }
    if (ironMg.present) {
      map['iron_mg'] = Variable<double>(ironMg.value);
    }
    if (calciumMg.present) {
      map['calcium_mg'] = Variable<double>(calciumMg.value);
    }
    if (magnesiumMg.present) {
      map['magnesium_mg'] = Variable<double>(magnesiumMg.value);
    }
    if (potassiumMg.present) {
      map['potassium_mg'] = Variable<double>(potassiumMg.value);
    }
    if (quantityDescription.present) {
      map['quantity_description'] = Variable<String>(quantityDescription.value);
    }
    if (portionMultiplier.present) {
      map['portion_multiplier'] = Variable<double>(portionMultiplier.value);
    }
    if (confidenceScore.present) {
      map['confidence_score'] = Variable<int>(confidenceScore.value);
    }
    if (healthTip.present) {
      map['health_tip'] = Variable<String>(healthTip.value);
    }
    if (isApproved.present) {
      map['is_approved'] = Variable<bool>(isApproved.value);
    }
    if (capturedAt.present) {
      map['captured_at'] = Variable<DateTime>(capturedAt.value);
    }
    if (approvedAt.present) {
      map['approved_at'] = Variable<DateTime>(approvedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodEntriesCompanion(')
          ..write('id: $id, ')
          ..write('foodName: $foodName, ')
          ..write('imagePath: $imagePath, ')
          ..write('calories: $calories, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('fiberG: $fiberG, ')
          ..write('vitaminAMcg: $vitaminAMcg, ')
          ..write('vitaminCMg: $vitaminCMg, ')
          ..write('vitaminDMcg: $vitaminDMcg, ')
          ..write('ironMg: $ironMg, ')
          ..write('calciumMg: $calciumMg, ')
          ..write('magnesiumMg: $magnesiumMg, ')
          ..write('potassiumMg: $potassiumMg, ')
          ..write('quantityDescription: $quantityDescription, ')
          ..write('portionMultiplier: $portionMultiplier, ')
          ..write('confidenceScore: $confidenceScore, ')
          ..write('healthTip: $healthTip, ')
          ..write('isApproved: $isApproved, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('approvedAt: $approvedAt')
          ..write(')'))
        .toString();
  }
}

class $PendingAnalysisTable extends PendingAnalysis
    with TableInfo<$PendingAnalysisTable, PendingAnalysi> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingAnalysisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isProcessingMeta =
      const VerificationMeta('isProcessing');
  @override
  late final GeneratedColumn<bool> isProcessing = GeneratedColumn<bool>(
      'is_processing', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_processing" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _lastAttemptAtMeta =
      const VerificationMeta('lastAttemptAt');
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>('last_attempt_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        imagePath,
        isProcessing,
        retryCount,
        errorMessage,
        createdAt,
        lastAttemptAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_analysis';
  @override
  VerificationContext validateIntegrity(Insertable<PendingAnalysi> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('is_processing')) {
      context.handle(
          _isProcessingMeta,
          isProcessing.isAcceptableOrUnknown(
              data['is_processing']!, _isProcessingMeta));
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
          _lastAttemptAtMeta,
          lastAttemptAt.isAcceptableOrUnknown(
              data['last_attempt_at']!, _lastAttemptAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingAnalysi map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingAnalysi(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      isProcessing: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_processing'])!,
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_attempt_at']),
    );
  }

  @override
  $PendingAnalysisTable createAlias(String alias) {
    return $PendingAnalysisTable(attachedDatabase, alias);
  }
}

class PendingAnalysi extends DataClass implements Insertable<PendingAnalysi> {
  final int id;
  final String imagePath;
  final bool isProcessing;
  final int retryCount;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime? lastAttemptAt;
  const PendingAnalysi(
      {required this.id,
      required this.imagePath,
      required this.isProcessing,
      required this.retryCount,
      this.errorMessage,
      required this.createdAt,
      this.lastAttemptAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['image_path'] = Variable<String>(imagePath);
    map['is_processing'] = Variable<bool>(isProcessing);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    return map;
  }

  PendingAnalysisCompanion toCompanion(bool nullToAbsent) {
    return PendingAnalysisCompanion(
      id: Value(id),
      imagePath: Value(imagePath),
      isProcessing: Value(isProcessing),
      retryCount: Value(retryCount),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      createdAt: Value(createdAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
    );
  }

  factory PendingAnalysi.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingAnalysi(
      id: serializer.fromJson<int>(json['id']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      isProcessing: serializer.fromJson<bool>(json['isProcessing']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imagePath': serializer.toJson<String>(imagePath),
      'isProcessing': serializer.toJson<bool>(isProcessing),
      'retryCount': serializer.toJson<int>(retryCount),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
    };
  }

  PendingAnalysi copyWith(
          {int? id,
          String? imagePath,
          bool? isProcessing,
          int? retryCount,
          Value<String?> errorMessage = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> lastAttemptAt = const Value.absent()}) =>
      PendingAnalysi(
        id: id ?? this.id,
        imagePath: imagePath ?? this.imagePath,
        isProcessing: isProcessing ?? this.isProcessing,
        retryCount: retryCount ?? this.retryCount,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
        createdAt: createdAt ?? this.createdAt,
        lastAttemptAt:
            lastAttemptAt.present ? lastAttemptAt.value : this.lastAttemptAt,
      );
  PendingAnalysi copyWithCompanion(PendingAnalysisCompanion data) {
    return PendingAnalysi(
      id: data.id.present ? data.id.value : this.id,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      isProcessing: data.isProcessing.present
          ? data.isProcessing.value
          : this.isProcessing,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingAnalysi(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('isProcessing: $isProcessing, ')
          ..write('retryCount: $retryCount, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imagePath, isProcessing, retryCount,
      errorMessage, createdAt, lastAttemptAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingAnalysi &&
          other.id == this.id &&
          other.imagePath == this.imagePath &&
          other.isProcessing == this.isProcessing &&
          other.retryCount == this.retryCount &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt &&
          other.lastAttemptAt == this.lastAttemptAt);
}

class PendingAnalysisCompanion extends UpdateCompanion<PendingAnalysi> {
  final Value<int> id;
  final Value<String> imagePath;
  final Value<bool> isProcessing;
  final Value<int> retryCount;
  final Value<String?> errorMessage;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastAttemptAt;
  const PendingAnalysisCompanion({
    this.id = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.isProcessing = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
  });
  PendingAnalysisCompanion.insert({
    this.id = const Value.absent(),
    required String imagePath,
    this.isProcessing = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
  }) : imagePath = Value(imagePath);
  static Insertable<PendingAnalysi> custom({
    Expression<int>? id,
    Expression<String>? imagePath,
    Expression<bool>? isProcessing,
    Expression<int>? retryCount,
    Expression<String>? errorMessage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastAttemptAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imagePath != null) 'image_path': imagePath,
      if (isProcessing != null) 'is_processing': isProcessing,
      if (retryCount != null) 'retry_count': retryCount,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
    });
  }

  PendingAnalysisCompanion copyWith(
      {Value<int>? id,
      Value<String>? imagePath,
      Value<bool>? isProcessing,
      Value<int>? retryCount,
      Value<String?>? errorMessage,
      Value<DateTime>? createdAt,
      Value<DateTime?>? lastAttemptAt}) {
    return PendingAnalysisCompanion(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      isProcessing: isProcessing ?? this.isProcessing,
      retryCount: retryCount ?? this.retryCount,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (isProcessing.present) {
      map['is_processing'] = Variable<bool>(isProcessing.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingAnalysisCompanion(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('isProcessing: $isProcessing, ')
          ..write('retryCount: $retryCount, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt')
          ..write(')'))
        .toString();
  }
}

class $ChatMessagesTable extends ChatMessages
    with TableInfo<$ChatMessagesTable, ChatMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contextDataMeta =
      const VerificationMeta('contextData');
  @override
  late final GeneratedColumn<String> contextData = GeneratedColumn<String>(
      'context_data', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, role, message, contextData, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_messages';
  @override
  VerificationContext validateIntegrity(Insertable<ChatMessage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('context_data')) {
      context.handle(
          _contextDataMeta,
          contextData.isAcceptableOrUnknown(
              data['context_data']!, _contextDataMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      contextData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}context_data']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ChatMessagesTable createAlias(String alias) {
    return $ChatMessagesTable(attachedDatabase, alias);
  }
}

class ChatMessage extends DataClass implements Insertable<ChatMessage> {
  final int id;
  final String role;
  final String message;
  final String? contextData;
  final DateTime createdAt;
  const ChatMessage(
      {required this.id,
      required this.role,
      required this.message,
      this.contextData,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['role'] = Variable<String>(role);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || contextData != null) {
      map['context_data'] = Variable<String>(contextData);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ChatMessagesCompanion toCompanion(bool nullToAbsent) {
    return ChatMessagesCompanion(
      id: Value(id),
      role: Value(role),
      message: Value(message),
      contextData: contextData == null && nullToAbsent
          ? const Value.absent()
          : Value(contextData),
      createdAt: Value(createdAt),
    );
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessage(
      id: serializer.fromJson<int>(json['id']),
      role: serializer.fromJson<String>(json['role']),
      message: serializer.fromJson<String>(json['message']),
      contextData: serializer.fromJson<String?>(json['contextData']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'role': serializer.toJson<String>(role),
      'message': serializer.toJson<String>(message),
      'contextData': serializer.toJson<String?>(contextData),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ChatMessage copyWith(
          {int? id,
          String? role,
          String? message,
          Value<String?> contextData = const Value.absent(),
          DateTime? createdAt}) =>
      ChatMessage(
        id: id ?? this.id,
        role: role ?? this.role,
        message: message ?? this.message,
        contextData: contextData.present ? contextData.value : this.contextData,
        createdAt: createdAt ?? this.createdAt,
      );
  ChatMessage copyWithCompanion(ChatMessagesCompanion data) {
    return ChatMessage(
      id: data.id.present ? data.id.value : this.id,
      role: data.role.present ? data.role.value : this.role,
      message: data.message.present ? data.message.value : this.message,
      contextData:
          data.contextData.present ? data.contextData.value : this.contextData,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessage(')
          ..write('id: $id, ')
          ..write('role: $role, ')
          ..write('message: $message, ')
          ..write('contextData: $contextData, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, role, message, contextData, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessage &&
          other.id == this.id &&
          other.role == this.role &&
          other.message == this.message &&
          other.contextData == this.contextData &&
          other.createdAt == this.createdAt);
}

class ChatMessagesCompanion extends UpdateCompanion<ChatMessage> {
  final Value<int> id;
  final Value<String> role;
  final Value<String> message;
  final Value<String?> contextData;
  final Value<DateTime> createdAt;
  const ChatMessagesCompanion({
    this.id = const Value.absent(),
    this.role = const Value.absent(),
    this.message = const Value.absent(),
    this.contextData = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ChatMessagesCompanion.insert({
    this.id = const Value.absent(),
    required String role,
    required String message,
    this.contextData = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : role = Value(role),
        message = Value(message);
  static Insertable<ChatMessage> custom({
    Expression<int>? id,
    Expression<String>? role,
    Expression<String>? message,
    Expression<String>? contextData,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (role != null) 'role': role,
      if (message != null) 'message': message,
      if (contextData != null) 'context_data': contextData,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ChatMessagesCompanion copyWith(
      {Value<int>? id,
      Value<String>? role,
      Value<String>? message,
      Value<String?>? contextData,
      Value<DateTime>? createdAt}) {
    return ChatMessagesCompanion(
      id: id ?? this.id,
      role: role ?? this.role,
      message: message ?? this.message,
      contextData: contextData ?? this.contextData,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (contextData.present) {
      map['context_data'] = Variable<String>(contextData.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessagesCompanion(')
          ..write('id: $id, ')
          ..write('role: $role, ')
          ..write('message: $message, ')
          ..write('contextData: $contextData, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DailyNutritionSummaryTable extends DailyNutritionSummary
    with TableInfo<$DailyNutritionSummaryTable, DailyNutritionSummaryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyNutritionSummaryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _totalCaloriesMeta =
      const VerificationMeta('totalCalories');
  @override
  late final GeneratedColumn<int> totalCalories = GeneratedColumn<int>(
      'total_calories', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalProteinGMeta =
      const VerificationMeta('totalProteinG');
  @override
  late final GeneratedColumn<double> totalProteinG = GeneratedColumn<double>(
      'total_protein_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalCarbsGMeta =
      const VerificationMeta('totalCarbsG');
  @override
  late final GeneratedColumn<double> totalCarbsG = GeneratedColumn<double>(
      'total_carbs_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalFatGMeta =
      const VerificationMeta('totalFatG');
  @override
  late final GeneratedColumn<double> totalFatG = GeneratedColumn<double>(
      'total_fat_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalFiberGMeta =
      const VerificationMeta('totalFiberG');
  @override
  late final GeneratedColumn<double> totalFiberG = GeneratedColumn<double>(
      'total_fiber_g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalVitaminAMcgMeta =
      const VerificationMeta('totalVitaminAMcg');
  @override
  late final GeneratedColumn<double> totalVitaminAMcg = GeneratedColumn<double>(
      'total_vitamin_a_mcg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalVitaminCMgMeta =
      const VerificationMeta('totalVitaminCMg');
  @override
  late final GeneratedColumn<double> totalVitaminCMg = GeneratedColumn<double>(
      'total_vitamin_c_mg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalVitaminDMcgMeta =
      const VerificationMeta('totalVitaminDMcg');
  @override
  late final GeneratedColumn<double> totalVitaminDMcg = GeneratedColumn<double>(
      'total_vitamin_d_mcg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalIronMgMeta =
      const VerificationMeta('totalIronMg');
  @override
  late final GeneratedColumn<double> totalIronMg = GeneratedColumn<double>(
      'total_iron_mg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalCalciumMgMeta =
      const VerificationMeta('totalCalciumMg');
  @override
  late final GeneratedColumn<double> totalCalciumMg = GeneratedColumn<double>(
      'total_calcium_mg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalMagnesiumMgMeta =
      const VerificationMeta('totalMagnesiumMg');
  @override
  late final GeneratedColumn<double> totalMagnesiumMg = GeneratedColumn<double>(
      'total_magnesium_mg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalPotassiumMgMeta =
      const VerificationMeta('totalPotassiumMg');
  @override
  late final GeneratedColumn<double> totalPotassiumMg = GeneratedColumn<double>(
      'total_potassium_mg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _mealCountMeta =
      const VerificationMeta('mealCount');
  @override
  late final GeneratedColumn<int> mealCount = GeneratedColumn<int>(
      'meal_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        totalCalories,
        totalProteinG,
        totalCarbsG,
        totalFatG,
        totalFiberG,
        totalVitaminAMcg,
        totalVitaminCMg,
        totalVitaminDMcg,
        totalIronMg,
        totalCalciumMg,
        totalMagnesiumMg,
        totalPotassiumMg,
        mealCount,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_nutrition_summary';
  @override
  VerificationContext validateIntegrity(
      Insertable<DailyNutritionSummaryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('total_calories')) {
      context.handle(
          _totalCaloriesMeta,
          totalCalories.isAcceptableOrUnknown(
              data['total_calories']!, _totalCaloriesMeta));
    } else if (isInserting) {
      context.missing(_totalCaloriesMeta);
    }
    if (data.containsKey('total_protein_g')) {
      context.handle(
          _totalProteinGMeta,
          totalProteinG.isAcceptableOrUnknown(
              data['total_protein_g']!, _totalProteinGMeta));
    } else if (isInserting) {
      context.missing(_totalProteinGMeta);
    }
    if (data.containsKey('total_carbs_g')) {
      context.handle(
          _totalCarbsGMeta,
          totalCarbsG.isAcceptableOrUnknown(
              data['total_carbs_g']!, _totalCarbsGMeta));
    } else if (isInserting) {
      context.missing(_totalCarbsGMeta);
    }
    if (data.containsKey('total_fat_g')) {
      context.handle(
          _totalFatGMeta,
          totalFatG.isAcceptableOrUnknown(
              data['total_fat_g']!, _totalFatGMeta));
    } else if (isInserting) {
      context.missing(_totalFatGMeta);
    }
    if (data.containsKey('total_fiber_g')) {
      context.handle(
          _totalFiberGMeta,
          totalFiberG.isAcceptableOrUnknown(
              data['total_fiber_g']!, _totalFiberGMeta));
    } else if (isInserting) {
      context.missing(_totalFiberGMeta);
    }
    if (data.containsKey('total_vitamin_a_mcg')) {
      context.handle(
          _totalVitaminAMcgMeta,
          totalVitaminAMcg.isAcceptableOrUnknown(
              data['total_vitamin_a_mcg']!, _totalVitaminAMcgMeta));
    } else if (isInserting) {
      context.missing(_totalVitaminAMcgMeta);
    }
    if (data.containsKey('total_vitamin_c_mg')) {
      context.handle(
          _totalVitaminCMgMeta,
          totalVitaminCMg.isAcceptableOrUnknown(
              data['total_vitamin_c_mg']!, _totalVitaminCMgMeta));
    } else if (isInserting) {
      context.missing(_totalVitaminCMgMeta);
    }
    if (data.containsKey('total_vitamin_d_mcg')) {
      context.handle(
          _totalVitaminDMcgMeta,
          totalVitaminDMcg.isAcceptableOrUnknown(
              data['total_vitamin_d_mcg']!, _totalVitaminDMcgMeta));
    } else if (isInserting) {
      context.missing(_totalVitaminDMcgMeta);
    }
    if (data.containsKey('total_iron_mg')) {
      context.handle(
          _totalIronMgMeta,
          totalIronMg.isAcceptableOrUnknown(
              data['total_iron_mg']!, _totalIronMgMeta));
    } else if (isInserting) {
      context.missing(_totalIronMgMeta);
    }
    if (data.containsKey('total_calcium_mg')) {
      context.handle(
          _totalCalciumMgMeta,
          totalCalciumMg.isAcceptableOrUnknown(
              data['total_calcium_mg']!, _totalCalciumMgMeta));
    } else if (isInserting) {
      context.missing(_totalCalciumMgMeta);
    }
    if (data.containsKey('total_magnesium_mg')) {
      context.handle(
          _totalMagnesiumMgMeta,
          totalMagnesiumMg.isAcceptableOrUnknown(
              data['total_magnesium_mg']!, _totalMagnesiumMgMeta));
    } else if (isInserting) {
      context.missing(_totalMagnesiumMgMeta);
    }
    if (data.containsKey('total_potassium_mg')) {
      context.handle(
          _totalPotassiumMgMeta,
          totalPotassiumMg.isAcceptableOrUnknown(
              data['total_potassium_mg']!, _totalPotassiumMgMeta));
    } else if (isInserting) {
      context.missing(_totalPotassiumMgMeta);
    }
    if (data.containsKey('meal_count')) {
      context.handle(_mealCountMeta,
          mealCount.isAcceptableOrUnknown(data['meal_count']!, _mealCountMeta));
    } else if (isInserting) {
      context.missing(_mealCountMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {date},
      ];
  @override
  DailyNutritionSummaryData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyNutritionSummaryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      totalCalories: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_calories'])!,
      totalProteinG: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_protein_g'])!,
      totalCarbsG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_carbs_g'])!,
      totalFatG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_fat_g'])!,
      totalFiberG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_fiber_g'])!,
      totalVitaminAMcg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_vitamin_a_mcg'])!,
      totalVitaminCMg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_vitamin_c_mg'])!,
      totalVitaminDMcg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_vitamin_d_mcg'])!,
      totalIronMg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_iron_mg'])!,
      totalCalciumMg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_calcium_mg'])!,
      totalMagnesiumMg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_magnesium_mg'])!,
      totalPotassiumMg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_potassium_mg'])!,
      mealCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meal_count'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DailyNutritionSummaryTable createAlias(String alias) {
    return $DailyNutritionSummaryTable(attachedDatabase, alias);
  }
}

class DailyNutritionSummaryData extends DataClass
    implements Insertable<DailyNutritionSummaryData> {
  final int id;
  final DateTime date;
  final int totalCalories;
  final double totalProteinG;
  final double totalCarbsG;
  final double totalFatG;
  final double totalFiberG;
  final double totalVitaminAMcg;
  final double totalVitaminCMg;
  final double totalVitaminDMcg;
  final double totalIronMg;
  final double totalCalciumMg;
  final double totalMagnesiumMg;
  final double totalPotassiumMg;
  final int mealCount;
  final DateTime updatedAt;
  const DailyNutritionSummaryData(
      {required this.id,
      required this.date,
      required this.totalCalories,
      required this.totalProteinG,
      required this.totalCarbsG,
      required this.totalFatG,
      required this.totalFiberG,
      required this.totalVitaminAMcg,
      required this.totalVitaminCMg,
      required this.totalVitaminDMcg,
      required this.totalIronMg,
      required this.totalCalciumMg,
      required this.totalMagnesiumMg,
      required this.totalPotassiumMg,
      required this.mealCount,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['total_calories'] = Variable<int>(totalCalories);
    map['total_protein_g'] = Variable<double>(totalProteinG);
    map['total_carbs_g'] = Variable<double>(totalCarbsG);
    map['total_fat_g'] = Variable<double>(totalFatG);
    map['total_fiber_g'] = Variable<double>(totalFiberG);
    map['total_vitamin_a_mcg'] = Variable<double>(totalVitaminAMcg);
    map['total_vitamin_c_mg'] = Variable<double>(totalVitaminCMg);
    map['total_vitamin_d_mcg'] = Variable<double>(totalVitaminDMcg);
    map['total_iron_mg'] = Variable<double>(totalIronMg);
    map['total_calcium_mg'] = Variable<double>(totalCalciumMg);
    map['total_magnesium_mg'] = Variable<double>(totalMagnesiumMg);
    map['total_potassium_mg'] = Variable<double>(totalPotassiumMg);
    map['meal_count'] = Variable<int>(mealCount);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyNutritionSummaryCompanion toCompanion(bool nullToAbsent) {
    return DailyNutritionSummaryCompanion(
      id: Value(id),
      date: Value(date),
      totalCalories: Value(totalCalories),
      totalProteinG: Value(totalProteinG),
      totalCarbsG: Value(totalCarbsG),
      totalFatG: Value(totalFatG),
      totalFiberG: Value(totalFiberG),
      totalVitaminAMcg: Value(totalVitaminAMcg),
      totalVitaminCMg: Value(totalVitaminCMg),
      totalVitaminDMcg: Value(totalVitaminDMcg),
      totalIronMg: Value(totalIronMg),
      totalCalciumMg: Value(totalCalciumMg),
      totalMagnesiumMg: Value(totalMagnesiumMg),
      totalPotassiumMg: Value(totalPotassiumMg),
      mealCount: Value(mealCount),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyNutritionSummaryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyNutritionSummaryData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      totalCalories: serializer.fromJson<int>(json['totalCalories']),
      totalProteinG: serializer.fromJson<double>(json['totalProteinG']),
      totalCarbsG: serializer.fromJson<double>(json['totalCarbsG']),
      totalFatG: serializer.fromJson<double>(json['totalFatG']),
      totalFiberG: serializer.fromJson<double>(json['totalFiberG']),
      totalVitaminAMcg: serializer.fromJson<double>(json['totalVitaminAMcg']),
      totalVitaminCMg: serializer.fromJson<double>(json['totalVitaminCMg']),
      totalVitaminDMcg: serializer.fromJson<double>(json['totalVitaminDMcg']),
      totalIronMg: serializer.fromJson<double>(json['totalIronMg']),
      totalCalciumMg: serializer.fromJson<double>(json['totalCalciumMg']),
      totalMagnesiumMg: serializer.fromJson<double>(json['totalMagnesiumMg']),
      totalPotassiumMg: serializer.fromJson<double>(json['totalPotassiumMg']),
      mealCount: serializer.fromJson<int>(json['mealCount']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'totalCalories': serializer.toJson<int>(totalCalories),
      'totalProteinG': serializer.toJson<double>(totalProteinG),
      'totalCarbsG': serializer.toJson<double>(totalCarbsG),
      'totalFatG': serializer.toJson<double>(totalFatG),
      'totalFiberG': serializer.toJson<double>(totalFiberG),
      'totalVitaminAMcg': serializer.toJson<double>(totalVitaminAMcg),
      'totalVitaminCMg': serializer.toJson<double>(totalVitaminCMg),
      'totalVitaminDMcg': serializer.toJson<double>(totalVitaminDMcg),
      'totalIronMg': serializer.toJson<double>(totalIronMg),
      'totalCalciumMg': serializer.toJson<double>(totalCalciumMg),
      'totalMagnesiumMg': serializer.toJson<double>(totalMagnesiumMg),
      'totalPotassiumMg': serializer.toJson<double>(totalPotassiumMg),
      'mealCount': serializer.toJson<int>(mealCount),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyNutritionSummaryData copyWith(
          {int? id,
          DateTime? date,
          int? totalCalories,
          double? totalProteinG,
          double? totalCarbsG,
          double? totalFatG,
          double? totalFiberG,
          double? totalVitaminAMcg,
          double? totalVitaminCMg,
          double? totalVitaminDMcg,
          double? totalIronMg,
          double? totalCalciumMg,
          double? totalMagnesiumMg,
          double? totalPotassiumMg,
          int? mealCount,
          DateTime? updatedAt}) =>
      DailyNutritionSummaryData(
        id: id ?? this.id,
        date: date ?? this.date,
        totalCalories: totalCalories ?? this.totalCalories,
        totalProteinG: totalProteinG ?? this.totalProteinG,
        totalCarbsG: totalCarbsG ?? this.totalCarbsG,
        totalFatG: totalFatG ?? this.totalFatG,
        totalFiberG: totalFiberG ?? this.totalFiberG,
        totalVitaminAMcg: totalVitaminAMcg ?? this.totalVitaminAMcg,
        totalVitaminCMg: totalVitaminCMg ?? this.totalVitaminCMg,
        totalVitaminDMcg: totalVitaminDMcg ?? this.totalVitaminDMcg,
        totalIronMg: totalIronMg ?? this.totalIronMg,
        totalCalciumMg: totalCalciumMg ?? this.totalCalciumMg,
        totalMagnesiumMg: totalMagnesiumMg ?? this.totalMagnesiumMg,
        totalPotassiumMg: totalPotassiumMg ?? this.totalPotassiumMg,
        mealCount: mealCount ?? this.mealCount,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DailyNutritionSummaryData copyWithCompanion(
      DailyNutritionSummaryCompanion data) {
    return DailyNutritionSummaryData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      totalCalories: data.totalCalories.present
          ? data.totalCalories.value
          : this.totalCalories,
      totalProteinG: data.totalProteinG.present
          ? data.totalProteinG.value
          : this.totalProteinG,
      totalCarbsG:
          data.totalCarbsG.present ? data.totalCarbsG.value : this.totalCarbsG,
      totalFatG: data.totalFatG.present ? data.totalFatG.value : this.totalFatG,
      totalFiberG:
          data.totalFiberG.present ? data.totalFiberG.value : this.totalFiberG,
      totalVitaminAMcg: data.totalVitaminAMcg.present
          ? data.totalVitaminAMcg.value
          : this.totalVitaminAMcg,
      totalVitaminCMg: data.totalVitaminCMg.present
          ? data.totalVitaminCMg.value
          : this.totalVitaminCMg,
      totalVitaminDMcg: data.totalVitaminDMcg.present
          ? data.totalVitaminDMcg.value
          : this.totalVitaminDMcg,
      totalIronMg:
          data.totalIronMg.present ? data.totalIronMg.value : this.totalIronMg,
      totalCalciumMg: data.totalCalciumMg.present
          ? data.totalCalciumMg.value
          : this.totalCalciumMg,
      totalMagnesiumMg: data.totalMagnesiumMg.present
          ? data.totalMagnesiumMg.value
          : this.totalMagnesiumMg,
      totalPotassiumMg: data.totalPotassiumMg.present
          ? data.totalPotassiumMg.value
          : this.totalPotassiumMg,
      mealCount: data.mealCount.present ? data.mealCount.value : this.mealCount,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyNutritionSummaryData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('totalCalories: $totalCalories, ')
          ..write('totalProteinG: $totalProteinG, ')
          ..write('totalCarbsG: $totalCarbsG, ')
          ..write('totalFatG: $totalFatG, ')
          ..write('totalFiberG: $totalFiberG, ')
          ..write('totalVitaminAMcg: $totalVitaminAMcg, ')
          ..write('totalVitaminCMg: $totalVitaminCMg, ')
          ..write('totalVitaminDMcg: $totalVitaminDMcg, ')
          ..write('totalIronMg: $totalIronMg, ')
          ..write('totalCalciumMg: $totalCalciumMg, ')
          ..write('totalMagnesiumMg: $totalMagnesiumMg, ')
          ..write('totalPotassiumMg: $totalPotassiumMg, ')
          ..write('mealCount: $mealCount, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      date,
      totalCalories,
      totalProteinG,
      totalCarbsG,
      totalFatG,
      totalFiberG,
      totalVitaminAMcg,
      totalVitaminCMg,
      totalVitaminDMcg,
      totalIronMg,
      totalCalciumMg,
      totalMagnesiumMg,
      totalPotassiumMg,
      mealCount,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyNutritionSummaryData &&
          other.id == this.id &&
          other.date == this.date &&
          other.totalCalories == this.totalCalories &&
          other.totalProteinG == this.totalProteinG &&
          other.totalCarbsG == this.totalCarbsG &&
          other.totalFatG == this.totalFatG &&
          other.totalFiberG == this.totalFiberG &&
          other.totalVitaminAMcg == this.totalVitaminAMcg &&
          other.totalVitaminCMg == this.totalVitaminCMg &&
          other.totalVitaminDMcg == this.totalVitaminDMcg &&
          other.totalIronMg == this.totalIronMg &&
          other.totalCalciumMg == this.totalCalciumMg &&
          other.totalMagnesiumMg == this.totalMagnesiumMg &&
          other.totalPotassiumMg == this.totalPotassiumMg &&
          other.mealCount == this.mealCount &&
          other.updatedAt == this.updatedAt);
}

class DailyNutritionSummaryCompanion
    extends UpdateCompanion<DailyNutritionSummaryData> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> totalCalories;
  final Value<double> totalProteinG;
  final Value<double> totalCarbsG;
  final Value<double> totalFatG;
  final Value<double> totalFiberG;
  final Value<double> totalVitaminAMcg;
  final Value<double> totalVitaminCMg;
  final Value<double> totalVitaminDMcg;
  final Value<double> totalIronMg;
  final Value<double> totalCalciumMg;
  final Value<double> totalMagnesiumMg;
  final Value<double> totalPotassiumMg;
  final Value<int> mealCount;
  final Value<DateTime> updatedAt;
  const DailyNutritionSummaryCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.totalCalories = const Value.absent(),
    this.totalProteinG = const Value.absent(),
    this.totalCarbsG = const Value.absent(),
    this.totalFatG = const Value.absent(),
    this.totalFiberG = const Value.absent(),
    this.totalVitaminAMcg = const Value.absent(),
    this.totalVitaminCMg = const Value.absent(),
    this.totalVitaminDMcg = const Value.absent(),
    this.totalIronMg = const Value.absent(),
    this.totalCalciumMg = const Value.absent(),
    this.totalMagnesiumMg = const Value.absent(),
    this.totalPotassiumMg = const Value.absent(),
    this.mealCount = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DailyNutritionSummaryCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int totalCalories,
    required double totalProteinG,
    required double totalCarbsG,
    required double totalFatG,
    required double totalFiberG,
    required double totalVitaminAMcg,
    required double totalVitaminCMg,
    required double totalVitaminDMcg,
    required double totalIronMg,
    required double totalCalciumMg,
    required double totalMagnesiumMg,
    required double totalPotassiumMg,
    required int mealCount,
    this.updatedAt = const Value.absent(),
  })  : date = Value(date),
        totalCalories = Value(totalCalories),
        totalProteinG = Value(totalProteinG),
        totalCarbsG = Value(totalCarbsG),
        totalFatG = Value(totalFatG),
        totalFiberG = Value(totalFiberG),
        totalVitaminAMcg = Value(totalVitaminAMcg),
        totalVitaminCMg = Value(totalVitaminCMg),
        totalVitaminDMcg = Value(totalVitaminDMcg),
        totalIronMg = Value(totalIronMg),
        totalCalciumMg = Value(totalCalciumMg),
        totalMagnesiumMg = Value(totalMagnesiumMg),
        totalPotassiumMg = Value(totalPotassiumMg),
        mealCount = Value(mealCount);
  static Insertable<DailyNutritionSummaryData> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? totalCalories,
    Expression<double>? totalProteinG,
    Expression<double>? totalCarbsG,
    Expression<double>? totalFatG,
    Expression<double>? totalFiberG,
    Expression<double>? totalVitaminAMcg,
    Expression<double>? totalVitaminCMg,
    Expression<double>? totalVitaminDMcg,
    Expression<double>? totalIronMg,
    Expression<double>? totalCalciumMg,
    Expression<double>? totalMagnesiumMg,
    Expression<double>? totalPotassiumMg,
    Expression<int>? mealCount,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (totalCalories != null) 'total_calories': totalCalories,
      if (totalProteinG != null) 'total_protein_g': totalProteinG,
      if (totalCarbsG != null) 'total_carbs_g': totalCarbsG,
      if (totalFatG != null) 'total_fat_g': totalFatG,
      if (totalFiberG != null) 'total_fiber_g': totalFiberG,
      if (totalVitaminAMcg != null) 'total_vitamin_a_mcg': totalVitaminAMcg,
      if (totalVitaminCMg != null) 'total_vitamin_c_mg': totalVitaminCMg,
      if (totalVitaminDMcg != null) 'total_vitamin_d_mcg': totalVitaminDMcg,
      if (totalIronMg != null) 'total_iron_mg': totalIronMg,
      if (totalCalciumMg != null) 'total_calcium_mg': totalCalciumMg,
      if (totalMagnesiumMg != null) 'total_magnesium_mg': totalMagnesiumMg,
      if (totalPotassiumMg != null) 'total_potassium_mg': totalPotassiumMg,
      if (mealCount != null) 'meal_count': mealCount,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DailyNutritionSummaryCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<int>? totalCalories,
      Value<double>? totalProteinG,
      Value<double>? totalCarbsG,
      Value<double>? totalFatG,
      Value<double>? totalFiberG,
      Value<double>? totalVitaminAMcg,
      Value<double>? totalVitaminCMg,
      Value<double>? totalVitaminDMcg,
      Value<double>? totalIronMg,
      Value<double>? totalCalciumMg,
      Value<double>? totalMagnesiumMg,
      Value<double>? totalPotassiumMg,
      Value<int>? mealCount,
      Value<DateTime>? updatedAt}) {
    return DailyNutritionSummaryCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      totalCalories: totalCalories ?? this.totalCalories,
      totalProteinG: totalProteinG ?? this.totalProteinG,
      totalCarbsG: totalCarbsG ?? this.totalCarbsG,
      totalFatG: totalFatG ?? this.totalFatG,
      totalFiberG: totalFiberG ?? this.totalFiberG,
      totalVitaminAMcg: totalVitaminAMcg ?? this.totalVitaminAMcg,
      totalVitaminCMg: totalVitaminCMg ?? this.totalVitaminCMg,
      totalVitaminDMcg: totalVitaminDMcg ?? this.totalVitaminDMcg,
      totalIronMg: totalIronMg ?? this.totalIronMg,
      totalCalciumMg: totalCalciumMg ?? this.totalCalciumMg,
      totalMagnesiumMg: totalMagnesiumMg ?? this.totalMagnesiumMg,
      totalPotassiumMg: totalPotassiumMg ?? this.totalPotassiumMg,
      mealCount: mealCount ?? this.mealCount,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (totalCalories.present) {
      map['total_calories'] = Variable<int>(totalCalories.value);
    }
    if (totalProteinG.present) {
      map['total_protein_g'] = Variable<double>(totalProteinG.value);
    }
    if (totalCarbsG.present) {
      map['total_carbs_g'] = Variable<double>(totalCarbsG.value);
    }
    if (totalFatG.present) {
      map['total_fat_g'] = Variable<double>(totalFatG.value);
    }
    if (totalFiberG.present) {
      map['total_fiber_g'] = Variable<double>(totalFiberG.value);
    }
    if (totalVitaminAMcg.present) {
      map['total_vitamin_a_mcg'] = Variable<double>(totalVitaminAMcg.value);
    }
    if (totalVitaminCMg.present) {
      map['total_vitamin_c_mg'] = Variable<double>(totalVitaminCMg.value);
    }
    if (totalVitaminDMcg.present) {
      map['total_vitamin_d_mcg'] = Variable<double>(totalVitaminDMcg.value);
    }
    if (totalIronMg.present) {
      map['total_iron_mg'] = Variable<double>(totalIronMg.value);
    }
    if (totalCalciumMg.present) {
      map['total_calcium_mg'] = Variable<double>(totalCalciumMg.value);
    }
    if (totalMagnesiumMg.present) {
      map['total_magnesium_mg'] = Variable<double>(totalMagnesiumMg.value);
    }
    if (totalPotassiumMg.present) {
      map['total_potassium_mg'] = Variable<double>(totalPotassiumMg.value);
    }
    if (mealCount.present) {
      map['meal_count'] = Variable<int>(mealCount.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyNutritionSummaryCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('totalCalories: $totalCalories, ')
          ..write('totalProteinG: $totalProteinG, ')
          ..write('totalCarbsG: $totalCarbsG, ')
          ..write('totalFatG: $totalFatG, ')
          ..write('totalFiberG: $totalFiberG, ')
          ..write('totalVitaminAMcg: $totalVitaminAMcg, ')
          ..write('totalVitaminCMg: $totalVitaminCMg, ')
          ..write('totalVitaminDMcg: $totalVitaminDMcg, ')
          ..write('totalIronMg: $totalIronMg, ')
          ..write('totalCalciumMg: $totalCalciumMg, ')
          ..write('totalMagnesiumMg: $totalMagnesiumMg, ')
          ..write('totalPotassiumMg: $totalPotassiumMg, ')
          ..write('mealCount: $mealCount, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $FoodEntriesTable foodEntries = $FoodEntriesTable(this);
  late final $PendingAnalysisTable pendingAnalysis =
      $PendingAnalysisTable(this);
  late final $ChatMessagesTable chatMessages = $ChatMessagesTable(this);
  late final $DailyNutritionSummaryTable dailyNutritionSummary =
      $DailyNutritionSummaryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        userProfiles,
        foodEntries,
        pendingAnalysis,
        chatMessages,
        dailyNutritionSummary
      ];
}

typedef $$UserProfilesTableCreateCompanionBuilder = UserProfilesCompanion
    Function({
  Value<int> id,
  required int age,
  required double weight,
  required String gender,
  required int dailyCalorieGoal,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$UserProfilesTableUpdateCompanionBuilder = UserProfilesCompanion
    Function({
  Value<int> id,
  Value<int> age,
  Value<double> weight,
  Value<String> gender,
  Value<int> dailyCalorieGoal,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dailyCalorieGoal => $composableBuilder(
      column: $table.dailyCalorieGoal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dailyCalorieGoal => $composableBuilder(
      column: $table.dailyCalorieGoal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<int> get dailyCalorieGoal => $composableBuilder(
      column: $table.dailyCalorieGoal, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfile,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfile,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>
    ),
    UserProfile,
    PrefetchHooks Function()> {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> age = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<int> dailyCalorieGoal = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserProfilesCompanion(
            id: id,
            age: age,
            weight: weight,
            gender: gender,
            dailyCalorieGoal: dailyCalorieGoal,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int age,
            required double weight,
            required String gender,
            required int dailyCalorieGoal,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserProfilesCompanion.insert(
            id: id,
            age: age,
            weight: weight,
            gender: gender,
            dailyCalorieGoal: dailyCalorieGoal,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfile,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfile,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>
    ),
    UserProfile,
    PrefetchHooks Function()>;
typedef $$FoodEntriesTableCreateCompanionBuilder = FoodEntriesCompanion
    Function({
  Value<int> id,
  required String foodName,
  required String imagePath,
  required int calories,
  required double proteinG,
  required double carbsG,
  required double fatG,
  Value<double?> fiberG,
  Value<double?> vitaminAMcg,
  Value<double?> vitaminCMg,
  Value<double?> vitaminDMcg,
  Value<double?> ironMg,
  Value<double?> calciumMg,
  Value<double?> magnesiumMg,
  Value<double?> potassiumMg,
  required String quantityDescription,
  Value<double> portionMultiplier,
  required int confidenceScore,
  Value<String?> healthTip,
  Value<bool> isApproved,
  Value<DateTime> capturedAt,
  Value<DateTime?> approvedAt,
});
typedef $$FoodEntriesTableUpdateCompanionBuilder = FoodEntriesCompanion
    Function({
  Value<int> id,
  Value<String> foodName,
  Value<String> imagePath,
  Value<int> calories,
  Value<double> proteinG,
  Value<double> carbsG,
  Value<double> fatG,
  Value<double?> fiberG,
  Value<double?> vitaminAMcg,
  Value<double?> vitaminCMg,
  Value<double?> vitaminDMcg,
  Value<double?> ironMg,
  Value<double?> calciumMg,
  Value<double?> magnesiumMg,
  Value<double?> potassiumMg,
  Value<String> quantityDescription,
  Value<double> portionMultiplier,
  Value<int> confidenceScore,
  Value<String?> healthTip,
  Value<bool> isApproved,
  Value<DateTime> capturedAt,
  Value<DateTime?> approvedAt,
});

class $$FoodEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $FoodEntriesTable> {
  $$FoodEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodName => $composableBuilder(
      column: $table.foodName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get proteinG => $composableBuilder(
      column: $table.proteinG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get carbsG => $composableBuilder(
      column: $table.carbsG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fatG => $composableBuilder(
      column: $table.fatG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fiberG => $composableBuilder(
      column: $table.fiberG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get vitaminAMcg => $composableBuilder(
      column: $table.vitaminAMcg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get vitaminCMg => $composableBuilder(
      column: $table.vitaminCMg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get vitaminDMcg => $composableBuilder(
      column: $table.vitaminDMcg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get ironMg => $composableBuilder(
      column: $table.ironMg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get calciumMg => $composableBuilder(
      column: $table.calciumMg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get magnesiumMg => $composableBuilder(
      column: $table.magnesiumMg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get potassiumMg => $composableBuilder(
      column: $table.potassiumMg, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get quantityDescription => $composableBuilder(
      column: $table.quantityDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get portionMultiplier => $composableBuilder(
      column: $table.portionMultiplier,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get confidenceScore => $composableBuilder(
      column: $table.confidenceScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get healthTip => $composableBuilder(
      column: $table.healthTip, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isApproved => $composableBuilder(
      column: $table.isApproved, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get capturedAt => $composableBuilder(
      column: $table.capturedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get approvedAt => $composableBuilder(
      column: $table.approvedAt, builder: (column) => ColumnFilters(column));
}

class $$FoodEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodEntriesTable> {
  $$FoodEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodName => $composableBuilder(
      column: $table.foodName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get proteinG => $composableBuilder(
      column: $table.proteinG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get carbsG => $composableBuilder(
      column: $table.carbsG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fatG => $composableBuilder(
      column: $table.fatG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fiberG => $composableBuilder(
      column: $table.fiberG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get vitaminAMcg => $composableBuilder(
      column: $table.vitaminAMcg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get vitaminCMg => $composableBuilder(
      column: $table.vitaminCMg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get vitaminDMcg => $composableBuilder(
      column: $table.vitaminDMcg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get ironMg => $composableBuilder(
      column: $table.ironMg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get calciumMg => $composableBuilder(
      column: $table.calciumMg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get magnesiumMg => $composableBuilder(
      column: $table.magnesiumMg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get potassiumMg => $composableBuilder(
      column: $table.potassiumMg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get quantityDescription => $composableBuilder(
      column: $table.quantityDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get portionMultiplier => $composableBuilder(
      column: $table.portionMultiplier,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get confidenceScore => $composableBuilder(
      column: $table.confidenceScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get healthTip => $composableBuilder(
      column: $table.healthTip, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isApproved => $composableBuilder(
      column: $table.isApproved, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get capturedAt => $composableBuilder(
      column: $table.capturedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get approvedAt => $composableBuilder(
      column: $table.approvedAt, builder: (column) => ColumnOrderings(column));
}

class $$FoodEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodEntriesTable> {
  $$FoodEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get foodName =>
      $composableBuilder(column: $table.foodName, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<int> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<double> get proteinG =>
      $composableBuilder(column: $table.proteinG, builder: (column) => column);

  GeneratedColumn<double> get carbsG =>
      $composableBuilder(column: $table.carbsG, builder: (column) => column);

  GeneratedColumn<double> get fatG =>
      $composableBuilder(column: $table.fatG, builder: (column) => column);

  GeneratedColumn<double> get fiberG =>
      $composableBuilder(column: $table.fiberG, builder: (column) => column);

  GeneratedColumn<double> get vitaminAMcg => $composableBuilder(
      column: $table.vitaminAMcg, builder: (column) => column);

  GeneratedColumn<double> get vitaminCMg => $composableBuilder(
      column: $table.vitaminCMg, builder: (column) => column);

  GeneratedColumn<double> get vitaminDMcg => $composableBuilder(
      column: $table.vitaminDMcg, builder: (column) => column);

  GeneratedColumn<double> get ironMg =>
      $composableBuilder(column: $table.ironMg, builder: (column) => column);

  GeneratedColumn<double> get calciumMg =>
      $composableBuilder(column: $table.calciumMg, builder: (column) => column);

  GeneratedColumn<double> get magnesiumMg => $composableBuilder(
      column: $table.magnesiumMg, builder: (column) => column);

  GeneratedColumn<double> get potassiumMg => $composableBuilder(
      column: $table.potassiumMg, builder: (column) => column);

  GeneratedColumn<String> get quantityDescription => $composableBuilder(
      column: $table.quantityDescription, builder: (column) => column);

  GeneratedColumn<double> get portionMultiplier => $composableBuilder(
      column: $table.portionMultiplier, builder: (column) => column);

  GeneratedColumn<int> get confidenceScore => $composableBuilder(
      column: $table.confidenceScore, builder: (column) => column);

  GeneratedColumn<String> get healthTip =>
      $composableBuilder(column: $table.healthTip, builder: (column) => column);

  GeneratedColumn<bool> get isApproved => $composableBuilder(
      column: $table.isApproved, builder: (column) => column);

  GeneratedColumn<DateTime> get capturedAt => $composableBuilder(
      column: $table.capturedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get approvedAt => $composableBuilder(
      column: $table.approvedAt, builder: (column) => column);
}

class $$FoodEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoodEntriesTable,
    FoodEntry,
    $$FoodEntriesTableFilterComposer,
    $$FoodEntriesTableOrderingComposer,
    $$FoodEntriesTableAnnotationComposer,
    $$FoodEntriesTableCreateCompanionBuilder,
    $$FoodEntriesTableUpdateCompanionBuilder,
    (FoodEntry, BaseReferences<_$AppDatabase, $FoodEntriesTable, FoodEntry>),
    FoodEntry,
    PrefetchHooks Function()> {
  $$FoodEntriesTableTableManager(_$AppDatabase db, $FoodEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> foodName = const Value.absent(),
            Value<String> imagePath = const Value.absent(),
            Value<int> calories = const Value.absent(),
            Value<double> proteinG = const Value.absent(),
            Value<double> carbsG = const Value.absent(),
            Value<double> fatG = const Value.absent(),
            Value<double?> fiberG = const Value.absent(),
            Value<double?> vitaminAMcg = const Value.absent(),
            Value<double?> vitaminCMg = const Value.absent(),
            Value<double?> vitaminDMcg = const Value.absent(),
            Value<double?> ironMg = const Value.absent(),
            Value<double?> calciumMg = const Value.absent(),
            Value<double?> magnesiumMg = const Value.absent(),
            Value<double?> potassiumMg = const Value.absent(),
            Value<String> quantityDescription = const Value.absent(),
            Value<double> portionMultiplier = const Value.absent(),
            Value<int> confidenceScore = const Value.absent(),
            Value<String?> healthTip = const Value.absent(),
            Value<bool> isApproved = const Value.absent(),
            Value<DateTime> capturedAt = const Value.absent(),
            Value<DateTime?> approvedAt = const Value.absent(),
          }) =>
              FoodEntriesCompanion(
            id: id,
            foodName: foodName,
            imagePath: imagePath,
            calories: calories,
            proteinG: proteinG,
            carbsG: carbsG,
            fatG: fatG,
            fiberG: fiberG,
            vitaminAMcg: vitaminAMcg,
            vitaminCMg: vitaminCMg,
            vitaminDMcg: vitaminDMcg,
            ironMg: ironMg,
            calciumMg: calciumMg,
            magnesiumMg: magnesiumMg,
            potassiumMg: potassiumMg,
            quantityDescription: quantityDescription,
            portionMultiplier: portionMultiplier,
            confidenceScore: confidenceScore,
            healthTip: healthTip,
            isApproved: isApproved,
            capturedAt: capturedAt,
            approvedAt: approvedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String foodName,
            required String imagePath,
            required int calories,
            required double proteinG,
            required double carbsG,
            required double fatG,
            Value<double?> fiberG = const Value.absent(),
            Value<double?> vitaminAMcg = const Value.absent(),
            Value<double?> vitaminCMg = const Value.absent(),
            Value<double?> vitaminDMcg = const Value.absent(),
            Value<double?> ironMg = const Value.absent(),
            Value<double?> calciumMg = const Value.absent(),
            Value<double?> magnesiumMg = const Value.absent(),
            Value<double?> potassiumMg = const Value.absent(),
            required String quantityDescription,
            Value<double> portionMultiplier = const Value.absent(),
            required int confidenceScore,
            Value<String?> healthTip = const Value.absent(),
            Value<bool> isApproved = const Value.absent(),
            Value<DateTime> capturedAt = const Value.absent(),
            Value<DateTime?> approvedAt = const Value.absent(),
          }) =>
              FoodEntriesCompanion.insert(
            id: id,
            foodName: foodName,
            imagePath: imagePath,
            calories: calories,
            proteinG: proteinG,
            carbsG: carbsG,
            fatG: fatG,
            fiberG: fiberG,
            vitaminAMcg: vitaminAMcg,
            vitaminCMg: vitaminCMg,
            vitaminDMcg: vitaminDMcg,
            ironMg: ironMg,
            calciumMg: calciumMg,
            magnesiumMg: magnesiumMg,
            potassiumMg: potassiumMg,
            quantityDescription: quantityDescription,
            portionMultiplier: portionMultiplier,
            confidenceScore: confidenceScore,
            healthTip: healthTip,
            isApproved: isApproved,
            capturedAt: capturedAt,
            approvedAt: approvedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FoodEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FoodEntriesTable,
    FoodEntry,
    $$FoodEntriesTableFilterComposer,
    $$FoodEntriesTableOrderingComposer,
    $$FoodEntriesTableAnnotationComposer,
    $$FoodEntriesTableCreateCompanionBuilder,
    $$FoodEntriesTableUpdateCompanionBuilder,
    (FoodEntry, BaseReferences<_$AppDatabase, $FoodEntriesTable, FoodEntry>),
    FoodEntry,
    PrefetchHooks Function()>;
typedef $$PendingAnalysisTableCreateCompanionBuilder = PendingAnalysisCompanion
    Function({
  Value<int> id,
  required String imagePath,
  Value<bool> isProcessing,
  Value<int> retryCount,
  Value<String?> errorMessage,
  Value<DateTime> createdAt,
  Value<DateTime?> lastAttemptAt,
});
typedef $$PendingAnalysisTableUpdateCompanionBuilder = PendingAnalysisCompanion
    Function({
  Value<int> id,
  Value<String> imagePath,
  Value<bool> isProcessing,
  Value<int> retryCount,
  Value<String?> errorMessage,
  Value<DateTime> createdAt,
  Value<DateTime?> lastAttemptAt,
});

class $$PendingAnalysisTableFilterComposer
    extends Composer<_$AppDatabase, $PendingAnalysisTable> {
  $$PendingAnalysisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isProcessing => $composableBuilder(
      column: $table.isProcessing, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => ColumnFilters(column));
}

class $$PendingAnalysisTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingAnalysisTable> {
  $$PendingAnalysisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isProcessing => $composableBuilder(
      column: $table.isProcessing,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt,
      builder: (column) => ColumnOrderings(column));
}

class $$PendingAnalysisTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingAnalysisTable> {
  $$PendingAnalysisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<bool> get isProcessing => $composableBuilder(
      column: $table.isProcessing, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => column);
}

class $$PendingAnalysisTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PendingAnalysisTable,
    PendingAnalysi,
    $$PendingAnalysisTableFilterComposer,
    $$PendingAnalysisTableOrderingComposer,
    $$PendingAnalysisTableAnnotationComposer,
    $$PendingAnalysisTableCreateCompanionBuilder,
    $$PendingAnalysisTableUpdateCompanionBuilder,
    (
      PendingAnalysi,
      BaseReferences<_$AppDatabase, $PendingAnalysisTable, PendingAnalysi>
    ),
    PendingAnalysi,
    PrefetchHooks Function()> {
  $$PendingAnalysisTableTableManager(
      _$AppDatabase db, $PendingAnalysisTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingAnalysisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingAnalysisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingAnalysisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> imagePath = const Value.absent(),
            Value<bool> isProcessing = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
          }) =>
              PendingAnalysisCompanion(
            id: id,
            imagePath: imagePath,
            isProcessing: isProcessing,
            retryCount: retryCount,
            errorMessage: errorMessage,
            createdAt: createdAt,
            lastAttemptAt: lastAttemptAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String imagePath,
            Value<bool> isProcessing = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
          }) =>
              PendingAnalysisCompanion.insert(
            id: id,
            imagePath: imagePath,
            isProcessing: isProcessing,
            retryCount: retryCount,
            errorMessage: errorMessage,
            createdAt: createdAt,
            lastAttemptAt: lastAttemptAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PendingAnalysisTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PendingAnalysisTable,
    PendingAnalysi,
    $$PendingAnalysisTableFilterComposer,
    $$PendingAnalysisTableOrderingComposer,
    $$PendingAnalysisTableAnnotationComposer,
    $$PendingAnalysisTableCreateCompanionBuilder,
    $$PendingAnalysisTableUpdateCompanionBuilder,
    (
      PendingAnalysi,
      BaseReferences<_$AppDatabase, $PendingAnalysisTable, PendingAnalysi>
    ),
    PendingAnalysi,
    PrefetchHooks Function()>;
typedef $$ChatMessagesTableCreateCompanionBuilder = ChatMessagesCompanion
    Function({
  Value<int> id,
  required String role,
  required String message,
  Value<String?> contextData,
  Value<DateTime> createdAt,
});
typedef $$ChatMessagesTableUpdateCompanionBuilder = ChatMessagesCompanion
    Function({
  Value<int> id,
  Value<String> role,
  Value<String> message,
  Value<String?> contextData,
  Value<DateTime> createdAt,
});

class $$ChatMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contextData => $composableBuilder(
      column: $table.contextData, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$ChatMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contextData => $composableBuilder(
      column: $table.contextData, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$ChatMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get contextData => $composableBuilder(
      column: $table.contextData, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ChatMessagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatMessagesTable,
    ChatMessage,
    $$ChatMessagesTableFilterComposer,
    $$ChatMessagesTableOrderingComposer,
    $$ChatMessagesTableAnnotationComposer,
    $$ChatMessagesTableCreateCompanionBuilder,
    $$ChatMessagesTableUpdateCompanionBuilder,
    (
      ChatMessage,
      BaseReferences<_$AppDatabase, $ChatMessagesTable, ChatMessage>
    ),
    ChatMessage,
    PrefetchHooks Function()> {
  $$ChatMessagesTableTableManager(_$AppDatabase db, $ChatMessagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> message = const Value.absent(),
            Value<String?> contextData = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ChatMessagesCompanion(
            id: id,
            role: role,
            message: message,
            contextData: contextData,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String role,
            required String message,
            Value<String?> contextData = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ChatMessagesCompanion.insert(
            id: id,
            role: role,
            message: message,
            contextData: contextData,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChatMessagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatMessagesTable,
    ChatMessage,
    $$ChatMessagesTableFilterComposer,
    $$ChatMessagesTableOrderingComposer,
    $$ChatMessagesTableAnnotationComposer,
    $$ChatMessagesTableCreateCompanionBuilder,
    $$ChatMessagesTableUpdateCompanionBuilder,
    (
      ChatMessage,
      BaseReferences<_$AppDatabase, $ChatMessagesTable, ChatMessage>
    ),
    ChatMessage,
    PrefetchHooks Function()>;
typedef $$DailyNutritionSummaryTableCreateCompanionBuilder
    = DailyNutritionSummaryCompanion Function({
  Value<int> id,
  required DateTime date,
  required int totalCalories,
  required double totalProteinG,
  required double totalCarbsG,
  required double totalFatG,
  required double totalFiberG,
  required double totalVitaminAMcg,
  required double totalVitaminCMg,
  required double totalVitaminDMcg,
  required double totalIronMg,
  required double totalCalciumMg,
  required double totalMagnesiumMg,
  required double totalPotassiumMg,
  required int mealCount,
  Value<DateTime> updatedAt,
});
typedef $$DailyNutritionSummaryTableUpdateCompanionBuilder
    = DailyNutritionSummaryCompanion Function({
  Value<int> id,
  Value<DateTime> date,
  Value<int> totalCalories,
  Value<double> totalProteinG,
  Value<double> totalCarbsG,
  Value<double> totalFatG,
  Value<double> totalFiberG,
  Value<double> totalVitaminAMcg,
  Value<double> totalVitaminCMg,
  Value<double> totalVitaminDMcg,
  Value<double> totalIronMg,
  Value<double> totalCalciumMg,
  Value<double> totalMagnesiumMg,
  Value<double> totalPotassiumMg,
  Value<int> mealCount,
  Value<DateTime> updatedAt,
});

class $$DailyNutritionSummaryTableFilterComposer
    extends Composer<_$AppDatabase, $DailyNutritionSummaryTable> {
  $$DailyNutritionSummaryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalCalories => $composableBuilder(
      column: $table.totalCalories, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalProteinG => $composableBuilder(
      column: $table.totalProteinG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalCarbsG => $composableBuilder(
      column: $table.totalCarbsG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalFatG => $composableBuilder(
      column: $table.totalFatG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalFiberG => $composableBuilder(
      column: $table.totalFiberG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalVitaminAMcg => $composableBuilder(
      column: $table.totalVitaminAMcg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalVitaminCMg => $composableBuilder(
      column: $table.totalVitaminCMg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalVitaminDMcg => $composableBuilder(
      column: $table.totalVitaminDMcg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalIronMg => $composableBuilder(
      column: $table.totalIronMg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalCalciumMg => $composableBuilder(
      column: $table.totalCalciumMg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalMagnesiumMg => $composableBuilder(
      column: $table.totalMagnesiumMg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalPotassiumMg => $composableBuilder(
      column: $table.totalPotassiumMg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mealCount => $composableBuilder(
      column: $table.mealCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$DailyNutritionSummaryTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyNutritionSummaryTable> {
  $$DailyNutritionSummaryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalCalories => $composableBuilder(
      column: $table.totalCalories,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalProteinG => $composableBuilder(
      column: $table.totalProteinG,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalCarbsG => $composableBuilder(
      column: $table.totalCarbsG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalFatG => $composableBuilder(
      column: $table.totalFatG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalFiberG => $composableBuilder(
      column: $table.totalFiberG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalVitaminAMcg => $composableBuilder(
      column: $table.totalVitaminAMcg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalVitaminCMg => $composableBuilder(
      column: $table.totalVitaminCMg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalVitaminDMcg => $composableBuilder(
      column: $table.totalVitaminDMcg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalIronMg => $composableBuilder(
      column: $table.totalIronMg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalCalciumMg => $composableBuilder(
      column: $table.totalCalciumMg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalMagnesiumMg => $composableBuilder(
      column: $table.totalMagnesiumMg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalPotassiumMg => $composableBuilder(
      column: $table.totalPotassiumMg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mealCount => $composableBuilder(
      column: $table.mealCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$DailyNutritionSummaryTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyNutritionSummaryTable> {
  $$DailyNutritionSummaryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get totalCalories => $composableBuilder(
      column: $table.totalCalories, builder: (column) => column);

  GeneratedColumn<double> get totalProteinG => $composableBuilder(
      column: $table.totalProteinG, builder: (column) => column);

  GeneratedColumn<double> get totalCarbsG => $composableBuilder(
      column: $table.totalCarbsG, builder: (column) => column);

  GeneratedColumn<double> get totalFatG =>
      $composableBuilder(column: $table.totalFatG, builder: (column) => column);

  GeneratedColumn<double> get totalFiberG => $composableBuilder(
      column: $table.totalFiberG, builder: (column) => column);

  GeneratedColumn<double> get totalVitaminAMcg => $composableBuilder(
      column: $table.totalVitaminAMcg, builder: (column) => column);

  GeneratedColumn<double> get totalVitaminCMg => $composableBuilder(
      column: $table.totalVitaminCMg, builder: (column) => column);

  GeneratedColumn<double> get totalVitaminDMcg => $composableBuilder(
      column: $table.totalVitaminDMcg, builder: (column) => column);

  GeneratedColumn<double> get totalIronMg => $composableBuilder(
      column: $table.totalIronMg, builder: (column) => column);

  GeneratedColumn<double> get totalCalciumMg => $composableBuilder(
      column: $table.totalCalciumMg, builder: (column) => column);

  GeneratedColumn<double> get totalMagnesiumMg => $composableBuilder(
      column: $table.totalMagnesiumMg, builder: (column) => column);

  GeneratedColumn<double> get totalPotassiumMg => $composableBuilder(
      column: $table.totalPotassiumMg, builder: (column) => column);

  GeneratedColumn<int> get mealCount =>
      $composableBuilder(column: $table.mealCount, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DailyNutritionSummaryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyNutritionSummaryTable,
    DailyNutritionSummaryData,
    $$DailyNutritionSummaryTableFilterComposer,
    $$DailyNutritionSummaryTableOrderingComposer,
    $$DailyNutritionSummaryTableAnnotationComposer,
    $$DailyNutritionSummaryTableCreateCompanionBuilder,
    $$DailyNutritionSummaryTableUpdateCompanionBuilder,
    (
      DailyNutritionSummaryData,
      BaseReferences<_$AppDatabase, $DailyNutritionSummaryTable,
          DailyNutritionSummaryData>
    ),
    DailyNutritionSummaryData,
    PrefetchHooks Function()> {
  $$DailyNutritionSummaryTableTableManager(
      _$AppDatabase db, $DailyNutritionSummaryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyNutritionSummaryTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyNutritionSummaryTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyNutritionSummaryTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> totalCalories = const Value.absent(),
            Value<double> totalProteinG = const Value.absent(),
            Value<double> totalCarbsG = const Value.absent(),
            Value<double> totalFatG = const Value.absent(),
            Value<double> totalFiberG = const Value.absent(),
            Value<double> totalVitaminAMcg = const Value.absent(),
            Value<double> totalVitaminCMg = const Value.absent(),
            Value<double> totalVitaminDMcg = const Value.absent(),
            Value<double> totalIronMg = const Value.absent(),
            Value<double> totalCalciumMg = const Value.absent(),
            Value<double> totalMagnesiumMg = const Value.absent(),
            Value<double> totalPotassiumMg = const Value.absent(),
            Value<int> mealCount = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              DailyNutritionSummaryCompanion(
            id: id,
            date: date,
            totalCalories: totalCalories,
            totalProteinG: totalProteinG,
            totalCarbsG: totalCarbsG,
            totalFatG: totalFatG,
            totalFiberG: totalFiberG,
            totalVitaminAMcg: totalVitaminAMcg,
            totalVitaminCMg: totalVitaminCMg,
            totalVitaminDMcg: totalVitaminDMcg,
            totalIronMg: totalIronMg,
            totalCalciumMg: totalCalciumMg,
            totalMagnesiumMg: totalMagnesiumMg,
            totalPotassiumMg: totalPotassiumMg,
            mealCount: mealCount,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            required int totalCalories,
            required double totalProteinG,
            required double totalCarbsG,
            required double totalFatG,
            required double totalFiberG,
            required double totalVitaminAMcg,
            required double totalVitaminCMg,
            required double totalVitaminDMcg,
            required double totalIronMg,
            required double totalCalciumMg,
            required double totalMagnesiumMg,
            required double totalPotassiumMg,
            required int mealCount,
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              DailyNutritionSummaryCompanion.insert(
            id: id,
            date: date,
            totalCalories: totalCalories,
            totalProteinG: totalProteinG,
            totalCarbsG: totalCarbsG,
            totalFatG: totalFatG,
            totalFiberG: totalFiberG,
            totalVitaminAMcg: totalVitaminAMcg,
            totalVitaminCMg: totalVitaminCMg,
            totalVitaminDMcg: totalVitaminDMcg,
            totalIronMg: totalIronMg,
            totalCalciumMg: totalCalciumMg,
            totalMagnesiumMg: totalMagnesiumMg,
            totalPotassiumMg: totalPotassiumMg,
            mealCount: mealCount,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DailyNutritionSummaryTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $DailyNutritionSummaryTable,
        DailyNutritionSummaryData,
        $$DailyNutritionSummaryTableFilterComposer,
        $$DailyNutritionSummaryTableOrderingComposer,
        $$DailyNutritionSummaryTableAnnotationComposer,
        $$DailyNutritionSummaryTableCreateCompanionBuilder,
        $$DailyNutritionSummaryTableUpdateCompanionBuilder,
        (
          DailyNutritionSummaryData,
          BaseReferences<_$AppDatabase, $DailyNutritionSummaryTable,
              DailyNutritionSummaryData>
        ),
        DailyNutritionSummaryData,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$FoodEntriesTableTableManager get foodEntries =>
      $$FoodEntriesTableTableManager(_db, _db.foodEntries);
  $$PendingAnalysisTableTableManager get pendingAnalysis =>
      $$PendingAnalysisTableTableManager(_db, _db.pendingAnalysis);
  $$ChatMessagesTableTableManager get chatMessages =>
      $$ChatMessagesTableTableManager(_db, _db.chatMessages);
  $$DailyNutritionSummaryTableTableManager get dailyNutritionSummary =>
      $$DailyNutritionSummaryTableTableManager(_db, _db.dailyNutritionSummary);
}
