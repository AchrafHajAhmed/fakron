import 'dart:math';

class Question1 {
  static final List<Map<String, Object>> questions = [
    {
      'question': 'أين تعيش السلاحف؟',
      'options': ['في الماء', 'على الأرض', 'في كلاهما'],
      'answer': 'في كلاهما',
      'puzzlePieces': [
        'assets/question1/piece1.jpg',
        'assets/question1/piece2.jpg',
        'assets/question1/piece3.jpg',
        'assets/question1/piece4.jpg',
        'assets/question1/piece5.jpg',
        'assets/question1/piece6.jpg',
        'assets/question1/piece7.jpg',
        'assets/question1/piece8.jpg',
        'assets/question1/piece9.jpg',
      ],
    },
    {
      'question': 'ما هو طعام السلاحف البحرية المفضل؟',
      'options': ['الطحالب', 'الشوكولاتة', 'البيتزا'],
      'answer': 'الطحالب',
      'puzzlePieces': [
        'assets/question1/piece1.jpg',
        'assets/question1/piece2.jpg',
        'assets/question1/piece3.jpg',
        'assets/question1/piece4.jpg',
        'assets/question1/piece5.jpg',
        'assets/question1/piece6.jpg',
        'assets/question1/piece7.jpg',
        'assets/question1/piece8.jpg',
        'assets/question1/piece9.jpg',
      ],
    },

  ];

  static Map<String, Object> getRandomQuestion() {
    final randomIndex = Random().nextInt(questions.length);
    return questions[randomIndex];
  }
}