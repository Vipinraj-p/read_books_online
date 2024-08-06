import 'package:flutter/material.dart';

class SearchButtonProvider with ChangeNotifier {
  bool istapped = false;
  void onbuttontap() {
    istapped = !istapped;
    notifyListeners();
  }
}
