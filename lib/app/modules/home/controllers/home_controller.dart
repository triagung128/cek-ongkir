import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../data/models/ongkir_model.dart';

class HomeController extends GetxController {
  String apiKey = "7c417890b102d40434ef75d7a67849fe";

  String urlGetProvince = "https://api.rajaongkir.com/starter/province";
  String urlGetCity = "https://api.rajaongkir.com/starter/city";
  String urlCost = "https://api.rajaongkir.com/starter/cost";

  TextEditingController weightC = TextEditingController();

  RxBool isLoading = false.obs;

  RxString provAsalId = "0".obs;
  RxString cityAsalId = "0".obs;
  RxString provTujuanId = "0".obs;
  RxString cityTujuanId = "0".obs;

  RxString codeKurir = "".obs;

  List<Ongkir> dataOngkir = [];

  void cekOngkir() async {
    if (provAsalId.value != "0" &&
        provTujuanId.value != "0" &&
        cityAsalId.value != "0" &&
        cityTujuanId.value != "0" &&
        codeKurir.value != "" &&
        weightC.text != "") {
      try {
        isLoading.value = true;
        var response = await Dio().post(
          urlCost,
          options: Options(
            headers: {
              "key": apiKey,
              "content-type": "application/x-www-form-urlencoded",
            },
          ),
          data: {
            "origin": cityAsalId.value,
            "destination": cityTujuanId.value,
            "weight": weightC.text,
            "courier": codeKurir.value,
          },
        );
        isLoading.value = false;
        List ongkir =
            response.data["rajaongkir"]["results"][0]["costs"] as List;
        dataOngkir = Ongkir.fromJsonList(ongkir);

        Get.defaultDialog(
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
        title: "TERJADI KESALAHAN",
        middleText: "Data input belum lengkap",
      );
    }
  }
}
