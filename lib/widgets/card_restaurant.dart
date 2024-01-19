import 'package:flutter/material.dart';
import 'package:restaurant_app/detail_page.dart';
import 'package:restaurant_app/model/restaurant_model.dart';

class CardRestaurant extends StatelessWidget {
  final RestaurantModel data;
  final String image;
  final String title;
  final String location;
  final String rating;
  final int index;

  const CardRestaurant({
    super.key,
    required this.data,
    required this.image,
    required this.title,
    required this.location,
    required this.rating,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(dataDetail: data.restaurants![index])));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                image,
                height: 70,
                width: 70,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                        location,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 8,),
            Icon(
              Icons.star,
              color: Colors.amber[400],
            ),
            const SizedBox(
              width: 4,
            ),
            Text(rating)
          ],
        ),
      ),
    );
  }
}
