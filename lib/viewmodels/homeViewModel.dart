import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  String _title = "Welcome to Home";

  String get title => _title;

  void updateTitle(String newTitle) {
    _title = newTitle;
    notifyListeners(); // Notify UI to rebuild
  }
}
