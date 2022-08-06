class Address {
  Address({
    required this.name,
    required this.wards,
  });
  late final String name;
  late final List<Wards> wards;

  Address.fromJson(Map<String, dynamic> json){
    name = json['name'];
    wards = List.from(json['wards']).map((e)=>Wards.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['wards'] = wards.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Wards {
  Wards({
    required this.name,
  });
  late final String name;

  Wards.fromJson(Map<String, dynamic> json){
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}