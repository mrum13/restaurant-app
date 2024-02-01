import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/services/api_services.dart';

enum ResultState { loading, noData, hasData, error, init }

class ListRestaurantProvider extends ChangeNotifier {

  // ListRestaurantProvider() {
  //   fetchListRestaurant();
  // }

  late Restaurant _restaurant;
  ResultState _state = ResultState.init;
  String _message = '';
 
  String get message => _message;
 
  Restaurant get result => _restaurant;
 
  ResultState get state => _state;
 
  Future<dynamic> fetchListRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantData = await ApiServices().getListRestaurant();
      if (restaurantData.restaurants.isEmpty) {
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