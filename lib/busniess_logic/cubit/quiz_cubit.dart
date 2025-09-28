import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quiz_app/data/model/quiz_model.dart';
import 'package:quiz_app/data/repo/quiz_repo.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepo quizRepo;
  QuizCubit(this.quizRepo) : super(QuizLoading());

  Future<void> loadQuiz(int amount,int category,String difficulty) async {
    try {
      final List<QuizModel> quizzes = await quizRepo.fetchQuiz(amount,category,difficulty);
      emit(QuizSuccess(quizzes));
    } catch (e) {
      QuizError(e.toString());
    }
  }
}
