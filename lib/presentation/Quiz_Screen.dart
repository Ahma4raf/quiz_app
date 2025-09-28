import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/busniess_logic/cubit/quiz_cubit.dart';
import 'package:quiz_app/data/repo/quiz_repo.dart';
import 'package:quiz_app/injection.dart';

class QuizScreen extends StatelessWidget {
  final int categoryId;
  final String difficulty;
  final int amount;

  QuizScreen({
    super.key,
    required this.categoryId,
    required this.difficulty,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizCubit(getIt<QuizRepo>())
        ..loadQuiz(
          category: categoryId,
          difficulty: difficulty,
          amount: amount,
          // أضف هذا
        ),
      child: Scaffold(
        appBar: AppBar(title: Text("Quiz")),
        body: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            if (state is QuizLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is QuizSuccess) {
              if (state.isFinished) {
                return Center(
                  child: Text(
                    "🎉 Quiz Finished!\nYour Score: ${state.score}/${state.quizzes.length}",
                  ),
                );
              }
              final q = state.quizzes[state.currentIndex];
              return Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(q.question ?? ''),
                    const SizedBox(height: 30),
                    ...q.getShuffledAnswers().map((ans) {
                      return Padding(
                        padding: EdgeInsetsGeometry.all(6),
                        child: ElevatedButton(
                          onPressed: () => context
                              .read<QuizCubit>()
                              .answerQuestion(ans ?? ''),
                          child: Text(ans ?? ''),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 30),

                    Text(
                      "Score: ${state.score}",
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else if (state is QuizError) {
              return Center(child: Text("Error: ${state.error}"));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
