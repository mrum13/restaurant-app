import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/common_url.dart';
import 'package:restaurant_app/model/favorite_restaurant.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/favorite_icon_provider.dart';

class CardFavorite extends StatelessWidget {
  final FavoriteRestaurantData restaurantElement;

  const CardFavorite({
    super.key,
    required this.restaurantElement
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<DetailRestaurantProvider>().fetchDetailRestaurant(id: restaurantElement.id!);
        context.read<FavoriteIconProvider>().isFavorite(id: restaurantElement.id!);
        Navigator.pushNamed(context, '/detail');
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
                "$imageUrlMedium/${restaurantElement.pictureId}",
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
                    restaurantElement.name!,
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
                        restaurantElement.city!,
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
            Text(restaurantElement.rating.toString()),
            const SizedBox(width: 8,),
          ],
        ),
      ),
    );
  }
}
