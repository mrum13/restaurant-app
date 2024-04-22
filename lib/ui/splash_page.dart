import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/shared_prefrences.dart';
import 'package:restaurant_app/provider/list_restaurant_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    initializeSP();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {
          if (controller.value == 1.0) {
            context.read<ListRestaurantProvider>().fetchListRestaurant();
            Navigator.pushReplacementNamed(context, '/main');
          } else {
            null;
          }
        });
      });
    controller.forward();

    
  }

  void initializeSP() async {
    SharedPreference.favoriteRestaurant = await SharedPreferences.getInstance();
    SharedPreference.scheduledSetting = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/img_splash.png",
          height: 400,
          width: 400,
        ),
      ), 
    );
  }
}