// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_Response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizResponse _$QuizResponseFromJson(Map<String, dynamic> json) => QuizResponse(
  response_code: (json['response_code'] as num).toInt(),
  results: (json['results'] as List<dynamic>)
      .map((e) => QuizModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$QuizResponseToJson(QuizResponse instance) =>
    <String, dynamic>{
      'response_code': instance.response_code,
      'results': instance.results,
    };
