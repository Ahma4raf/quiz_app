import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quiz_app/data/model/quiz_Response.dart';
import 'package:quiz_app/data/model/quiz_model.dart';
import 'package:quiz_app/data/web/strings.dart';
import 'package:retrofit/retrofit.dart';

part 'webservices.g.dart';

@RestApi(baseUrl: AppStrings.baseUrl)
abstract class Webservices {
  factory Webservices(Dio dio, {String? baseUrl}) = _Webservices;

  @GET('api.php')
  Future<QuizResponse> getTasks(@Query('amount') int amount);
}
