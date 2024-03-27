import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/navbar_provider.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/widgets/custom_bottom_navigation_item.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const Scaffold(body: Center(child: Text("Favorite Page"),),);
        case 2:
          return const Scaffold(body: Center(child: Text("Settings Page"),),);
        default:
          return const HomePage();
      }
    }

    return Consumer<NavbarProvider>(
      builder: (context, NavbarProvider data, snapshot) {
        return Scaffold(
          body: Column(
            children: [Expanded(child: buildContent(data.state))],
          ),
          bottomNavigationBar: const BottomAppBar(
            notchMargin: 3,
            padding: EdgeInsets.zero,
            height: 64,
            color: Colors.white,
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // ignore: prefer_const_constructors
                CustomBottomNavigationItem(
                    title: "Home", 
                    icon: Icons.home, 
                    index: 0
                ),
                // ignore: prefer_const_constructors
                CustomBottomNavigationItem(
                    title: "Favorite",
                    icon: Icons.favorite,
                    index: 1),
                // ignore: prefer_const_constructors
                CustomBottomNavigationItem(
                    title: "Settings", 
                    icon: Icons.settings, 
                    index: 2),
              ],
            ),
          ),
        );
      }
    );
  }
}
