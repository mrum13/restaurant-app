import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant.dart';
import 'package:restaurant_app/services/api_services.dart';

enum DetailRestaurantState { loading, noData, hasData, error, init }

class DetailRestaurantProvider extends ChangeNotifier {
  late RestaurantDetailData _restaurant;
  DetailRestaurantState _state = DetailRestaurantState.init;
  String _message = '';

  String get message => _message;

  RestaurantDetailData get result => _restaurant;

  DetailRestaurantState get state => _state;

  Future<dynamic> fetchDetailRestaurant({required String id}) async {
    try {
      _state = DetailRestaurantState.loading;
      notifyListeners();
      final restaurantData = await ApiServices().getDetailRestaurant(id: id);
      _state = DetailRestaurantState.hasData;
      notifyListeners();
      return _restaurant = restaurantData.restaurant!;
    } catch (e) {
      _state = DetailRestaurantState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
