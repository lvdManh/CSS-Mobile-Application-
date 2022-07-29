
class Address {
  String? name;
  List<Wards>? wards;

  Address({this.name, this.wards});

  Address.fromJson(Map<dynamic, dynamic> json) {
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["wards"] is List) {
      wards = json["wards"]==null ? null : (json["wards"] as List).map((e)=>Wards.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    if(wards != null) {
      data["wards"] = wards?.map((e)=>e.toJson()).toList();
    }
    return data;
  }
}

class Wards {
  String? name;

  Wards({this.name});

  Wards.fromJson(Map<dynamic, dynamic> json) {
    if(json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    return data;
  }
}