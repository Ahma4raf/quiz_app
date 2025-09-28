import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quiz_app/data/model/quiz_model.dart';
import 'package:quiz_app/data/repo/quiz_repo.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepo quizRepo;
  QuizCubit(this.quizRepo) : super(QuizLoading());

  Future<void> loadQuiz({
    required int amount,
    required int category,
    required String difficulty,
  }) async {
    try {
      final limitedAmount = amount > 20 ? 20 : amount;
      final List<QuizModel> quizzes = await quizRepo.fetchQuiz(
        limitedAmount,
        category,
        difficulty,
      );
      emit(
        QuizSuccess(
          quizzes: quizzes,
          currentIndex: 0,
          score: 0,
          isFinished: false,
        ),
      );
    } catch (e) {
      QuizError(e.toString());
    }
  }

  void answerQuestion(String answer) {
    if (state is QuizSuccess) {
      final currentState = state as QuizSuccess;
      final currentQuestion = currentState.quizzes[currentState.currentIndex];

      int updatedScore = currentState.score;

      if (answer == currentQuestion.correctAnswer) {
        updatedScore = updatedScore == 0 ? 2 : updatedScore * 2;
      } else if (answer != currentQuestion.correctAnswer) {
        updatedScore = 0;
      }

      final nextIndex = currentState.currentIndex + 1;

      if (nextIndex < currentState.quizzes.length) {
        emit(
          currentState.copyWith(currentIndex: nextIndex, score: updatedScore),
        );
      } else {
        emit(currentState.copyWith(score: updatedScore, isFinished: true));
      }
    }
  }
}
