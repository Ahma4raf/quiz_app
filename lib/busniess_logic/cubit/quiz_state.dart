part of 'quiz_cubit.dart';

@immutable
sealed class QuizState {
  
}

final class QuizLoading extends QuizState {}

final class QuizSuccess extends QuizState {
  final List<QuizModel> quizzes;
  final int currentIndex;
  final int score;
  final bool isFinished;

  QuizSuccess({
    required this.quizzes,
    required this.currentIndex,
    required this.score,
    required this.isFinished,
  });
    QuizSuccess copyWith({
    List<QuizModel>? quizzes,
    int? currentIndex,
    int? score,
    bool? isFinished,
  }) {
    return QuizSuccess(
      quizzes: quizzes ?? this.quizzes,
      currentIndex: currentIndex ?? this.currentIndex,
      score: score ?? this.score,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}

final class QuizError extends QuizState {
final  String error;
  QuizError(this.error);
}
