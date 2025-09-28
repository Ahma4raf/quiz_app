import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/busniess_logic/cubit/quiz_cubit.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is QuizSuccess) {
            final quiz = state.quizzes[currentIndex];
            final answers = [...?quiz.incorrectAnswers, quiz.correctAnswer]
              ..shuffle();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Q${currentIndex + 1}: ${quiz.question}"),
                ...answers.map((ans) {
                  return ListTile(
                    title: Text(ans ?? '1'),
                    onTap: () {
                      final isCorrect = ans == quiz.correctAnswer;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isCorrect ? "Correct!" : "Wrong!"),
                        ),
                      );
                      if (currentIndex < state.quizzes.length - 1) {
                        setState(() {
                          currentIndex++;
                        });
                      } else {
                        // Quiz finished
                        Navigator.pop(context);
                      }
                    },
                  );
                }),
              ],
            );
          } else if (state is QuizError) {
            return Center(child: Text("Error: ${state.error}"));
          }
          return Container();
        },
      ),
    );
  }
}
