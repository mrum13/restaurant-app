// To parse this JSON data, do
//
//     final searchedRestaurant = searchedRestaurantFromJson(jsonString);

import 'dart:convert';

SearchedRestaurant searchedRestaurantFromJson(String str) => SearchedRestaurant.fromJson(json.decode(str));

String searchedRestaurantToJson(SearchedRestaurant data) => json.encode(data.toJson());

class SearchedRestaurant {
    bool? error;
    int? founded;
    List<RestaurantList> restaurants;

    SearchedRestaurant({
        this.error,
        this.founded,
        required this.restaurants,
    });

    factory SearchedRestaurant.fromJson(Map<String, dynamic> json) => SearchedRestaurant(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantList>.from(json["restaurants"].map((x) => RestaurantList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class RestaurantList {
    String? id;
    String? name;
    String? description;
    String? pictureId;
    String? city;
    dynamic rating;

    RestaurantList({
        this.id,
        this.name,
        this.description,
        this.pictureId,
        this.city,
        this.rating,
    });

    factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
        id: json["id"] ?? "-",
        name: json["name"] ?? "-",
        description: json["description"] ?? "-",
        pictureId: json["pictureId"] ?? "-",
        city: json["city"] ?? "-",
        rating: json["rating"] ?? 0.0,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
    };
}
