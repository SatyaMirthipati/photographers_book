import 'package:flutter/cupertino.dart';

class MainBloc with ChangeNotifier {
  int index = 0;
  int tab = 0;

  void updateIndex(int value) {
    index = value;
    notifyListeners();
  }

  void updateTab(int index) {
    tab = index;
    notifyListeners();
  }
}
