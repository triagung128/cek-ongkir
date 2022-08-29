import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/province_model.dart';
import '../../../data/models/city_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Ongkir'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DropdownSearch<Province>(
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Asal",
                border: OutlineInputBorder(),
              ),
            ),
            popupProps: PopupProps.dialog(
              fit: FlexFit.loose,
              itemBuilder: (_, item, __) => ListTile(
                title: Text("${item.province}"),
              ),
              showSearchBox: true,
            ),
            asyncItems: (_) async {
              var response = await Dio().get(
                controller.urlGetProvince,
                queryParameters: {
                  "key": controller.apiKey,
                },
              );
              var result = response.data["rajaongkir"]["results"];
              return Province.fromJsonList(result);
            },
            onChanged: (value) {
              controller.provAsalId.value = value?.provinceId ?? "0";
            },
          ),
          const SizedBox(height: 20),
          DropdownSearch<City>(
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota/Kabupaten Asal",
                border: OutlineInputBorder(),
              ),
            ),
            popupProps: PopupProps.dialog(
              fit: FlexFit.loose,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.type} ${item.cityName}"),
              ),
              showSearchBox: true,
            ),
            asyncItems: (_) async {
              var response = await Dio().get(
                controller.urlGetCity,
                queryParameters: {
                  "key": controller.apiKey,
                  "province": controller.provAsalId,
                },
              );
              var result = response.data["rajaongkir"]["results"];
              return City.fromJsonList(result);
            },
            onChanged: (value) {
              controller.cityAsalId.value = value?.cityId ?? "0";
            },
          ),
          const SizedBox(height: 20),
          DropdownSearch<Province>(
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Tujuan",
                border: OutlineInputBorder(),
              ),
            ),
            popupProps: PopupProps.dialog(
              fit: FlexFit.loose,
              itemBuilder: (_, item, __) => ListTile(
                title: Text("${item.province}"),
              ),
              showSearchBox: true,
            ),
            asyncItems: (_) async {
              var response = await Dio().get(
                controller.urlGetProvince,
                queryParameters: {
                  "key": controller.apiKey,
                },
              );
              var result = response.data["rajaongkir"]["results"];
              return Province.fromJsonList(result);
            },
            onChanged: (value) {
              controller.provTujuanId.value = value?.provinceId ?? "0";
            },
          ),
          const SizedBox(height: 20),
          DropdownSearch<City>(
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota/Kabupaten Tujuan",
                border: OutlineInputBorder(),
              ),
            ),
            popupProps: PopupProps.dialog(
              fit: FlexFit.loose,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.type} ${item.cityName}"),
              ),
              showSearchBox: true,
            ),
            asyncItems: (_) async {
              var response = await Dio().get(
                controller.urlGetCity,
                queryParameters: {
                  "key": controller.apiKey,
                  "province": controller.provTujuanId,
                },
              );
              var result = response.data["rajaongkir"]["results"];
              return City.fromJsonList(result);
            },
            onChanged: (value) {
              controller.cityTujuanId.value = value?.cityId ?? "0";
            },
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.weightC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Berat (gram)",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          DropdownSearch<Map<String, dynamic>>(
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Pilih Kurir",
                border: OutlineInputBorder(),
              ),
            ),
            items: const [
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
            ],
            popupProps: PopupProps.menu(
              fit: FlexFit.loose,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item["name"]}"),
              ),
            ),
            dropdownBuilder: (_, selectedItem) {
              return Text("${selectedItem?['name'] ?? "Pilih Kurir"}");
            },
            onChanged: (value) {
              controller.codeKurir.value = value?["code"] ?? "";
            },
          ),
          const SizedBox(height: 30),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.isFalse
                  ? () => controller.cekOngkir()
                  : null,
              child: Text(
                controller.isLoading.isFalse ? "CEK ONGKOS KIRIM" : "Loading",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
