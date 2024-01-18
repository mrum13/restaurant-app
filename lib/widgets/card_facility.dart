import 'package:flutter/material.dart';

class CardFacility extends StatelessWidget {
  final String title;
  final String title1;

  const CardFacility({super.key, required this.title, required this.title1});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Row(
            children: [
              Image.asset(
                "assets/ic_check.png",
                width: 16,
                height: 16,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              )
            ],
          ),
        ),
        Row(
          children: [
            Image.asset(
              "assets/ic_check.png",
              width: 16,
              height: 16,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title1,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            )
          ],
        ),
      ],
    );
  }
}
