import 'dart:math';

class Question1 {
  static final List<Map<String, Object>> questions = [
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

  static Map<String, Object> getRandomQuestion() {
    final randomIndex = Random().nextInt(questions.length);
    return questions[randomIndex];
  }
}
