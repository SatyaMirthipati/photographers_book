import 'package:flutter/material.dart';

import '../model/sheet.dart';
import '../repository/sheet_repo.dart';

class SheetBloc with ChangeNotifier {
  final _sheetRepo = SheetRepo();

  Future createSheet({required body}) async {
    return await _sheetRepo.createSheet(body: body);
  }

  Future<List<Sheet>> getAllSheets({required query}) async {
    return await _sheetRepo.getAllSheets(query: query);
  }

  Future<Sheet> getOneSheet({required String id}) async {
    return await _sheetRepo.getOneSheet(id: id);
  }

  Future updateSheet({required String id, required body}) async {
    return await _sheetRepo.updateSheet(id: id, body: body);
  }

  Future deleteSheet({required String id}) async {
    return await _sheetRepo.deleteSheet(id: id);
  }
}
