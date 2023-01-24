# Cek Ongkir
Aplikasi cek ongkir. Project ini dibangun dengan Flutter + Getx + RajaOngkir Api + Dio HTTP.

![Thumbnail](https://github.com/triagung128/cek-ongkir/blob/main/assets/screenshots/banner.png)

## Feature Apps
- Menghitung ongkos kirim seluruh Indonesia
- Menampilkan semua data provinsi di Indonesia
- Menampilkan semua kota berdasarkan provinsi yang dipilih
- Menampilkan paket ongkos kirim
- Jasa ekspedisi : JNE, TIKI, POS Indonesia

## State Management
- GetX

## Resource API
- <a href="https://rajaongkir.com/">RajaOngkir Api</a>

## Network Dependency
- Dio HTTP

## Setup
1. Membuat API KEY RajaOngkir di website <a href="https://rajaongkir.com/dokumentasi">Dokumentasi API RajaOngkir</a>
2. Masukkan API KEY yang sudah dibuat di dalam file ***lib/app/data/services/api_services.dart***
```dart
class ApiService {
  // insert with your RajaOngkir API KEY
  final _apiKey = "<YOUR RAJAONGKIR API KEY>";
}
```
