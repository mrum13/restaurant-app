import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/services/api_services.dart';

enum ResultState { loading, noData, hasData, error, init }

class ListRestaurantProvider extends ChangeNotifier {
  ///state
  ResultState _state = ResultState.init;
  ResultState get state => _state;

  ///data
  Restaurant _restaurant = Restaurant(restaurants: []);
  Restaurant get result => _restaurant;

  ///message error
  String _message = '';
  String get message => _message;

  Future<dynamic> fetchListRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantData = await ApiServices().getListRestaurant();
      if (restaurantData.restaurants!.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurant = restaurantData;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '$e';
    }
  }

}