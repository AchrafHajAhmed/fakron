import 'dart:math';
import 'package:flutter/material.dart';

class Question1 extends StatefulWidget {
  @override
  _Question1State createState() => _Question1State();
}

class _Question1State extends State<Question1> {
  final List<Map<String, Object>> questions = [
    {
      'question': 'أين تعيش السلاحف؟',
      'options': ['في الماء', 'على الأرض', 'في كلاهما'],
      'answer': 'في كلاهما',
    },
    {
      'question': 'ما هو طعام السلاحف البحرية المفضل؟',
      'options': ['الطحالب', 'الشوكولاتة', 'البيتزا'],
      'answer': 'الطحالب',
    },
    {
      'question': 'كم يمكن أن تعيش السلاحف في المتوسط؟',
      'options': ['10-20 سنة', '50-100 سنة', '500 سنة'],
      'answer': '50-100 سنة',
    },
    {
      'question': 'ما هي أكبر أنواع السلاحف في العالم؟',
      'options': ['السلحفاة الخضراء', 'السلحفاة جلدية الظهر', 'سلحفاة ذات صدفة ناعمة'],
      'answer': 'السلحفاة جلدية الظهر',
    },
    {
      'question': 'أين تضع السلاحف البحرية بيضها؟',
      'options': ['في الماء', 'على الشاطئ', 'تحت الماء'],
      'answer': 'على الشاطئ',
    },
    {
      'question': 'لماذا السلاحف مهمة للنظام البيئي؟',
      'options': ['تلوث أقل', 'تأكل النفايات', 'تحافظ على الشعاب المرجانية'],
      'answer': 'تحافظ على الشعاب المرجانية',
    },
  ];

  late int currentQuestionIndex;
  String feedbackMessage = '';

  @override
  void initState() {
    super.initState();
    currentQuestionIndex = Random().nextInt(questions.length);
  }

  void checkAnswer(String selectedAnswer) {
    final correctAnswer = questions[currentQuestionIndex]['answer'] as String;
    setState(() {
      if (selectedAnswer == correctAnswer) {
        feedbackMessage = 'إجابة صحيحة! 🎉';
      } else {
        feedbackMessage = 'إجابة خاطئة. 😔';
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        feedbackMessage = '';
        currentQuestionIndex = Random().nextInt(questions.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    final questionText = currentQuestion['question'] as String;
    final options = currentQuestion['options'] as List<String>;

    return Scaffold(
      appBar: AppBar(
        title: Text('السلاحف'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              questionText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 20),
            ...options.map((option) {
              return ElevatedButton(
                onPressed: () => checkAnswer(option),
                child: Text(option, textAlign: TextAlign.center),
              );
            }).toList(),
            SizedBox(height: 20),
            if (feedbackMessage.isNotEmpty)
              Text(
                feedbackMessage,
                style: TextStyle(
                  fontSize: 16,
                  color: feedbackMessage.contains('صحيحة') ? Colors.green : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
