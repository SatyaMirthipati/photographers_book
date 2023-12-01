import 'package:flutter/foundation.dart';

class ProgressBloc with ChangeNotifier {
  bool progress = false;

  void enableProgress() {
    progress = true;
    notifyListeners();
  }

  void disableProgress() {
    progress = false;
    notifyListeners();
  }
}
