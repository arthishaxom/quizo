import 'package:dio/dio.dart';
import 'package:quizo/models/quiz_model.dart';

class QuizRepo {
  final Dio _dio;
  List<QuizModel> questions = [];

  QuizRepo({required Dio dio}) : _dio = dio;

  Future<List<QuizModel>> getQuesions() async {
    final res = await _dio.get('https://api.jsonserve.com/Uw5CrX');
    for (Map<String, dynamic> m in res.data['questions']) {
      questions.add(
        QuizModel.fromJson(m),
      );
    }
    return questions;
  }
}
