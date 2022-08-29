class Ongkir {
  String? service;
  String? description;
  List<Cost>? cost;

  Ongkir({this.service, this.description, this.cost});

  Ongkir.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    description = json['description'];
    if (json['cost'] != null) {
      cost = <Cost>[];
      json['cost'].forEach((v) {
        cost?.add(Cost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['service'] = service;
    data['description'] = description;
    if (cost != null) {
      data['cost'] = cost?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<Ongkir> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((item) => Ongkir.fromJson(item)).toList();
  }
}

class Cost {
  int? value;
  String? etd;
  String? note;

  Cost({this.value, this.etd, this.note});

  Cost.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    etd = json['etd'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['etd'] = etd;
    data['note'] = note;
    return data;
  }
}
