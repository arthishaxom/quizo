import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizo/presentation/bloc/quiz/quiz_cubit.dart';
import 'package:quizo/presentation/pages/quiz_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Quizo",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.aBeeZee().copyWith(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 8,
                    ),
                  ),
                  Text(
                    "Test Your Skills. Gain Points.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.aBeeZee().copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 4,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ShadButton(
                width: double.infinity,
                height: 56,
                child: const Text('Get Started'),
                onPressed: () async {
                  context.read<QuizCubit>().fetchQuizes();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const QuizPage(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
