import 'package:flutter/material.dart';
import 'package:quiz_app/busniess_logic/cubit/category_cubit.dart';
import 'package:quiz_app/busniess_logic/cubit/quiz_cubit.dart';
import 'package:quiz_app/data/repo/quiz_repo.dart';
import 'package:quiz_app/injection.dart';
import 'package:quiz_app/presentation/Quiz_pick.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  injection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => QuizCubit(getIt<QuizRepo>())),
        BlocProvider(
          create: (context) =>
              CategoryCubit(getIt<QuizRepo>())..loadCategories(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const QuizPickScreen(),
      ),
    );
  }
}
