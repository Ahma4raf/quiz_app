import 'package:json_annotation/json_annotation.dart';
import 'package:quiz_app/data/model/quiz_model.dart';
part 'quiz_Response.g.dart';

@JsonSerializable()
class QuizResponse {
  final int response_code;
  final List<QuizModel> results;

  QuizResponse({required this.response_code, required this.results});

  factory QuizResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuizResponseToJson(this);
}
