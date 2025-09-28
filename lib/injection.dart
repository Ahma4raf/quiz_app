import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_app/busniess_logic/cubit/quiz_cubit.dart';
import 'package:quiz_app/data/repo/quiz_repo.dart';
import 'package:quiz_app/data/web/webservices.dart';

final getIt = GetIt.instance;

void injection() {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<Webservices>(() => Webservices(getIt<Dio>()));

  getIt.registerLazySingleton<QuizRepo>(() => QuizRepo(getIt<Webservices>()));

  getIt.registerFactory<QuizCubit>(() => QuizCubit(getIt<QuizRepo>()));
}
