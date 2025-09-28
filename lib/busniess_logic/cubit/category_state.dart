part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategorySuccess extends CategoryState {
  final List<CategoryModel> category;
  CategorySuccess(this.category);
}

final class CategoryError extends CategoryState {
  final String error;
  CategoryError(this.error);
}
