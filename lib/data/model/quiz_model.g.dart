// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizModel _$QuizModelFromJson(Map<String, dynamic> json) => QuizModel(
  category: json['category'] as String?,
  correctAnswer: json['correct_answer'] as String?,
  difficulty: json['difficulty'] as String?,
  incorrectAnswers: (json['incorrect_answers'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  question: json['question'] as String?,
);

Map<String, dynamic> _$QuizModelToJson(QuizModel instance) => <String, dynamic>{
  'difficulty': instance.difficulty,
  'category': instance.category,
  'question': instance.question,
  'correct_answer': instance.correctAnswer,
  'incorrect_answers': instance.incorrectAnswers,
};
