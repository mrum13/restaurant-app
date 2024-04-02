import 'package:flutter/material.dart';
import 'package:restaurant_app/services/api_services.dart';

// Enum untuk menyatakan state gamba

class FavoriteIconProvider extends ChangeNotifier {
  bool _imageState = false;

  // Getter untuk mendapatkan state gambar
  bool get imageState => _imageState;

  // Fungsi untuk menyembunyikan/menampilkan gambar
  void isFavorite({required String id}) async {
    // _imageState = _imageState == FavoriteIconState.unfavorite
    //     ? FavoriteIconState.favorite
    //     : FavoriteIconState.unfavorite;
    // notifyListeners();

    final status = await ApiServices().checkIsFavorite(id: id);

    if (status) {
      _imageState = true;
    } else {
      _imageState = false;
    }
    notifyListeners();
  }
}
