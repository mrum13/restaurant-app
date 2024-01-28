import 'package:flutter/material.dart';

class CardNoNetwork extends StatelessWidget {
  final String message;

  const CardNoNetwork({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off,
            size: 64,
          ),
          const SizedBox(height: 8,),
          Text(message),
        ],
      ),
    );
  }
}