part of 'score_cubit.dart';

@immutable
sealed class ScoreState {
  final Map<int, Map<String, dynamic>> answers;
  final int score;
  final int correctAnswers;
  final int incorrectAnswers;
  final int unAnsweredCount;

  const ScoreState(this.answers, this.score, this.correctAnswers,
      this.incorrectAnswers, this.unAnsweredCount);
}

final class ScoreInitial extends ScoreState {
  ScoreInitial() : super({}, 0, 0, 0, 0);
}

class ScoreUpdated extends ScoreState {
  const ScoreUpdated(
    super.answers,
    super.score, [
    super.correctAnswers = 0,
    super.incorrectAnswers = 0,
    super.unAnsweredCount = 0,
  ]);
}
