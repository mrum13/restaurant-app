import 'dart:convert';

import 'package:restaurant_app/model/restaurant_model.dart';

class GetDataServices {
  RestaurantModel getDataRestaurant(String jsonString) {
    var dataJson = jsonDecode(jsonString);

    try {
      RestaurantModel data = RestaurantModel.fromJson(dataJson);

      return data;
    } catch (e) {
      throw(e.toString());
    }
  } 
}