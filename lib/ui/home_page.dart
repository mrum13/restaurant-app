import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/list_restaurant_provider.dart';
import 'package:restaurant_app/widgets/card_no_network.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
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
              child: Consumer<ListRestaurantProvider>(
                builder: (context, ListRestaurantProvider data, snapshot) {
                  if (data.state == ResultState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (data.state == ResultState.noData) {
                    return const Center(
                      child: Text("Tidak ada data"),
                    );
                  } else if (data.state == ResultState.hasData) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var dataRestaurant =
                            data.result.restaurants[index];
                        return CardRestaurant(
                          restaurantElement: dataRestaurant,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 16,
                          ),
                      itemCount: data.result.restaurants.length);
                  } else if (data.state == ResultState.error) {
                    if (data.message.toString().contains("jaringan")) {
                        return CardNoNetwork(message: data.message,);
                      } else {
                        return Center(
                          child: Text(data.message.toString()),
                        );
                      }
                  } else {
                    return Center(
                      child: Text(data.message),
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
