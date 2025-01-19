part of 'quiz_cubit.dart';

@immutable
sealed class QuizState {}

final class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<QuizModel> questions;

  QuizLoaded(this.questions);
}

class QuizError extends QuizState {
  final String message;

  QuizError(this.message);
}
