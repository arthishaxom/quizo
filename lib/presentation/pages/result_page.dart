import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizo/presentation/bloc/quiz/quiz_cubit.dart';
import 'package:quizo/presentation/bloc/score/score_cubit.dart';
import 'package:quizo/presentation/pages/quiz_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: const Text('Result')),
        body: BlocBuilder<ScoreCubit, ScoreState>(
          builder: (context, state) {
            var shadcon = ShadTheme.of(context);
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Results",
                      style: shadcon.textTheme.h2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ShadCard(
                      title: const Text("Total Questions"),
                      width: double.infinity,
                      child: Text(
                        '${state.correctAnswers + state.incorrectAnswers + state.unAnsweredCount}',
                        style: shadcon.textTheme.h1Large,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ShadCard(
                        title: const Text("Score"),
                        width: double.infinity,
                        child: Text(
                          '${state.score}',
                          style: shadcon.textTheme.h1Large.copyWith(
                            color: shadcon.colorScheme.primary,
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    ShadCard(
                      title: const Text("Correct"),
                      width: double.infinity,
                      child: Text(
                        '${state.correctAnswers}',
                        style: shadcon.textTheme.h1Large.copyWith(
                          color: shadcon.colorScheme.foreground
                              .withGreen(255)
                              .withBlue(100)
                              .withRed(50),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ShadCard(
                      title: const Text("Incorrect"),
                      width: double.infinity,
                      child: Text(
                        '${state.incorrectAnswers}',
                        style: shadcon.textTheme.h1Large.copyWith(
                          color: shadcon.colorScheme.destructive.withRed(190),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ShadCard(
                      title: const Text("Unanswered"),
                      width: double.infinity,
                      child: Text(
                        '${state.unAnsweredCount}',
                        style: shadcon.textTheme.h1Large.copyWith(
                          color: Colors.white54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ShadButton(
                        width: double.infinity,
                        height: 56,
                        child: const Text("Retry"),
                        onPressed: () {
                          context.read<QuizCubit>().fetchQuizes();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuizPage(),
                            ),
                          );
                        })
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
