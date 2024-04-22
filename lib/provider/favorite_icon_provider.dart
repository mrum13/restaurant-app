import 'package:flutter/material.dart';
import 'package:restaurant_app/services/api_services.dart';

// Enum untuk menyatakan state gamba

class FavoriteIconProvider extends ChangeNotifier {
  bool _imageState = false;

  bool get imageState => _imageState;

  void isFavorite({required String id}) async {

    final status = await ApiServices().checkIsFavorite(id: id);

    if (status) {
      _imageState = true;
    } else {
      _imageState = false;
    }
    notifyListeners();
  }
}
