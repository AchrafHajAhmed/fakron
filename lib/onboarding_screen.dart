import 'package:flutter/material.dart';
import 'color.dart';
import 'package:fakron/widget/button.dart';
import 'splash_screen.dart';
import 'home.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> onboardingTexts = [
    "مرحبا بكم في لعبة الفكرون. هدف اللعبة هو الوصول إلى السلحفاة قبل الفرق الأخرى.",
    "اللعبة تعتمد على الإجابة عن الأسئلة المختلفة لتحصيل النقاط.",
    "يتوجب على الفريق التعاون والعمل الجماعي لتجاوز التحديات.",
    "استخدموا البطاقات السحرية بحذر، فهي متاحة مرة واحدة فقط خلال اللعبة.",
    "ابدؤوا الآن واستمتعوا بتجربة تعليمية وترفيهية ممتعة!"
  ];

  void _onSkipOrStart() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => acceuil()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: onboardingTexts.length,
            itemBuilder: (context, index) => OnboardingContent(
              text: onboardingTexts[index],
              backgroundColor: AppColors.background,
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingTexts.length,
                        (index) => buildDot(index: index),
                  ),
                ),
                const SizedBox(height: 20),
                MyButton(
                  text: _currentPage == onboardingTexts.length - 1 ? "ابدأ" : "تخطي",
                  onPressed: _onSkipOrStart,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot({required int index}) {
    return Container(
      height: 10,
      width: _currentPage == index ? 20 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  const OnboardingContent({
    Key? key,
    required this.text,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Image.asset(
              'assets/images/onboarding.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

