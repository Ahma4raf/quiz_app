import 'package:quiz_app/data/model/quiz_model.dart';
import 'package:quiz_app/data/web/webservices.dart';

class QuizRepo {
  final Webservices webservices;
  QuizRepo(this.webservices);
  Future<List<QuizModel>> fetchQuiz(
    int amount,
    int category,
    String difficulty,
  ) async {
    final response = await webservices.getTasks(amount, category, difficulty);
    return response.results;
  }
}
