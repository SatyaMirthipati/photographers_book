import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleBloc with ChangeNotifier {
  bool selected = true;
  int selectedIndex = DateTime.now().month - 1;
  String month = '';

  setIndex(index) {
    selectedIndex = index;
    notifyListeners();
  }

  DateTime dateTime = DateTime.now();

  final List<String> months = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  void setDate(DateTime dt) {
    dateTime = dt;
    notifyListeners();
  }

  String getMonthWithYear() {
    return DateFormat('MMM yyyy').format(dateTime);
  }

  String getMonth() {
    return DateFormat('MMMM').format(dateTime);
  }

  String getYear() {
    return DateFormat('yyyy').format(dateTime);
  }
}
