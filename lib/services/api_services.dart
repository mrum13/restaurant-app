import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:restaurant_app/common/common_url.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/searched_restaurant.dart';

class ApiServices {
  Future<Restaurant> getListRestaurant() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      throw "Terdapat masalah pada jaringan";
    } else {
      try {
        var url = '$baseUrl/list';
        var header = {
          'Accept': 'application/json',
        };
        var response = await http.get(
          Uri.parse(url),
          headers: header,
        );
        var data = jsonDecode(response.body);

        print("Status code list data : ${response.statusCode}");

        if (response.statusCode == 200) {
          return Restaurant.fromJson(data);
        } else {
          throw data['message'];
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<SearchedRestaurant> searchRestaurant({required String value}) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      throw "Terdapat masalah pada jaringan";
    } else {
      try {
        var url = '$baseUrl/search?q=$value';
        var header = {
          'Accept': 'application/json',
        };
        var response = await http.get(
          Uri.parse(url),
          headers: header,

        );
        var data = jsonDecode(response.body);

        print("Status code search data : ${response.statusCode}");

        if (response.statusCode == 200) {
          return SearchedRestaurant.fromJson(data);
        } else {
          throw data['message'];
        }
      } catch (e) {
        rethrow;
      }
    }
  }
}
