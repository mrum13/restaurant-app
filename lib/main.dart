import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/list_restaurant_provider.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/list_restaurant_searched_provider.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ListRestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ListRestaurantSearchedProvider(),
        ),
      ],
      child: Platform.isIOS?CupertinoApp(
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
        '/search':(context) => const SearchPage() 
      },
    ):MaterialApp(
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
        '/search':(context) => const SearchPage()
      },
    ) ,
    );
    
  }
}
