
class Accessory {
  String? id;
  String? name;
  String? description;
  String? insurance;
  SupplierId? supplierId;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? serviceId;
  int? price;
  List<String>? serHasAcc;

  Accessory({this.id, this.name, this.description, this.insurance, this.supplierId, this.deleted, this.createdAt, this.updatedAt, this.v, this.serviceId, this.price, this.serHasAcc});

  Accessory.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["insurance"] is String) {
      insurance = json["insurance"];
    }
    if(json["supplier_id"] is Map) {
      supplierId = json["supplier_id"] == null ? null : SupplierId.fromJson(json["supplier_id"]);
    }
    if(json["deleted"] is bool) {
      deleted = json["deleted"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if(json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if(json["__v"] is int) {
      v = json["__v"];
    }
    if(json["service_id"] is String) {
      serviceId = json["service_id"];
    }
    if(json["price"] is int) {
      price = json["price"];
    }
    if(json["serHasAcc"] is List) {
      serHasAcc = json["serHasAcc"]==null ? null : List<String>.from(json["serHasAcc"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["insurance"] = insurance;
    if(supplierId != null) {
      data["supplier_id"] = supplierId?.toJson();
    }
    data["deleted"] = deleted;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    data["service_id"] = serviceId;
    data["price"] = price;
    if(serHasAcc != null) {
      data["serHasAcc"] = serHasAcc;
    }
    return data;
  }
}

class SupplierId {
  String? id;
  String? name;
  String? address;
  String? phonenum;
  List<String>? accessoriesId;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? v;

  SupplierId({this.id, this.name, this.address, this.phonenum, this.accessoriesId, this.deleted, this.createdAt, this.updatedAt, this.v});

  SupplierId.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["address"] is String) {
      address = json["address"];
    }
    if(json["phonenum"] is String) {
      phonenum = json["phonenum"];
    }
    if(json["accessories_id"] is List) {
      accessoriesId = json["accessories_id"]==null ? null : List<String>.from(json["accessories_id"]);
    }
    if(json["deleted"] is bool) {
      deleted = json["deleted"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if(json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if(json["__v"] is int) {
      v = json["__v"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["address"] = address;
    data["phonenum"] = phonenum;
    if(accessoriesId != null) {
      data["accessories_id"] = accessoriesId;
    }
    data["deleted"] = deleted;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    return data;
  }
}