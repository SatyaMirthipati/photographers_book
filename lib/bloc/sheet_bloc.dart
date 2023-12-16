import 'package:flutter/material.dart';

import '../model/sheet.dart';
import '../repository/sheet_repo.dart';

class SheetBloc with ChangeNotifier {
  final _sheetRepo = SheetRepo();

  Future<List<Sheet>> getAllSheets({required query}) async {
    return await _sheetRepo.getAllSheets(query: query);
  }
}
