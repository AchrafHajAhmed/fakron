import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'color.dart';
import 'questions/question1.dart';
import 'package:fakron/questions/question2.dart';
import 'package:fakron/questions/question3.dart';
import 'package:fakron/questions/question4.dart';
import 'package:fakron/questions/question5.dart';
import 'package:fakron/questions/question6.dart';

class acceuil extends StatefulWidget {
  const acceuil({Key? key}) : super(key: key);

  @override
  _acceuilState createState() => _acceuilState();
}

class _acceuilState extends State<acceuil> {
  int currentQuestionClassIndex = 0;
  late Map<String, Object> currentQuestion;
  String feedbackMessage = '';

  final List<Function> questionClasses = [
    Question1.getRandomQuestion,
    Question2.getRandomQuestion,
    Question3.getRandomQuestion,
    Question4.getRandomQuestion,
    Question5.getRandomQuestion,
    Question6.getRandomQuestion,
  ];

  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    currentQuestion = questionClasses[currentQuestionClassIndex]();
    _audioPlayer = AudioPlayer();
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
        currentQuestionClassIndex++;

        if (currentQuestionClassIndex < questionClasses.length) {

          currentQuestion = questionClasses[currentQuestionClassIndex]();
        } else {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EndScreen(),
            ),
          );
        }
      });
    });
  }

  void _playIncorrectAnswerSound() {
    _audioPlayer.play(AssetSource('assets/song/loser.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    final questionText = currentQuestion['question'] as String;
    final options = currentQuestion['options'] as List<String>;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset(
                'assets/onboarding.png',
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
    );
  }
}

class EndScreen extends StatelessWidget {
  const EndScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'انتهت اللعبة! 🎉',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textcolor,
          ),
        ),
      ),
    );
  }
}
