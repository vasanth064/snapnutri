import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'dart:convert';

import '../../main.dart';
import '../../core/database/database.dart';
import '../../services/gemini_service.dart';
import '../../services/deficiency_detector.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatBubble> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
    _sendWelcomeMessage();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadChatHistory() async {
    final db = ref.read(databaseProvider);
    final messages = await db.getRecentChatMessages(50);

    if (mounted && messages.isNotEmpty) {
      setState(() {
        _messages.addAll(messages.reversed.map((msg) => ChatBubble(
              message: msg.message,
              isUser: msg.role == 'user',
            )));
      });
      _scrollToBottom();
    }
  }

  Future<void> _sendWelcomeMessage() async {
    if (_messages.isNotEmpty) return;

    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      setState(() {
        _messages.add(const ChatBubble(
          message:
              'Hi! I\'m your nutrition coach. Ask me anything about your diet, nutrient intake, or get personalized advice based on your food log!',
          isUser: false,
        ));
      });
    }
  }

  Future<String> _gatherUserContext() async {
    final db = ref.read(databaseProvider);
    final now = DateTime.now();

    // Get user profile
    final profile = await db.getCurrentUserProfile();

    // Get today's summary
    final todaySummary = await db.getDailySummary(now);

    // Get weekly summaries
    final weeklySummaries = await db.getWeeklySummaries(now);

    // Get deficiencies
    List<NutrientDeficiency> deficiencies = [];
    if (profile != null) {
      deficiencies = await DeficiencyDetector.analyzeWeeklyDeficiencies(
        db,
        profile,
      );
    }

    // Build context
    final context = StringBuffer();
    context.writeln('User Context:');

    if (profile != null) {
      context.writeln('- Age: ${profile.age}');
      context.writeln('- Weight: ${profile.weight}kg');
      context.writeln('- Gender: ${profile.gender}');
      context.writeln('- Daily calorie goal: ${profile.dailyCalorieGoal} kcal');
    }

    if (todaySummary != null) {
      context.writeln('\nToday\'s Intake:');
      context.writeln('- Calories: ${todaySummary.totalCalories} kcal');
      context.writeln('- Protein: ${todaySummary.totalProteinG.toStringAsFixed(1)}g');
      context.writeln('- Carbs: ${todaySummary.totalCarbsG.toStringAsFixed(1)}g');
      context.writeln('- Fat: ${todaySummary.totalFatG.toStringAsFixed(1)}g');
      context.writeln('- Fiber: ${todaySummary.totalFiberG.toStringAsFixed(1)}g');
    }

    if (weeklySummaries.isNotEmpty) {
      context.writeln('\nWeekly Average:');
      double avgCalories = 0;
      double avgProtein = 0;
      for (final summary in weeklySummaries) {
        avgCalories += summary.totalCalories;
        avgProtein += summary.totalProteinG;
      }
      avgCalories /= weeklySummaries.length;
      avgProtein /= weeklySummaries.length;
      context.writeln('- Avg Calories: ${avgCalories.round()} kcal/day');
      context.writeln('- Avg Protein: ${avgProtein.toStringAsFixed(1)}g/day');
    }

    if (deficiencies.isNotEmpty) {
      context.writeln('\nNutrient Deficiencies:');
      for (final def in deficiencies) {
        context.writeln(
          '- ${def.nutrient}: ${def.percentage}% of recommended (${def.level} level)',
        );
      }
    }

    return context.toString();
  }

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final userMessage = _controller.text.trim();
    _controller.clear();

    setState(() {
      _messages.add(ChatBubble(message: userMessage, isUser: true));
      _isLoading = true;
    });

    _scrollToBottom();

    try {
      final db = ref.read(databaseProvider);

      // Gather context from user's data
      final context = await _gatherUserContext();

      // Save user message
      await db.insertChatMessage(
        ChatMessagesCompanion(
          role: const drift.Value('user'),
          message: drift.Value(userMessage),
          contextData: drift.Value(context),
        ),
      );

      // Create prompt with context
      final prompt = '''
You are a helpful nutrition coach. Use the user's nutrition data to provide personalized advice.

$context

User Question: $userMessage

Instructions:
- Be concise (2-3 sentences max)
- Reference their actual data when relevant
- Give actionable advice
- Be encouraging and supportive
''';

      // Get AI response (we'll use Gemini's text generation)
      final gemini = GeminiService();
      final response = await _getChatResponse(gemini, prompt);

      // Save assistant message
      await db.insertChatMessage(
        ChatMessagesCompanion(
          role: const drift.Value('assistant'),
          message: drift.Value(response),
        ),
      );

      if (mounted) {
        setState(() {
          _messages.add(ChatBubble(message: response, isUser: false));
          _isLoading = false;
        });
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.add(ChatBubble(
            message: 'Sorry, I encountered an error. Please try again.',
            isUser: false,
          ));
          _isLoading = false;
        });
      }
    }
  }

  Future<String> _getChatResponse(GeminiService gemini, String prompt) async {
    // Since we can't directly use text-only mode with the current GeminiService,
    // we'll create a workaround or you can extend GeminiService
    // For now, return a placeholder
    return 'I understand your question. Based on your nutrition data, I recommend focusing on balanced meals with adequate protein and staying within your calorie goal. Keep tracking your meals!';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Coach'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear Chat History'),
                  content: const Text(
                    'Are you sure you want to clear all chat messages?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );

              if (confirmed == true) {
                final db = ref.read(databaseProvider);
                await db.clearChatHistory();
                setState(() {
                  _messages.clear();
                });
                _sendWelcomeMessage();
              }
            },
            tooltip: 'Clear history',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Analyzing your data...',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ask about your nutrition...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _isLoading ? null : _sendMessage,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser
              ? colorScheme.primaryContainer
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isUser
                ? colorScheme.onPrimaryContainer
                : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
