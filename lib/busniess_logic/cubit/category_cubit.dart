import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quiz_app/data/model/category_model.dart';
import 'package:quiz_app/data/repo/quiz_repo.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.quizRepo) : super(CategoryLoading());

  QuizRepo quizRepo;
  Future<void> loadCategories() async {
    try {
      final categories = await quizRepo.fetchCat();
      emit(CategorySuccess(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
