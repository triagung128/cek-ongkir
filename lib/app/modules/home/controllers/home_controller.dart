import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/city_model.dart';
import '../../../data/models/courier_model.dart';
import '../../../data/models/province_model.dart';
import '../../../data/services/api_service.dart';

class HomeController extends GetxController {
  final weightC = TextEditingController();
  final apiService = ApiService();

  final couriers = [
    Courier(
      code: "jne",
      name: "JNE",
    ),
    Courier(
      code: "pos",
      name: "POS Indonesia",
    ),
    Courier(
      code: "tiki",
      name: "TIKI",
    ),
  ];

  Province? originProvince;
  City? originCity;
  Province? destinationProvince;
  City? destinationCity;
  Courier? courier;

  RxBool isLoading = false.obs;

  Future<List<Province>> getProvinces() async {
    return await apiService.getProvinces();
  }

  Future<List<City>> getCities(bool isOrigin) async {
    return await apiService.getCities(
      isOrigin ? originProvince!.provinceId! : destinationProvince!.provinceId!,
    );
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

  setDestinationCity(City? city) {
    destinationCity = city;
    update();
  }

  setCourierCode(Courier? courier) {
    this.courier = courier;
  }

  cekOngkir() async {
    if (originCity != null &&
        destinationCity != null &&
        courier != null &&
        weightC.text != "") {
      try {
        isLoading.value = true;
        final dataOngkir = await apiService.getCosts(
          originCity!.cityId!,
          destinationCity!.cityId!,
          weightC.text,
          courier!.code!,
        );
        isLoading.value = false;

        Get.defaultDialog(
          titlePadding: const EdgeInsets.all(16),
          title: "ONGKOS KIRIM",
          contentPadding: const EdgeInsets.all(16),
          content: SizedBox(
            height: 350,
            width: 250,
            child: Column(
              children: [
                Text('Kurir : ${courier!.name}'),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: dataOngkir.length,
                    itemBuilder: (_, index) {
                      final item = dataOngkir[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          tileColor: Colors.blueGrey[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: Text(item.service!.toUpperCase()),
                          subtitle: Text("Rp. ${item.cost![0].value}"),
                          trailing: const Icon(Icons.local_shipping),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      } catch (e) {
        if (kDebugMode) print(e);
        isLoading.value = false;
        Get.defaultDialog(
          titlePadding: const EdgeInsets.all(16),
          contentPadding: const EdgeInsets.all(16),
          title: "TERJADI KESALAHAN",
          middleText: "Tidak dapat mengecek ongkos kirim",
          textConfirm: 'Oke',
          confirmTextColor: Colors.white,
          onConfirm: () => Get.back(),
        );
      }
    } else {
      Get.defaultDialog(
        titlePadding: const EdgeInsets.all(16),
        contentPadding: const EdgeInsets.all(16),
        title: 'Peringatan !',
        middleText: 'Mohon lengkapi form',
        textConfirm: 'Oke',
        confirmTextColor: Colors.white,
        onConfirm: () => Get.back(),
      );
    }
  }
}
