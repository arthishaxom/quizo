// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizo/models/quiz_model.dart';
import 'package:quizo/repo/quiz_repo.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepo quizRepo;

  QuizCubit(
    this.quizRepo,
  ) : super(QuizInitial());

  Future<void> fetchQuizes() async {
    try {
      emit(QuizLoading());
      final List<QuizModel> questions = await quizRepo.getQuesions();
      emit(QuizLoaded(questions));
    } catch (e) {
      emit(
        QuizError(
          e.toString(),
        ),
      );
    }
  }
}
