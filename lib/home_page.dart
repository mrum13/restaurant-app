import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Rumah\nMakan Andalan",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700
                ),
              ),
              const SizedBox(height: 6,),
              Text("Yuk, cek rekomendasi rumah makan ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400
                ),
              ),
              const SizedBox(height: 24,),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey
                          .withOpacity(0.1), // Warna shadow
                      spreadRadius:
                          2, // Radius penyebaran shadow
                      blurRadius: 7, // Radius blur shadow
                      offset: const Offset(
                          3, 3), // Perpindahan shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset("assets/img_restaurant_1.png",
                        height: 70,
                        width: 70,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rumah makan",
                          style: TextStyle(),
                        ),
                        const SizedBox(height: 4,),
                        Row(
                          children: [
                            Image.asset("")
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )),
    );
  }
}