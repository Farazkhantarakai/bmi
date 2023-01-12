import 'package:flutter/material.dart';
import './home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routName = 'splashScreen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {

    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/icons/launcher_icon.png',
              fit: BoxFit.contain,
              height: 190,
            ),
          ),
        ],
      ),
    );
  }
}
