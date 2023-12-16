import 'package:photographers_book/data/network/api_client.dart';

import '../data/network/api_endpoints.dart';
import '../model/sheet.dart';

class SheetRepo {
  Future<List<Sheet>> getAllSheets({required query}) async {
    var response = await apiClient.get(Api.sheets, query: query);
    var list = response as List;
    return list.map((e) => Sheet.fromMap(e)).toList();
  }
}
