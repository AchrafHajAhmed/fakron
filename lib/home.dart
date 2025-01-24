import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'color.dart';
import 'questions/question1.dart';
import 'questions/question2.dart';
import 'widget/puzzle.dart';
import 'splash_screen.dart';
import 'widget/crossword.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({Key? key}) : super(key: key);

  @override
  _AcceuilState createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  int currentQuestionClassIndex = 0;
  late Map<String, Object> currentQuestion;
  String feedbackMessage = '';
  bool showGame = false;

  final List<Function> questionClasses = [
    Question1.getRandomQuestion,
    Question2.getRandomQuestion,
  ];

  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    currentQuestion = questionClasses[currentQuestionClassIndex]();
    _audioPlayer = AudioPlayer();
  }

  void _nextQuestion() {
    setState(() {
      feedbackMessage = '';
      currentQuestionClassIndex++;

      if (currentQuestionClassIndex < questionClasses.length) {
        currentQuestion = questionClasses[currentQuestionClassIndex]();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          ),
        );
      }
    });
  }

  void _playIncorrectAnswerSound() {
    _audioPlayer.play(AssetSource('assets/song/loser.mp3'));
  }

  void _toggleGame() {
    setState(() {
      showGame = !showGame;
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionText = currentQuestion['question'] as String? ?? 'سؤال غير متوفر';
    final options = currentQuestion['options'] as List<String>? ?? [];
    final type = currentQuestion['type'] as String? ?? 'text';
    final puzzlePieces = currentQuestion['puzzlePieces'] as List<String>?;
    final crosswordGrid = currentQuestion['crosswordGrid'] as List<List<String>>?;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: Text(
          'السؤال ${currentQuestionClassIndex + 1}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.help_outline),
                      onPressed: _toggleGame,
                      tooltip: 'لعبة المساعدة',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/onboarding.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 30),
                Text(
                  questionText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textcolor,
                  ),
                ),
                const SizedBox(height: 20),
                if (showGame)
                  if (type == 'puzzle' && puzzlePieces != null)
                    Puzzle(
                      question: questionText,
                      puzzlePieces: puzzlePieces,
                      onPuzzleSolved: (message) {
                        setState(() {
                          feedbackMessage = message;
                        });
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            showGame = false;
                          });
                        });
                      },
                    )
                  else if (type == 'crossword' && crosswordGrid != null && crosswordGrid.isNotEmpty)
                    Crossword(
                      question: questionText,
                      crosswordGrid: crosswordGrid,
                      onCrosswordSolved: (message) {
                        setState(() {
                          feedbackMessage = message;
                        });
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            showGame = false;
                          });
                        });
                      },
                    )
                  else
                    const Text('Données manquantes pour ce jeu.'),
                if (!showGame)
                  ...options.map((option) {
                    return Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => checkAnswer(option),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttoncolor,
                            fixedSize: const Size(250, 50),
                          ),
                          child: Text(
                            option,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
                const SizedBox(height: 20),
                if (feedbackMessage.isNotEmpty)
                  Text(
                    feedbackMessage,
                    style: TextStyle(
                      fontSize: 16,
                      color: feedbackMessage.contains('صحيحة') ? Colors.green : Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkAnswer(String selectedAnswer) {
    final correctAnswer = currentQuestion['answer'] as String;

    setState(() {
      if (selectedAnswer == correctAnswer) {
        feedbackMessage = 'إجابة صحيحة! 🎉';

        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            feedbackMessage = '';
            _nextQuestion();
          });
        });
      } else {
        feedbackMessage = 'إجابة خاطئة. 😔 الإجابة الصحيحة: $correctAnswer';
        _playIncorrectAnswerSound();

        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            feedbackMessage = '';
          });
        });
      }
    });
  }
}
