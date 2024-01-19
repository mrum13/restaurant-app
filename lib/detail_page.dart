import 'package:flutter/material.dart';
import 'package:restaurant_app/academy.dart';
import 'package:restaurant_app/model/restaurant_model.dart';
import 'package:restaurant_app/widgets/card_facility.dart';

class DetailPage extends StatelessWidget {
  final int index;
  final RestaurantModel dataDetail;

  const DetailPage({super.key, required this.index, required this.dataDetail});

  @override
  Widget build(BuildContext context) {
    
    Widget buildTile(RestaurantModel restaurantModel) {
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
              child: Image.network(
                dataDetail.restaurants![index].pictureId!,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dataDetail.restaurants![index].menus.foods[],
                    style: TextStyle(
                      fontSize: 12
                    ),
                  ),
                  Text(
                    "subtitle",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey),
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
            
            Column(
              children: [
                Image.network(
                  dataDetail.restaurants![index].pictureId!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                ),
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
                                dataDetail.restaurants![index].name!,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
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
                                    dataDetail.restaurants![index].city!,
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
                              Text(dataDetail.restaurants![index].rating.toString())
                            ],
                          )
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
                      const Text(
                        "Deskripsi dari restaurant",
                        style: TextStyle(
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
                            children: dataDetail.restaurants![index].menus.foods.map(buildTile).toList(),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
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
                      shape: BoxShape.circle,
                      color: Colors.black38
                    ),
                    child: Image.asset("assets/ic_back.png",
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
