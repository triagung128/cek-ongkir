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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.local_shipping),
            SizedBox(width: 12),
            Text('Cek Ongkir'),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Asal :',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
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
              searchFieldProps: const TextFieldProps(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Cari Provinsi',
                  isDense: true,
                ),
              ),
              title: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: const Text(
                  'Provinsi Asal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            asyncItems: (_) async => await controller.getProvinces(),
            onChanged: (province) => controller.setOriginProvince(province),
          ),
          const SizedBox(height: 20),
          GetBuilder<HomeController>(
            builder: (_) {
              return DropdownSearch<City>(
                selectedItem: controller.originCity,
                enabled: controller.originProvince == null ? false : true,
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Kota/Kabupaten Asal",
                    border: OutlineInputBorder(),
                  ),
                ),
                popupProps: PopupProps.dialog(
                  fit: FlexFit.loose,
                  itemBuilder: (_, item, __) => ListTile(
                    title: Text("${item.type} ${item.cityName}"),
                  ),
                  showSearchBox: true,
                  searchFieldProps: const TextFieldProps(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Cari Kota',
                      isDense: true,
                    ),
                  ),
                  title: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                    child: const Text(
                      'Kota/Kabupaten Asal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                asyncItems: (_) async => await controller.getCities(),
                onChanged: (city) => controller.setOriginCity(city),
              );
            },
          ),
          const SizedBox(height: 30),
          const Text(
            'Tujuan :',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
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
            asyncItems: (_) async => await controller.getProvinces(),
            onChanged: (province) =>
                controller.setDestinationProvince(province),
          ),
          const SizedBox(height: 20),
          GetBuilder<HomeController>(
            builder: (_) {
              return DropdownSearch<City>(
                selectedItem: controller.destinationCity,
                enabled: controller.destinationProvince == null ? false : true,
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Kota/Kabupaten Tujuan",
                    border: OutlineInputBorder(),
                  ),
                ),
                popupProps: PopupProps.dialog(
                  fit: FlexFit.loose,
                  itemBuilder: (_, item, __) => ListTile(
                    title: Text("${item.type} ${item.cityName}"),
                  ),
                  showSearchBox: true,
                  searchFieldProps: const TextFieldProps(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Cari Kota',
                      isDense: true,
                    ),
                  ),
                  title: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                    child: const Text(
                      'Kota/Kabupaten Tujuan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                asyncItems: (_) async => await controller.getCities(),
                onChanged: (city) => controller.setDetsinationCity(city),
              );
            },
          ),
          const SizedBox(height: 30),
          TextField(
            controller: controller.weightC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Berat (gram)",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 30),
          DropdownSearch<Map<String, dynamic>>(
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Pilih Kurir",
                border: OutlineInputBorder(),
              ),
            ),
            items: controller.couriers,
            popupProps: PopupProps.menu(
              fit: FlexFit.loose,
              itemBuilder: (_, item, __) => ListTile(
                title: Text("${item["name"]}"),
              ),
            ),
            dropdownBuilder: (_, selectedItem) =>
                Text("${selectedItem?['name'] ?? "Pilih Kurir"}"),
            onChanged: (value) => controller.setCourierCode(value?['code']),
          ),
          const SizedBox(height: 40),
          Obx(
            () => ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 48),
              ),
              onPressed: controller.isLoading.isFalse
                  ? () => controller.cekOngkir()
                  : null,
              child: Text(
                controller.isLoading.isFalse
                    ? "CEK ONGKOS KIRIM"
                    : "Loading...",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
