import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_model.dart';
import 'package:restaurant_app/services/get_data_service.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

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
            const Text(
              "Rumah\nMakan Andalan",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
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
            FutureBuilder<String>(
              future: DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json'),
              builder: (context, snapshot) {
                final RestaurantModel dataRestaurant = GetDataServices().getDataRestaurant(snapshot.data!);
                return Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CardRestaurant(
                        data: dataRestaurant,
                        image: dataRestaurant.restaurants![index].pictureId!, 
                        title: dataRestaurant.restaurants![index].name!, 
                        location: dataRestaurant.restaurants![index].city!, 
                        rating: dataRestaurant.restaurants![index].rating.toString(), 
                        index: index
                      );
                    }, 
                    separatorBuilder: (context, index) => const SizedBox(height: 16,), 
                    itemCount: dataRestaurant.restaurants!.length
                  ),
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
