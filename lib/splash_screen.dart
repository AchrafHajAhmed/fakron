import 'package:fakron/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fakron/color.dart'; // Import de votre classe de couleurs
import 'package:fakron/puzzle.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Deux logos alignés en haut
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/oasis.jpg', // Chemin de votre premier logo
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover, // Adapter l'image dans le cercle
                  ),
                ),
                ClipOval(
                  child: Image.asset(
                    'assets/wwf.jpg', // Chemin de votre deuxième logo
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Center(
              child: PuzzleWidget(
                imagePath: 'assets/oasis.jpg',
                gridSize: 3, // Grille 3x3
              ),
            ),
          ],
        ),
      ),
    );
  }
}
