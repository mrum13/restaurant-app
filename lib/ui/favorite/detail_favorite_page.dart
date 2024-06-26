import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/file_helper.dart';
import 'package:restaurant_app/model/favorite_restaurant.dart';
import 'package:restaurant_app/provider/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/get_favorite_restaurant_provider.dart';
import 'package:restaurant_app/provider/set_favorite_restaurant_provider.dart';
import 'package:restaurant_app/widgets/card_facility.dart';

class DetailFavoritePage extends StatelessWidget {
  const DetailFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String indexData =
        ModalRoute.of(context)!.settings.arguments as String;
    var listPictureDrink = [
      'assets/img_minuman_1.png',
      'assets/img_minuman_2.png',
      'assets/img_minuman_3.png'
    ];
    var listPictureFood = [
      'assets/img_makanan_1.png',
      'assets/img_makanan_2.png',
      'assets/img_makanan_3.png',
      'assets/img_makanan_4.png',
      'assets/img_makanan_5.png'
    ];

    final random = new Random();

    String id = "-";

    Widget buildTileFood(Foods foodMenu) {
      return Container(
        width: 155,
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3), // Warna shadow
                spreadRadius: 2, // Radius penyebaran shadow
                blurRadius: 7, // Radius blur shadow
                offset: const Offset(3, 3), // Perpindahan shadow
              ),
            ],
            borderRadius: BorderRadius.circular(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14), topRight: Radius.circular(14)),
              child: Image.asset(
                listPictureFood[random.nextInt(listPictureFood.length)],
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodMenu.name!,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const Text(
                    "Rp.20.000",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget buildTileDrink(Drinks drinkMenu) {
      return Container(
        width: 155,
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3), // Warna shadow
                spreadRadius: 2, // Radius penyebaran shadow
                blurRadius: 7, // Radius blur shadow
                offset: const Offset(3, 3), // Perpindahan shadow
              ),
            ],
            borderRadius: BorderRadius.circular(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14), topRight: Radius.circular(14)),
              child: Image.asset(
                listPictureDrink[random.nextInt(listPictureDrink.length)],
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    drinkMenu.name!,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const Text(
                    "Rp.20.000",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Consumer(builder:
                (context, GetFavoriteRestaurantProvider data, snapshot) {
              if (data.state == FavoriteRestaurantState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.state == FavoriteRestaurantState.hasData) {
                List<FavoriteRestaurantData> listData = data.result;
                int indexDataDetail =
                    listData.indexWhere((element) => element.id == indexData);

                id = listData[indexDataDetail].id;

                return Column(
                  children: [
                    FutureBuilder(
                        future: openImage(
                            title: id,
                            subtitle: listData[indexDataDetail].name),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Image.file(
                              File(listData[indexDataDetail].pictureId),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 300,
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listData[indexDataDetail].name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        listData[indexDataDetail].city,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber[400],
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(listData[indexDataDetail]
                                      .rating
                                      .toString()),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Consumer<SetFavoriteRestaurantProvider>(
                                      builder: (context,
                                          SetFavoriteRestaurantProvider data,
                                          snapshot) {
                                    if (data.state ==
                                        ResultStateFavorite.hasData) {
                                      context
                                          .read<FavoriteIconProvider>()
                                          .isFavorite(id: id);
                                    }

                                    return InkWell(
                                      onTap: () {
                                        context
                                            .read<
                                                SetFavoriteRestaurantProvider>()
                                            .setFavoriteRestaurant(id: id);
                                      },
                                      child: Consumer<FavoriteIconProvider>(
                                          builder: (context,
                                              FavoriteIconProvider data,
                                              snapshot) {
                                        if (!data.imageState) {
                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            context
                                                .read<
                                                    GetFavoriteRestaurantProvider>()
                                                .deleteRestaurant();
                                          });
                                        }
                                        return Icon(
                                          Icons.favorite,
                                          color: data.imageState
                                              ? Colors.red
                                              : Colors.grey,
                                        );
                                      }),
                                    );
                                  })
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "Deskripsi",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            listData[indexDataDetail].description,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "Fasilitas",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const CardFacility(title: "Toilet", title1: "Wi-Fi"),
                          const SizedBox(
                            height: 8,
                          ),
                          const CardFacility(
                              title: "Live Music", title1: "Mushollah"),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "Menu Makanan",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomScrollView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            slivers: [
                              SliverGrid.count(
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                crossAxisCount: 2,
                                children: listData[indexDataDetail]
                                    .menus
                                    .foods
                                    .map(buildTileFood)
                                    .toList(),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "Menu Minuman",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomScrollView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            slivers: [
                              SliverGrid.count(
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                crossAxisCount: 2,
                                children: listData[indexDataDetail]
                                    .menus
                                    .drinks
                                    .map(buildTileDrink)
                                    .toList(),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              } else if (data.state == FavoriteRestaurantState.deleted) {
                Future.delayed(Duration.zero, () {
                  Navigator.pop(context);
                  
                });

                return const SizedBox();
              } else {
                return Center(
                  child: Text(data.message),
                );
              }
            }),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black38),
                    child: Image.asset(
                      "assets/ic_back.png",
                      height: 24,
                      width: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
