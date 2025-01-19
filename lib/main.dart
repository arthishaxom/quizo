// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quizo/presentation/bloc/quiz/quiz_cubit.dart';
import 'package:quizo/presentation/bloc/score/score_cubit.dart';
import 'package:quizo/presentation/pages/home_page.dart';
import 'package:quizo/repo/quiz_repo.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  final Dio dio = Dio();
  final QuizRepo quizRepo = QuizRepo(dio: dio);
  runApp(
    MyApp(
      quizRepo: quizRepo,
    ),
  );
}

class MyApp extends StatelessWidget {
  final QuizRepo quizRepo;
  const MyApp({
    super.key,
    required this.quizRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuizCubit(quizRepo),
        ),
        BlocProvider(
          create: (context) => ScoreCubit(),
        ),
      ],
      child: ShadApp(
        debugShowCheckedModeBanner: false,
        title: 'Quizo',
        themeMode: ThemeMode.dark,
        darkTheme: ShadThemeData(
          colorScheme: const ShadRoseColorScheme.dark(),
          brightness: Brightness.dark,
          textTheme: ShadTextTheme.fromGoogleFont(
            GoogleFonts.poppins,
            // colorScheme: const ShadZincColorScheme.dark(),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
