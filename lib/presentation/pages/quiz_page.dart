import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizo/models/quiz_model.dart';
import 'package:quizo/presentation/bloc/quiz/quiz_cubit.dart';
import 'package:quizo/presentation/bloc/score/score_cubit.dart';
import 'package:quizo/presentation/pages/result_page.dart';
import 'package:quizo/presentation/widgets/button_group.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            if (state is QuizLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: ShadProgress(),
                ),
              );
            } else if (state is QuizLoaded) {
              context.read<ScoreCubit>().initializeAnswers(state.questions);
              return QuizQuestionList(questions: state.questions);
            } else if (state is QuizError) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class QuizQuestionList extends StatefulWidget {
  final List<QuizModel> questions;

  const QuizQuestionList({super.key, required this.questions});

  @override
  State<QuizQuestionList> createState() => _QuizQuestionListState();
}

class _QuizQuestionListState extends State<QuizQuestionList> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ShadForm(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < widget.questions.length; i++)
                _buildCard(i, context),
              ShadButton(
                height: 48,
                width: double.infinity,
                child: const Text("Submit"),
                onPressed: () {
                  if (formKey.currentState!.saveAndValidate()) {
                    context.read<ScoreCubit>().calculateScore();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResultScreen(),
                      ),
                    );
                  } else {
                    ShadToaster.of(context).show(
                      const ShadToast.destructive(
                        description:
                            Text('Answer All Questions Before Proceeding'),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(int i, BuildContext context) {
    var shadcon = ShadTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ShadCard(
        width: double.infinity,
        title: Text(
          "Ques. ${i + 1}",
          style: shadcon.textTheme.muted,
        ),
        description: Text(
          widget.questions[i].question,
          style: shadcon.textTheme.lead
              .copyWith(color: shadcon.colorScheme.foreground),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SingleSelectButtonGroup(
            options: widget.questions[i].optionMap,
            isSelectionRequired: false,
            onChanged: (selectedOption) {
              context.read<ScoreCubit>().insertAnswer(
                    widget.questions[i].questionId,
                    selectedOption?['description'],
                    selectedOption?['is_correct'],
                  );
            },
          ),
        ),
      ),
    );
  }
}
