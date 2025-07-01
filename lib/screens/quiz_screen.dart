import 'package:flutter/material.dart';
import 'package:prism/colors.dart';
import 'package:prism/models/models.dart';
import 'package:prism/screens/result_screen.dart';
import 'package:prism/styles.dart';
import '../services/api_service.dart';

class QuizScreen extends StatefulWidget {
  final TriviaCategory category;
  final List<TriviaQuestion> questions;

  const QuizScreen({
    super.key,
    required this.category,
    required this.questions,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  bool hasCheckedAnswer = false;
  late AnimationController _timerController;
  int timeLeft = 10;
  int correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timerController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _timerController.addListener(() {
      setState(() {
        timeLeft = (10 - (_timerController.value * 10)).round();
      });

      // Auto-check answer when timer reaches 0
      if (timeLeft == 0 && !hasCheckedAnswer) {
        _checkAnswer();
      }
    });

    _timerController.forward();
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  void _selectAnswer(String answer) {
    if (!hasCheckedAnswer) {
      setState(() {
        selectedAnswer = answer;
      });
    }
  }

  void _checkAnswer() {
    setState(() {
      hasCheckedAnswer = true;
    });
    _timerController.stop();
  }

  void _nextQuestion() {
    // Check if answer was correct before moving to next
    if (hasCheckedAnswer && selectedAnswer != null) {
      final correctAnswer =
          widget.questions[currentQuestionIndex].correctAnswer;
      if (selectedAnswer == correctAnswer) {
        correctAnswers++;
      }
    }

    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        hasCheckedAnswer = false;
        timeLeft = 10;
      });
      _timerController.reset();
      _timerController.forward();
    } else {
      // Quiz finished - go to results screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder:
              (context) => ResultScreen(
                result: QuizResult(
                  totalQuestions: widget.questions.length,
                  correctAnswers: correctAnswers,
                ),
                category: widget.category,
              ),
        ),
      );
    }
  }

  IconData _getIconForAnswer(String answer) {
    if (!hasCheckedAnswer) {
      return selectedAnswer == answer
          ? Icons.radio_button_checked
          : Icons.radio_button_unchecked;
    } else {
      final correctAnswer =
          widget.questions[currentQuestionIndex].correctAnswer;
      if (answer == correctAnswer) {
        return Icons.check_circle;
      } else if (answer == selectedAnswer) {
        return Icons.cancel;
      } else {
        return Icons.radio_button_unchecked;
      }
    }
  }

  Color _getIconColorForAnswer(String answer) {
    if (!hasCheckedAnswer) {
      return selectedAnswer == answer ? Colors.white : Colors.grey;
    } else {
      final correctAnswer =
          widget.questions[currentQuestionIndex].correctAnswer;
      if (answer == correctAnswer) {
        return Colors.green;
      } else if (answer == selectedAnswer) {
        return Colors.red;
      } else {
        return Colors.grey;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const profileImage = 'assets/images/war_mouse.jpeg';
    const backImage = 'assets/images/back_button.png';
    final currentQuestion = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(profileImage, backImage),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.category.name,
                        style: AppStyles.headingMain,
                      ),
                    ),
                    Text(
                      '#${currentQuestionIndex + 1}',
                      style: AppStyles.headingMain,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  TriviaApiService.decodeHtmlEntities(currentQuestion.question),
                  style: AppStyles.bodySubheadingLight,
                ),
                const SizedBox(height: 10),
                questionCard(currentQuestion.correctAnswer),
                ...currentQuestion.incorrectAnswers.map(
                  (answer) => questionCard(answer),
                ),
                const SizedBox(height: 20),
                nextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget questionCard(String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () => _selectAnswer(answer),
        child: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppStyles.boxColors,
            borderRadius: BorderRadius.circular(35),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Icon(
                  _getIconForAnswer(answer),
                  color: _getIconColorForAnswer(answer),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    TriviaApiService.decodeHtmlEntities(answer),
                    style: AppStyles.bodyBasicWhite,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget nextButton() {
    return Center(
      child: GestureDetector(
        onTap: hasCheckedAnswer ? _nextQuestion : _checkAnswer,
        child: Container(
          alignment: Alignment.center,
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color:
                (selectedAnswer != null || hasCheckedAnswer)
                    ? AppColors.text
                    : Colors.grey,
            borderRadius: BorderRadius.circular(35),
          ),
          child: Text(
            hasCheckedAnswer ? 'Next' : 'Check Answer',
            style: AppStyles.bodyBasicBlack,
          ),
        ),
      ),
    );
  }

  Row Header(String profileImage, String backImage) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppStyles.boxColors,
            child: CircleAvatar(
              radius: 10,
              backgroundImage: AssetImage(backImage),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        const Spacer(),
        Text('$timeLeft'),
        const Spacer(),
        CircleAvatar(radius: 30, backgroundImage: AssetImage(profileImage)),
      ],
    );
  }
}
