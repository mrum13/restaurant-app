import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/common/background_service.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/notification_helper.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/get_favorite_restaurant_provider.dart';
import 'package:restaurant_app/provider/list_restaurant_provider.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/list_restaurant_searched_provider.dart';
import 'package:restaurant_app/provider/navbar_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/provider/set_favorite_restaurant_provider.dart';
import 'package:restaurant_app/ui/favorite/detail_favorite_page.dart';
import 'package:restaurant_app/ui/home/detail_page.dart';
import 'package:restaurant_app/ui/main_page.dart';
import 'package:restaurant_app/ui/home/search_page.dart';
import 'package:restaurant_app/ui/splash_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
   FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
   final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    notificationHelper.requestAndroidPermissions(flutterLocalNotificationsPlugin);
    await AndroidAlarmManager.initialize();
   
  } else {
    notificationHelper.requestIOSPermissions(flutterLocalNotificationsPlugin);
  }
  
    await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
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
        ChangeNotifierProvider(
          create: (context) => DetailRestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NavbarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SetFavoriteRestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetFavoriteRestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteIconProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SchedulingProvider(),
        ),
      ],
      child: Platform.isIOS?CupertinoApp(
      routes: {
        '/': (context) => const SplashPage(),
        '/main': (context) => const MainPage(),
        '/search':(context) => const SearchPage(),
        '/detail':(context) => const DetailPage(),
        '/detail-favorite':(context) => const DetailFavoritePage(),
      },
    ):MaterialApp(
      navigatorKey: navigatorKey,
      routes: {
        '/': (context) => const SplashPage(),
        '/main': (context) => const MainPage(),
        '/search':(context) => const SearchPage(),
        '/detail':(context) => const DetailPage(),
        '/detail-favorite':(context) => const DetailFavoritePage(),
      },
    ) ,
    );
    
  }
}
