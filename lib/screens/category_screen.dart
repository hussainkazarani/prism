import 'package:flutter/material.dart';
import 'package:prism/models/models.dart';
import 'package:prism/styles.dart';
import '../services/api_service.dart';
import 'quiz_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<TriviaCategory> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final fetchedCategories = await TriviaApiService.getCategories();
    setState(() {
      categories = fetchedCategories;
      isLoading = false;
    });
  }

  Future<void> _selectCategory(TriviaCategory category) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Get questions
    final questions = await TriviaApiService.getQuestions(
      categoryId: category.id,
    );

    // Close loading
    Navigator.of(context).pop();

    // Go to quiz screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => QuizScreen(category: category, questions: questions),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories', style: AppStyles.headingSubMain),
              const SizedBox(height: 10),
              Expanded(
                child:
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: cardOfCategory(categories[index]),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector cardOfCategory(TriviaCategory category) {
    return GestureDetector(
      onTap: () => _selectCategory(category),
      child: Container(
        height: 85,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppStyles.boxColors,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(category.name, style: AppStyles.subheadingWhite),
              ),
              IconButton(
                onPressed: () => _selectCategory(category),
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
