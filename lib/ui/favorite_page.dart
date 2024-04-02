import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/get_favorite_restaurant_provider.dart';
import 'package:restaurant_app/provider/result_state.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      // Panggil getFavoriteRestaurant() setelah build widget selesai
      context.read<GetFavoriteRestaurantProvider>().getFavoriteRestaurant();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: 
        
        // Center(child: Text("Favorite"),)
        
        Consumer<GetFavoriteRestaurantProvider>(
          builder: (context, GetFavoriteRestaurantProvider data, snapshot) {
        if (data.state == FavoriteRestaurantState.hasData) {
          debugPrint("Data Favorite = ${data.result.map((e) => e.name)}");
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Text(data.result[index].name);
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
              itemCount: data.result.length);
        } else if (data.state == FavoriteRestaurantState.error) {
          return Center(
            child: Text(data.message),
          );
        } else if (data.state == FavoriteRestaurantState.noData) {
          return const Center(
            child: Text("Data Kosong"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      })
      ),
    );
  }
}
