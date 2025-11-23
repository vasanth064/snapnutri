import 'dart:io';
import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';

class GeminiService {
  late final GenerativeModel _model;
  static const String _apiKey = 'YOUR_GEMINI_API_KEY_HERE'; // Replace with actual API key

  // System instruction for forcing JSON output
  static const String _systemInstruction = '''
You are a nutritionist API. Analyze the food image provided. Identify the food items and estimate the serving size.

CRITICAL: Return ONLY a valid JSON object. Do not include markdown formatting, code blocks, or any text outside the JSON.

Required JSON structure:
{
  "food_name": "String - Name of the food",
  "confidence_score": Integer (0-100),
  "quantity_description": "String - e.g., 1 bowl, 2 slices, 1 plate",
  "calories": Integer,
  "macros": {
    "protein_g": Number,
    "carbs_g": Number,
    "fat_g": Number
  },
  "micros": {
    "fiber_g": Number,
    "iron_mg": Number,
    "vitamin_c_mg": Number,
    "vitamin_a_mcg": Number,
    "vitamin_d_mcg": Number,
    "calcium_mg": Number,
    "magnesium_mg": Number,
    "potassium_mg": Number
  },
  "health_tip": "String - One sentence advice about this food"
}

If the image does not contain food, return confidence_score: 0 and food_name: "Not a food item".
''';

  GeminiService() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.4,
        topK: 32,
        topP: 1,
        maxOutputTokens: 1024,
      ),
      systemInstruction: Content.system(_systemInstruction),
    );
  }

  Future<FoodAnalysisResult> analyzeFood(File imageFile) async {
    try {
      // Read and compress image
      final imageBytes = await imageFile.readAsBytes();

      // Create multimodal content
      final prompt = Content.multi([
        TextPart('Analyze this food image and return the nutritional data as JSON.'),
        DataPart('image/jpeg', imageBytes),
      ]);

      // Generate response with retry logic
      final response = await _generateWithRetry(prompt);

      // Parse JSON response
      final jsonStr = _extractJson(response.text ?? '');
      final data = json.decode(jsonStr) as Map<String, dynamic>;

      return FoodAnalysisResult.fromJson(data);
    } on GenerativeAIException catch (e) {
      if (e.message.contains('429') || e.message.contains('RESOURCE_EXHAUSTED')) {
        throw RateLimitException(
          'Rate limit exceeded. Please wait a moment and try again.',
        );
      }
      throw FoodAnalysisException('AI analysis failed: ${e.message}');
    } catch (e) {
      throw FoodAnalysisException('Failed to analyze food: $e');
    }
  }

  Future<GenerateContentResponse> _generateWithRetry(
    Content prompt, {
    int maxRetries = 4,
  }) async {
    int attempt = 0;
    Duration delay = const Duration(seconds: 2);

    while (attempt < maxRetries) {
      try {
        return await _model.generateContent([prompt]);
      } on GenerativeAIException catch (e) {
        attempt++;

        // Check if it's a rate limit error
        if (e.message.contains('429') || e.message.contains('RESOURCE_EXHAUSTED')) {
          if (attempt >= maxRetries) {
            rethrow;
          }

          // Exponential backoff: 2s, 4s, 8s, 16s
          await Future.delayed(delay);
          delay *= 2;
        } else {
          rethrow;
        }
      }
    }

    throw RateLimitException('Max retries exceeded');
  }

  String _extractJson(String text) {
    // Remove markdown code blocks if present
    text = text.trim();

    // Remove ```json and ``` markers
    if (text.startsWith('```json')) {
      text = text.substring(7);
    } else if (text.startsWith('```')) {
      text = text.substring(3);
    }

    if (text.endsWith('```')) {
      text = text.substring(0, text.length - 3);
    }

    return text.trim();
  }

  // Test connection to Gemini
  Future<bool> testConnection() async {
    try {
      final prompt = Content.text('Test connection. Respond with: {"status": "ok"}');
      final response = await _model.generateContent([prompt]);
      return response.text != null && response.text!.contains('ok');
    } catch (e) {
      return false;
    }
  }
}

class FoodAnalysisResult {
  final String foodName;
  final int confidenceScore;
  final String quantityDescription;
  final int calories;
  final MacroNutrients macros;
  final MicroNutrients micros;
  final String healthTip;

  FoodAnalysisResult({
    required this.foodName,
    required this.confidenceScore,
    required this.quantityDescription,
    required this.calories,
    required this.macros,
    required this.micros,
    required this.healthTip,
  });

  factory FoodAnalysisResult.fromJson(Map<String, dynamic> json) {
    return FoodAnalysisResult(
      foodName: json['food_name'] as String,
      confidenceScore: json['confidence_score'] as int,
      quantityDescription: json['quantity_description'] as String,
      calories: json['calories'] as int,
      macros: MacroNutrients.fromJson(json['macros'] as Map<String, dynamic>),
      micros: MicroNutrients.fromJson(json['micros'] as Map<String, dynamic>),
      healthTip: json['health_tip'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food_name': foodName,
      'confidence_score': confidenceScore,
      'quantity_description': quantityDescription,
      'calories': calories,
      'macros': macros.toJson(),
      'micros': micros.toJson(),
      'health_tip': healthTip,
    };
  }
}

class MacroNutrients {
  final double proteinG;
  final double carbsG;
  final double fatG;

  MacroNutrients({
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
  });

  factory MacroNutrients.fromJson(Map<String, dynamic> json) {
    return MacroNutrients(
      proteinG: (json['protein_g'] as num).toDouble(),
      carbsG: (json['carbs_g'] as num).toDouble(),
      fatG: (json['fat_g'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'protein_g': proteinG,
      'carbs_g': carbsG,
      'fat_g': fatG,
    };
  }
}

class MicroNutrients {
  final double fiberG;
  final double ironMg;
  final double vitaminCMg;
  final double vitaminAMcg;
  final double vitaminDMcg;
  final double calciumMg;
  final double magnesiumMg;
  final double potassiumMg;

  MicroNutrients({
    required this.fiberG,
    required this.ironMg,
    required this.vitaminCMg,
    required this.vitaminAMcg,
    required this.vitaminDMcg,
    required this.calciumMg,
    required this.magnesiumMg,
    required this.potassiumMg,
  });

  factory MicroNutrients.fromJson(Map<String, dynamic> json) {
    return MicroNutrients(
      fiberG: (json['fiber_g'] as num?)?.toDouble() ?? 0.0,
      ironMg: (json['iron_mg'] as num?)?.toDouble() ?? 0.0,
      vitaminCMg: (json['vitamin_c_mg'] as num?)?.toDouble() ?? 0.0,
      vitaminAMcg: (json['vitamin_a_mcg'] as num?)?.toDouble() ?? 0.0,
      vitaminDMcg: (json['vitamin_d_mcg'] as num?)?.toDouble() ?? 0.0,
      calciumMg: (json['calcium_mg'] as num?)?.toDouble() ?? 0.0,
      magnesiumMg: (json['magnesium_mg'] as num?)?.toDouble() ?? 0.0,
      potassiumMg: (json['potassium_mg'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fiber_g': fiberG,
      'iron_mg': ironMg,
      'vitamin_c_mg': vitaminCMg,
      'vitamin_a_mcg': vitaminAMcg,
      'vitamin_d_mcg': vitaminDMcg,
      'calcium_mg': calciumMg,
      'magnesium_mg': magnesiumMg,
      'potassium_mg': potassiumMg,
    };
  }
}

class FoodAnalysisException implements Exception {
  final String message;
  FoodAnalysisException(this.message);

  @override
  String toString() => message;
}

class RateLimitException implements Exception {
  final String message;
  RateLimitException(this.message);

  @override
  String toString() => message;
}
