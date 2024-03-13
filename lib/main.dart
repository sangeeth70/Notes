
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_by_sangeeth/sqflite/features/home/screens/home.dart';
import 'package:notes_by_sangeeth/sqflite/features/splash/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: const Color(0xff7B7B7B),
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Colors.white,
          selectionColor: Colors.white30
        ),
        iconTheme: const IconThemeData(
          color: Color(0xff7B7B7B),
        ),
          fontFamily: 'Boska',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white,),
      ),
      home:  NotesHome(),
    );
  }
}

