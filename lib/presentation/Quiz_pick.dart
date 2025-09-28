import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/busniess_logic/cubit/quiz_cubit.dart';
import 'package:quiz_app/presentation/Quiz_Screen.dart';

class QuizPickScreen extends StatefulWidget {
  const QuizPickScreen({super.key});

  @override
  State<QuizPickScreen> createState() => _QuizPickScreenState();
}

class _QuizPickScreenState extends State<QuizPickScreen> {
  String? selectedDifficulty;
  int? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pick Quiz")),
      body: Column(
        children: [
          DropdownButton<String>(
            hint: Text("Select Difficulty"),
            value: selectedDifficulty,
            items: ["easy", "medium", "hard"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) {
              setState(() => selectedDifficulty = val);
            },
          ),
          DropdownButton<int>(
            hint: Text("Select Category"),
            value: selectedCategory,
            items: [
              DropdownMenuItem(value: 23, child: Text("History")),
              DropdownMenuItem(value: 21, child: Text("Sports")),
              DropdownMenuItem(value: 17, child: Text("Science")),
            ],
            onChanged: (val) {
              setState(() => selectedCategory = val);
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedDifficulty != null && selectedCategory != null) {
                context.read<QuizCubit>().loadQuiz(
                      10,
                      selectedCategory!,
                      selectedDifficulty!,
                    );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => QuizScreen()),
                );
              }
            },
            child: Text("Start Quiz"),
          )
        ],
      ),
    );
  }
}
