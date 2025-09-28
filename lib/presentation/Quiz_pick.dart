import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/busniess_logic/cubit/category_cubit.dart';
import 'package:quiz_app/presentation/quiz_screen.dart';

class QuizPickScreen extends StatefulWidget {
  const QuizPickScreen({super.key});

  @override
  State<QuizPickScreen> createState() => _QuizPickScreenState();
}

class _QuizPickScreenState extends State<QuizPickScreen> {
  String? selectedDifficulty;
  int? selectedCategory;
  int numberOfQuestions = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick Quiz")),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategorySuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  /// اختيار الكاتيجوري
                  DropdownButton<int>(
                    isExpanded: true,
                    hint: const Text("Select Category"),
                    value: selectedCategory,
                    items: state.category
                        .map(
                          (cat) => DropdownMenuItem(
                            value: cat.id,
                            child: Text(cat.name ?? ''),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() => selectedCategory = val);
                    },
                  ),

                  const SizedBox(height: 16),

                  /// اختيار الصعوبة
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text("Select Difficulty"),
                    value: selectedDifficulty,
                    items: const [
                      DropdownMenuItem(value: 'easy', child: Text('Easy')),
                      DropdownMenuItem(value: 'medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'hard', child: Text('Hard')),
                    ],
                    onChanged: (val) {
                      setState(() => selectedDifficulty = val);
                    },
                  ),

                  const SizedBox(height: 16),

                  /// اختيار عدد الأسئلة
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Number of Questions",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      setState(() {
                        numberOfQuestions = int.tryParse(val) ?? 5;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  /// زرار يبدأ الكويز
                  ElevatedButton(
                    onPressed: () {
                      if (selectedCategory != null &&
                          selectedDifficulty != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuizScreen(
                              categoryId: selectedCategory ?? 1,
                              difficulty: selectedDifficulty ?? '',
                              amount: numberOfQuestions,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Please select category & difficulty",
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text("Start Quiz"),
                  ),
                  const SizedBox(height: 20),
                  Text('Tip: the question limit is 20 '),
                  const SizedBox(height: 20),
                  Text('Tip: The result is doubled or zero '),
                ],
              ),
            );
          } else if (state is CategoryError) {
            return Center(
              child: Text("Error loading categories: ${state.error}"),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
