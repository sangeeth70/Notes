import 'package:flutter/material.dart';

import '../home/screens/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Navigator.pushReplacement(context, PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child){
            return FadeTransition(opacity: animation,child: child,);
          },
          transitionDuration: const Duration(milliseconds: 2000),
          pageBuilder: (context,animation,secAnimation) => NotesHome()));
    });
    return const Scaffold(
      backgroundColor: Color(0xff1B1B1B),
      body: Center(),
    );
  }
}
