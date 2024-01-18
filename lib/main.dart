import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/home_page.dart';
import 'package:restaurant_app/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS? CupertinoApp(
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomePage()
      },
    ):MaterialApp(
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomePage()
      },
    );
  }
}
