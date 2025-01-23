import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'color.dart';
import 'questions/question1.dart';
import 'questions/question2.dart';
import 'widget/puzzle.dart';
import 'splash_screen.dart';

class acceuil extends StatefulWidget {
  const acceuil({Key? key}) : super(key: key);

  @override
  _acceuilState createState() => _acceuilState();
}

class _acceuilState extends State<acceuil> {
  int currentQuestionClassIndex = 0;
  late Map<String, Object> currentQuestion;
  String feedbackMessage = '';
  bool showPuzzle = false;

  final List<Function> questionClasses = [
    Question1.getRandomQuestion,
    Question2.getRandomQuestion,
    // Ajoutez d'autres classes de questions ici
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
        Navigator.push(
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

  void _togglePuzzle() {
    setState(() {
      showPuzzle = !showPuzzle;
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionText = currentQuestion['question'] as String;
    final options = currentQuestion['options'] as List<String>;
    final puzzlePieces = currentQuestion['puzzlePieces'] as List<String>; // Morceaux d'image spécifiques

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('السؤال ${currentQuestionClassIndex + 1}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _togglePuzzle,
            tooltip: 'بطاقة سحرية',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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

                // Afficher le puzzle si showPuzzle est true
                if (showPuzzle)
                  Puzzle(
                    question: questionText,
                    puzzlePieces: puzzlePieces, // Passer les morceaux d'image
                    onPuzzleSolved: (message) {
                      setState(() {
                        feedbackMessage = message;
                      });
                      Future.delayed(const Duration(seconds: 3), () {
                        _nextQuestion();
                      });
                    },
                  ),

                // Afficher les boutons de réponse si le puzzle n'est pas affiché
                if (!showPuzzle)
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
      } else {
        feedbackMessage = 'إجابة خاطئة. 😔 الإجابة الصحيحة: $correctAnswer';
        _playIncorrectAnswerSound();
      }
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        feedbackMessage = '';
        _nextQuestion();
      });
    });
  }
}