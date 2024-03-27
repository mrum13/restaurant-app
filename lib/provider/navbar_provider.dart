import 'package:flutter/material.dart';

class NavbarProvider extends ChangeNotifier {
  var state = 0;

  void setIndex({required int index}) {
    state = index;
    notifyListeners();
  }
}