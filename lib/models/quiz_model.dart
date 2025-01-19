// ignore_for_file: public_member_api_docs, sort_constructors_first
class QuizModel {
  final int questionId;
  final String topic;
  final String question;
  final List<String> options;
  final List<dynamic> optionMap;

  QuizModel({
    required this.questionId,
    required this.topic,
    required this.question,
    required this.options,
    required this.optionMap,
  });

  factory QuizModel.fromJson(Map<String, dynamic> map) {
    return QuizModel(
        questionId: map['id'],
        topic: map['topic'],
        question: map['description'],
        options: [for (var option in map['options']) option['description']],
        optionMap: map['options']);
  }
}
