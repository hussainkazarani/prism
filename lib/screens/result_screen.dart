import 'package:flutter/material.dart';
import 'package:prism/colors.dart';
import 'package:prism/main_nav_bar.dart';
import 'package:prism/models/models.dart';
import 'package:prism/screens/home_screen.dart';
import 'package:prism/styles.dart';
import 'category_screen.dart';

class ResultScreen extends StatelessWidget {
  final QuizResult result;
  final TriviaCategory category;

  const ResultScreen({super.key, required this.result, required this.category});

  @override
  Widget build(BuildContext context) {
    const profileImage = 'assets/images/war_mouse.jpeg';
    const backImage = 'assets/images/back_button.png';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(profileImage, backImage, context),
              const SizedBox(height: 20),
              Text('Quiz Complete!', style: AppStyles.headingMain),
              const SizedBox(height: 10),
              Text(category.name, style: AppStyles.bodySubheadingLight),
              const SizedBox(height: 30),

              // Score display
              Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: AppStyles.boxColors,
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${result.correctAnswers}/${result.totalQuestions}',
                        style: AppStyles.headingMain,
                      ),
                      Text(
                        '${result.percentage.toStringAsFixed(0)}%',
                        style: AppStyles.bodySubheadingLight,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Action buttons
              actionButton('Home', () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MainNavScreen(),
                  ),
                );
              }),

              const SizedBox(height: 15),

              actionButton('Play Again', () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const CategoryScreen(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget actionButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppStyles.boxColors,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(child: Text(text, style: AppStyles.subheadingWhite)),
      ),
    );
  }

  Row Header(String profileImage, String backImage, BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const CategoryScreen()),
            );
          },
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
        CircleAvatar(radius: 30, backgroundImage: AssetImage(profileImage)),
      ],
    );
  }
}
