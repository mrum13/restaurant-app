import 'package:flutter/material.dart';
import 'package:restaurant_app/model/searched_restaurant.dart';
import 'package:restaurant_app/services/api_services.dart';

enum ResultState { loading, noData, hasData, error, init }

class ListRestaurantSearchedProvider extends ChangeNotifier {

  // ListRestaurantSearchedProvider({required String value}) {
  //   _fetchListRestaurantSearched(value: value);
  // }

  late SearchedRestaurant _restaurant;
  ResultState _state = ResultState.init;
  String _message = '';
 
  String get message => _message;
 
  SearchedRestaurant get result => _restaurant;
 
  ResultState get state => _state;
 
  Future<dynamic> fetchListRestaurantSearched({required String value}) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantData = await ApiServices().searchRestaurant(value: value);
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
      return _message = 'Error --> $e';
    }
  }

}