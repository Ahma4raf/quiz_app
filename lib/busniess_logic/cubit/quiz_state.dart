part of 'quiz_cubit.dart';

@immutable
sealed class QuizState {}

final class QuizLoading extends QuizState {}

final class QuizSuccess extends QuizState {
  final List<QuizModel> quizzes;
  QuizSuccess(this.quizzes);
}

final class QuizError extends QuizState {
  String error;
  QuizError(this.error);
}
