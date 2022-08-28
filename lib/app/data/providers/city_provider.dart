import 'package:get/get.dart';

import '../models/city_model.dart';

class CityProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return City.fromJson(map);
      if (map is List) return map.map((item) => City.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<City?> getCity(int id) async {
    final response = await get('city/$id');
    return response.body;
  }

  Future<Response<City>> postCity(City city) async => await post('city', city);
  Future<Response> deleteCity(int id) async => await delete('city/$id');
}
