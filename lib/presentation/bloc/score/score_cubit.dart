import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizo/models/quiz_model.dart';

part 'score_state.dart';

class ScoreCubit extends Cubit<ScoreState> {
  ScoreCubit() : super(ScoreInitial());

  void initializeAnswers(List<QuizModel> questions) {
    final initialAnswers = {
      for (var item in questions)
        item.questionId: {'answer': null, 'is_correct': null}
    };
    emit(ScoreUpdated(initialAnswers, 0, 0, 0, 0));
  }

  // Method to insert an answer
  void insertAnswer(int questionId, String? answer, bool? isCorrect) {
    final updatedAnswers = Map<int, Map<String, dynamic>>.from(state.answers);
    updatedAnswers[questionId] = {
      'answer': answer,
      'is_correct': isCorrect,
    };
    emit(ScoreUpdated(updatedAnswers, state.score));
  }

  // Method to calculate the score
  void calculateScore() {
    int correctCount = 0;
    int incorrectCount = 0;
    int unAnsweredCount = 0;

    for (var answer in state.answers.values) {
      if (answer['answer'] == null) {
        unAnsweredCount++;
      } else if (answer['is_correct']) {
        correctCount++;
      } else {
        incorrectCount++;
      }
    }

    // Set score as correct answers
    final score = correctCount;
    emit(ScoreUpdated(
        state.answers, score, correctCount, incorrectCount, unAnsweredCount));
  }

  // Reset the score and answers
  void resetScore() {
    emit(ScoreInitial());
  }
}
