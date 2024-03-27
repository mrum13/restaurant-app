import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/navbar_provider.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  final int index;
  final String title;
  final IconData icon;

  const CustomBottomNavigationItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.index});

  @override
  Widget build(BuildContext context) {

    handleButtonMenu() async {
      await Future.delayed(const Duration(milliseconds: 100), () {
        if (index == 0) {} 
        else if (index == 1) {} 
        else if (index == 2) {}
      });
    }

    return InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            context.read<NavbarProvider>().setIndex(index: index);
          },
          child: Consumer<NavbarProvider>(
            builder: (context, NavbarProvider data, snapshot) {
              return Container(
                height: 56,
                width: 70,
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 24,
                      color: data.state == index ? Colors.black : Colors.grey,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      title,
                      style: data.state == index
                          ? const TextStyle(
                              color: Colors.black,
                              fontSize: 11, 
                              fontWeight: FontWeight.w700
                            )
                          : const TextStyle(
                              color: Colors.grey,
                              fontSize: 11, 
                              fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              );
            }
          ),
        );
  }
}
