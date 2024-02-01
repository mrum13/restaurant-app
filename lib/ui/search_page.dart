import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/list_restaurant_searched_provider.dart';
import 'package:restaurant_app/widgets/card_restaurant%20_search.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController(text: "");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cari Restaurant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(16)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(16)),
                  hintText: "Cari Restaurant Favorite",
                  hintStyle: const TextStyle(color: Colors.grey)),
              controller: searchController,
              onFieldSubmitted: (value) {
                context
                    .read<ListRestaurantSearchedProvider>()
                    .fetchListRestaurantSearched(value: value);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(child: Consumer<ListRestaurantSearchedProvider>(builder:
                (context, ListRestaurantSearchedProvider data, snapshot) {
              print("statenya ${data.state}");
              if (data.state == ResultState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.state == ResultState.noData) {
                return const Center(
                  child: Text("Tidak ada data"),
                );
              } else if (data.state == ResultState.hasData) {
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var dataRestaurant = data.result.restaurants[index];
                      return CardRestaurantSearch(
                        restaurantElement: dataRestaurant,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: data.result.restaurants.length);
              } else {
                return Center(
                  child: Text(data.message),
                );
              }
            }))
          ],
        ),
      ),
    );
  }
}
