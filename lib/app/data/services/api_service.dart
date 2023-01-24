import 'package:dio/dio.dart';

import '../models/city_model.dart';
import '../models/ongkir_model.dart';
import '../models/province_model.dart';

class ApiService {
  final _apiKey = "7c417890b102d40434ef75d7a67849fe";

  final _urlGetProvince = "https://api.rajaongkir.com/starter/province";
  final _urlGetCity = "https://api.rajaongkir.com/starter/city";
  final _urlCost = "https://api.rajaongkir.com/starter/cost";

  Future<List<Province>> getProvinces() async {
    final response = await Dio().get(
      _urlGetProvince,
      queryParameters: {
        "key": _apiKey,
      },
    );

    final result = response.data["rajaongkir"]["results"];
    return Province.fromJsonList(result);
  }

  Future<List<City>> getCities(String idProvince) async {
    final response = await Dio().get(
      _urlGetCity,
      queryParameters: {
        "key": _apiKey,
        "province": idProvince,
      },
    );

    final result = response.data["rajaongkir"]["results"];
    return City.fromJsonList(result);
  }

  Future<List<Ongkir>> getCosts(
    String originCityId,
    String destinationCityId,
    String weight,
    String courier,
  ) async {
    final response = await Dio().post(
      _urlCost,
      options: Options(
        headers: {
          "key": _apiKey,
          "content-type": "application/x-www-form-urlencoded",
        },
      ),
      data: {
        "origin": originCityId,
        "destination": destinationCityId,
        "weight": weight,
        "courier": courier,
      },
    );

    final List costs = response.data["rajaongkir"]["results"][0]["costs"];
    return Ongkir.fromJsonList(costs);
  }
}
