import 'package:json_annotation/json_annotation.dart';

part 'quiz_model.g.dart';

@JsonSerializable()
class QuizModel {
  String? difficulty;
  String? category;
  String? question;
  @JsonKey(name: 'correct_answer')
  String? correctAnswer;
  @JsonKey(name: 'incorrect_answers')
  List<String>? incorrectAnswers;
  QuizModel({
    this.category,
    this.correctAnswer,
    this.difficulty,
    this.incorrectAnswers,
    this.question,
  });
  factory QuizModel.fromJson(Map<String, dynamic> json) =>
      _$QuizModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$QuizModelToJson(this);

  List<String?> getShuffledAnswers() {
    final Answers = [...?incorrectAnswers, correctAnswer];
    Answers.shuffle();
    return Answers;
  }
}
