import 'package:photographers_book/data/network/api_client.dart';

import '../data/network/api_endpoints.dart';
import '../model/sheet.dart';

class SheetRepo {
  Future createSheet({required body}) async {
    var response = await apiClient.post(Api.sheets, body);
    return response;
  }

  Future<List<Sheet>> getAllSheets({required query}) async {
    var response = await apiClient.get(Api.sheets, query: query);
    var list = response['data'] as List;
    return list.map((e) => Sheet.fromMap(e)).toList();
  }

  Future<Sheet> getOneSheet({required String id}) async {
    var response = await apiClient.get('${Api.sheets}/$id');
    return Sheet.fromMap(response);
  }

  Future updateSheet({required String id, required body}) async {
    var response = await apiClient.patch('${Api.sheets}/$id', body);
    return response;
  }

  Future deleteSheet({required String id}) async {
    var response = await apiClient.delete('${Api.sheets}/$id');
    return response;
  }
}
