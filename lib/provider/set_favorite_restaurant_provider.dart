import 'package:flutter/material.dart';
import 'package:restaurant_app/services/api_services.dart';

enum ResultStateFavorite { loading, noData, hasData, error, init }

class SetFavoriteRestaurantProvider extends ChangeNotifier {
  late bool resultData;
  ResultStateFavorite _state = ResultStateFavorite.init;
  String _message = '';

  String get message => _message;

  bool get result => resultData;

  ResultStateFavorite get state => _state;

  Future<dynamic> setFavoriteRestaurant({required String id}) async {
    try {
      _state = ResultStateFavorite.loading;
      notifyListeners();
      final restaurantData = await ApiServices().setFavoriteRestaurant(id: id);
      _state = ResultStateFavorite.hasData;
      notifyListeners();
      return resultData = restaurantData;
    } catch (e) {
      _state = ResultStateFavorite.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );

    notifyListeners();
  }
}