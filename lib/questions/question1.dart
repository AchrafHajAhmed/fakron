import 'dart:math';

class Question1 {
  static final List<Map<String, Object>> questions = [
    {
      'question': 'ما هو طعام السلاحف البحرية المفضل؟',
      'options': ['الطحالب', 'الشوكولاتة', 'البيتزا'],
      'answer': 'الطحالب',
      'type': 'crossword',
      'crosswordGrid': [
        ['س', 'ل', 'ح', 'ف', 'اة'],
        ['', '', '', '', ''],
        ['م', '', '', '', ''],
        ['ا', '', '', '', ''],
        ['ء', '', '', '', ''],
      ],
    },
    {
      'question': 'ما هو طعام السلاحف البحرية المفضل؟',
      'options': ['الطحالب', 'الشوكولاتة', 'البيتزا'],
      'answer': 'الطحالب',
      'type': 'crossword',
      'crosswordGrid': [
        ['س', 'ل', 'ح', 'ف', 'اة'],
        ['', '', '', '', ''],
        ['م', '', '', '', ''],
        ['ا', '', '', '', ''],
        ['ء', '', '', '', ''],
      ],
    },

  ];

  static Map<String, Object> getRandomQuestion() {
    final randomIndex = Random().nextInt(questions.length);
    return questions[randomIndex];
  }
}