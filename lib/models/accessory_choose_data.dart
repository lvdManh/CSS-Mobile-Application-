
class AccessoryToChoose {
  String? id;
  String? name;
  String? description;
  String? type;
  int? price;
  bool? hasAccessory;
  List<SerHasAcc1>? serHasAcc;
  List<dynamic>? orderdetailId;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? brand;

  AccessoryToChoose({this.id, this.name, this.description, this.type, this.price, this.hasAccessory, this.serHasAcc, this.orderdetailId, this.deleted, this.createdAt, this.updatedAt, this.v, this.brand});

  AccessoryToChoose.fromJson(Map<String, dynamic> json) {
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
    if(json["hasAccessory"] is bool) {
      hasAccessory = json["hasAccessory"];
    }
    if(json["serHasAcc"] is List) {
      serHasAcc = json["serHasAcc"]==null ? null : (json["serHasAcc"] as List).map((e)=>SerHasAcc1.fromJson(e)).toList();
    }
    if(json["orderdetail_id"] is List) {
      orderdetailId = json["orderdetail_id"] ?? [];
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
    if(json["brand"] is String) {
      brand = json["brand"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["type"] = type;
    data["price"] = price;
    data["hasAccessory"] = hasAccessory;
    if(serHasAcc != null) {
      data["serHasAcc"] = serHasAcc?.map((e)=>e.toJson()).toList();
    }
    if(orderdetailId != null) {
      data["orderdetail_id"] = orderdetailId;
    }
    data["deleted"] = deleted;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    data["brand"] = brand;
    return data;
  }
}

class SerHasAcc1 {
  String? id;
  AccessoryId? accessoryId;

  SerHasAcc1({this.id, this.accessoryId});

  SerHasAcc1.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["accessory_id"] is Map) {
      accessoryId = json["accessory_id"] == null ? null : AccessoryId.fromJson(json["accessory_id"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    if(accessoryId != null) {
      data["accessory_id"] = accessoryId?.toJson();
    }
    return data;
  }
}

class AccessoryId {
  String? id;
  String? name;
  String? type;
  String? description;
  String? insurance;
  SupplierId? supplierId;
  int? price;

  AccessoryId({this.id, this.name, this.type, this.description, this.insurance, this.supplierId, this.price});

  AccessoryId.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["type"] is String) {
      type = json["type"];
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
    if(json["price"] is int) {
      price = json["price"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["type"] = type;
    data["description"] = description;
    data["insurance"] = insurance;
    if(supplierId != null) {
      data["supplier_id"] = supplierId?.toJson();
    }
    data["price"] = price;
    return data;
  }
}

class SupplierId {
  String? id;
  String? name;

  SupplierId({this.id, this.name});

  SupplierId.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    return data;
  }
}