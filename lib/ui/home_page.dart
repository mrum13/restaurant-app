import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/services/api_services.dart';
import 'package:restaurant_app/widgets/card_no_network.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Restaurant> _restaurant;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _restaurant = ApiServices().getListRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Rumah\nMakan Andalan",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 36,
                    ))
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            const Text(
              "Yuk, cek rekomendasi rumah makan ",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: FutureBuilder<Restaurant>(
                future: _restaurant,
                builder: (context, AsyncSnapshot<Restaurant> snapshot) {
                  var state = snapshot.connectionState;
                  if (state == ConnectionState.active) {
                    return const Center(
                      child: Text("Mohon aktifkan Wi-Fi atau Data Seluler"),
                    );
                  } else if (state == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var dataRestaurant =
                                snapshot.data?.restaurants[index];
                            return CardRestaurant(
                              restaurantElement: dataRestaurant!,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 16,
                              ),
                          itemCount: snapshot.data!.restaurants.length);
                    } else if (snapshot.hasError) {
                      if (snapshot.error.toString().contains("jaringan")) {
                        return CardNoNetwork(message: snapshot.error.toString(),);
                      } else {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  } else {
                    return const Center(
                      child: Text("Error"),
                    );
                  }
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
