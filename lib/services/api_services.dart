import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/common/common_url.dart';
import 'package:restaurant_app/common/shared_prefrences.dart';
import 'package:restaurant_app/model/detail_restaurant.dart';
import 'package:restaurant_app/model/favorite_restaurant.dart';
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

  Future<DetailRestaurant> getDetailRestaurant({required String id}) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      throw "Terdapat masalah pada jaringan";
    } else {
      try {
        var url = '$baseUrl/detail/$id';
        var header = {
          'Accept': 'application/json',
        };
        var response = await http.get(
          Uri.parse(url),
          headers: header,
        );
        var data = jsonDecode(response.body);

        print("Status get detail restaurant : ${response.statusCode}");

        if (response.statusCode == 200) {
          return DetailRestaurant.fromJson(data);
        } else {
          throw data['message'];
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<bool> setFavoriteRestaurant({required String id}) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      throw "Terdapat masalah pada jaringan";
    } else {
      try {
        var url = '$baseUrl/detail/$id';
        var header = {
          'Accept': 'application/json',
        };
        var response = await http.get(
          Uri.parse(url),
          headers: header,
        );

        var data = jsonDecode(response.body);

        print(
            "Status get detail for favorite restaurant : ${response.statusCode}");

        if (response.statusCode == 200) {
          var dataResult = jsonDecode(response.body)['restaurant'];

          // List<FavoriteRestaurantData> listData = [];

          List<FavoriteRestaurantData> listDataGet =
              await getFavoriteRestaurant();

          bool isAlreadyFavorite =
              listDataGet.any((restaurant) => restaurant.id == id);

          if (isAlreadyFavorite) {
            listDataGet.removeWhere((element) => element.id==id);
            String dataToSave = jsonEncode(listDataGet);
            SharedPreference.favoriteRestaurant
                ?.setString("favorite-restaurant", dataToSave);
            return false;
          } else {
            listDataGet.add(FavoriteRestaurantData.fromJson(dataResult));

            String dataToSave = jsonEncode(listDataGet);
            SharedPreference.favoriteRestaurant
                ?.setString("favorite-restaurant", dataToSave);

            return true;
          }
        } else {
          throw data['message'];
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<List<FavoriteRestaurantData>> getFavoriteRestaurant() async {
    var data =
        SharedPreference.favoriteRestaurant.getString("favorite-restaurant");

    try {
      if (data != null) {
        List<Map<String, dynamic>> mapData =
            List<Map<String, dynamic>>.from(jsonDecode(data));
        List<FavoriteRestaurantData> list =
            mapData.map((e) => FavoriteRestaurantData.fromJson(e)).toList();
        return list;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkIsFavorite({required String id}) async {
    List<FavoriteRestaurantData> listDataGet = await getFavoriteRestaurant();

    bool isAlreadyFavorite =listDataGet.any((restaurant) => restaurant.id == id);

    return isAlreadyFavorite;
  } 
}
