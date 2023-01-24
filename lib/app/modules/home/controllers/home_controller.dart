import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/city_model.dart';
import '../../../data/models/province_model.dart';
import '../../../data/services/api_service.dart';

class HomeController extends GetxController {
  final weightC = TextEditingController();
  final apiService = ApiService();

  final couriers = [
    {
      "code": "jne",
      "name": "JNE",
    },
    {
      "code": "pos",
      "name": "POS Indonesia",
    },
    {
      "code": "tiki",
      "name": "TIKI",
    },
  ];

  Province? originProvince;
  City? originCity;
  Province? destinationProvince;
  City? destinationCity;

  RxString courierCode = "".obs;
  RxBool isLoading = false.obs;

  Future<List<Province>> getProvinces() async {
    return await apiService.getProvinces();
  }

  Future<List<City>> getCities() async {
    return await apiService.getCities(originProvince!.provinceId!);
  }

  setOriginProvince(Province? province) {
    originProvince = province;
    originCity = null;
    update();
  }

  setOriginCity(City? city) {
    originCity = city;
    update();
  }

  setDestinationProvince(Province? province) {
    destinationProvince = province;
    destinationCity = null;
    update();
  }

  setDetsinationCity(City? city) {
    destinationCity = city;
    update();
  }

  setCourierCode(String courierCode) {
    this.courierCode.value = courierCode;
  }

  cekOngkir() async {
    if (originProvince != null &&
        destinationProvince != null &&
        originCity != null &&
        destinationCity != null &&
        courierCode.value != "" &&
        weightC.text != "") {
      try {
        isLoading.value = true;
        final dataOngkir = await apiService.getCosts(
          originCity!.cityId!,
          destinationCity!.cityId!,
          weightC.text,
          courierCode.value,
        );
        isLoading.value = false;

        Get.defaultDialog(
          titlePadding: const EdgeInsets.all(16),
          title: "ONGKOS KIRIM",
          content: Column(
            children: dataOngkir
                .map(
                  (item) => ListTile(
                    title: Text(item.service!.toUpperCase()),
                    subtitle: Text("Rp. ${item.cost![0].value}"),
                  ),
                )
                .toList(),
          ),
        );
      } catch (e) {
        if (kDebugMode) print(e);
        Get.defaultDialog(
          title: "TERJADI KESALAHAN",
          middleText: "Tidak dapat mengecek ongkos kirim",
        );
      }
    } else {
      Get.defaultDialog(
        middleText: "Mohon lengkapi form",
      );
    }
  }
}
