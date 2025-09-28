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
              return ListView.builder(
                itemCount: state.quizzes.length,
                itemBuilder: (context, index) {
                  final q = state.quizzes[index];
                  return Card(
                    child: ListTile(
                      title: Text(q.question ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: q
                            .getShuffledAnswers()
                            .map(
                              (ans) => ElevatedButton(
                                onPressed: () {},
                                child: Text(ans ?? ''),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  );
                },
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
