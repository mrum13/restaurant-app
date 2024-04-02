import 'package:flutter/material.dart';
import 'package:restaurant_app/model/favorite_restaurant.dart';
import 'package:restaurant_app/services/api_services.dart';

enum FavoriteRestaurantState { loading, noData, hasData, error, init }

class GetFavoriteRestaurantProvider extends ChangeNotifier {

  late List<FavoriteRestaurantData> _restaurant;
  FavoriteRestaurantState _state = FavoriteRestaurantState.init;
  String _message = '';

  String get message => _message;

  List<FavoriteRestaurantData> get result => _restaurant;

  FavoriteRestaurantState get state => _state;

  Future<dynamic> getFavoriteRestaurant() async {
    try {
      _state = FavoriteRestaurantState.loading;
      notifyListeners();

      final restaurantData = await ApiServices().getFavoriteRestaurant();

      if (restaurantData.isEmpty) {
        _state = FavoriteRestaurantState.noData;
        notifyListeners();
        return _message = 'Data Kosong';
      } else {
        _state = FavoriteRestaurantState.hasData;
        notifyListeners();
        return _restaurant = restaurantData;
      }
    } catch (e) {
      _state = FavoriteRestaurantState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}