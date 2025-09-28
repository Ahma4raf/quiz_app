import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/busniess_logic/cubit/category_cubit.dart';
import 'package:quiz_app/busniess_logic/cubit/quiz_cubit.dart';
import 'package:quiz_app/presentation/Quiz_Screen.dart';

class QuizPickScreen extends StatefulWidget {
  const QuizPickScreen({super.key});

  @override
  State<QuizPickScreen> createState() => _QuizPickScreenState();
}

class _QuizPickScreenState extends State<QuizPickScreen> {
  String? selectedDifficulty;
  int? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pick Quiz")),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return CircularProgressIndicator();
          } else if (state is CategorySuccess) {
            return DropdownButton<int>(
              hint: Text("Select Category"),
              value: selectedCategory,
              items: state.category
                  .map(
                    (cat) => DropdownMenuItem(
                      value: cat.id,
                      child: Text(cat.name ?? ''),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                setState(() => selectedCategory = val);
              },
            );
          } else if (state is CategoryError) {
            return Text("Error loading categories");
          }
          return Container();
        },
      ),
    );
  }
}
