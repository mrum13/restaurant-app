import 'dart:convert';

Restaurant restaurantFromJson(String str) => Restaurant.fromJson(json.decode(str));

String restaurantToJson(Restaurant data) => json.encode(data.toJson());

class Restaurant {
    bool? error;
    String? message;
    int? count;
    List<RestaurantElement>? restaurants;

    Restaurant({
        this.error,
        this.message,
        this.count,
        this.restaurants = const [],
    });

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestaurantElement>.from(json["restaurants"].map((x) => RestaurantElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<RestaurantElement>.from(restaurants!.map((x) => x.toJson())),
    };
}

class RestaurantElement {
    String? id;
    String? name;
    String? description;
    String? pictureId;
    String? city;
    dynamic rating;

    RestaurantElement({
        this.id,
        this.name,
        this.description,
        this.pictureId,
        this.city,
        this.rating,
    });

    factory RestaurantElement.fromJson(Map<String, dynamic> json) => RestaurantElement(
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
