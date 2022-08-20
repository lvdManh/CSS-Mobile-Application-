
class ServiceToChoose {
  String? id;
  String? name;
  String? description;
  String? type;
  int? price;

  ServiceToChoose({this.id, this.name, this.description, this.type, this.price});

  ServiceToChoose.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["price"] is int) {
      price = json["price"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["type"] = type;
    data["price"] = price;
    return data;
  }
}