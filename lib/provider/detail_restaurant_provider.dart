import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant.dart';
import 'package:restaurant_app/services/api_services.dart';

enum ResultState { loading, noData, hasData, error, init }

class DetailRestaurantProvider extends ChangeNotifier {
  late RestaurantDetailData _restaurant;
  ResultState _state = ResultState.init;
  String _message = '';

  String get message => _message;

  RestaurantDetailData get result => _restaurant;

  ResultState get state => _state;

  Future<dynamic> fetchDetailRestaurant({required String id}) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantData = await ApiServices().getDetailRestaurant(id: id);
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurant = restaurantData.restaurant!;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
