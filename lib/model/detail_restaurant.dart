// To parse this JSON data, do
//
//     final detailRestaurant = detailRestaurantFromJson(jsonString);

import 'dart:convert';

DetailRestaurant detailRestaurantFromJson(String str) => DetailRestaurant.fromJson(json.decode(str));

String detailRestaurantToJson(DetailRestaurant data) => json.encode(data.toJson());

class DetailRestaurant {
    bool? error;
    String? message;
    RestaurantDetailData? restaurant;

    DetailRestaurant({
        this.error,
        this.message,
        this.restaurant,
    });

    factory DetailRestaurant.fromJson(Map<String, dynamic> json) => DetailRestaurant(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetailData.fromJson(json["restaurant"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant!.toJson(),
    };
}

class RestaurantDetailData {
    String? id;
    String? name;
    String? description;
    String? city;
    String? address;
    String? pictureId;
    List<Category> categories;
    Menus menus;
    double? rating;
    List<CustomerReview> customerReviews;

    RestaurantDetailData({
        this.id,
        this.name,
        this.description,
        this.city,
        this.address,
        this.pictureId,
        required this.categories,
        required this.menus,
        this.rating,
        required this.customerReviews,
    });

    factory RestaurantDetailData.fromJson(Map<String, dynamic> json) => RestaurantDetailData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus.toJson(),
        "rating": rating,
        "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
    };
}

class Category {
    String? name;

    Category({
        this.name,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class Foods {
    String? name;

    Foods({
        this.name,
    });

    factory Foods.fromJson(Map<String, dynamic> json) => Foods(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class Drinks {
    String? name;

    Drinks({
        this.name,
    });

    factory Drinks.fromJson(Map<String, dynamic> json) => Drinks(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class CustomerReview {
    String? name;
    String? review;
    String? date;

    CustomerReview({
        this.name,
        this.review,
        this.date,
    });

    factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
    };
}

class Menus {
    List<Foods> foods;
    List<Drinks> drinks;

    Menus({
        required this.foods,
        required this.drinks,
    });

    factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Foods>.from(json["foods"].map((x) => Foods.fromJson(x))),
        drinks: List<Drinks>.from(json["drinks"].map((x) => Drinks.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
    };
}
