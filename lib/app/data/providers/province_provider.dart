import 'package:get/get.dart';

import '../models/province_model.dart';

class ProvinceProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Province.fromJson(map);
      if (map is List) {
        return map.map((item) => Province.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Province?> getProvince(int id) async {
    final response = await get('province/$id');
    return response.body;
  }

  Future<Response<Province>> postProvince(Province province) async =>
      await post('province', province);
  Future<Response> deleteProvince(int id) async => await delete('province/$id');
}
