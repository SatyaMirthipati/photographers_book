import 'package:photographers_book/data/network/api_client.dart';

import '../data/network/api_endpoints.dart';
import '../model/category.dart';

class BookingRepo {
  Future<List<Category>> getCategories({query}) async {
    var response = await apiClient.get(Api.categories, query: query);
    var list = response['data'] as List;
    return list.map((e) => Category.fromMap(e)).toList();
  }
}
