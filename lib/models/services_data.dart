class Service {
  bool? hasAccessory;
  String? id;
  String? name;
  String? description;
  String? type;
  int? price;
  List<AccessoriesId>? accessoriesId;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? v;

  Service({this.hasAccessory, this.id, this.name, this.description, this.type, this.price, this.accessoriesId, this.deleted, this.createdAt, this.updatedAt, this.v});

  Service.fromJson(Map<dynamic, dynamic> json) {
    if(json["hasAccessory"] is bool) {
      hasAccessory = json["hasAccessory"];
    }
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
    if(json["accessories_id"] is List) {
      accessoriesId = json["accessories_id"]==null ? null : (json["accessories_id"] as List).map((e)=>AccessoriesId.fromJson(e)).toList();
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
    data["hasAccessory"] = hasAccessory;
    data["_id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["type"] = type;
    data["price"] = price;
    if(accessoriesId != null) {
      data["accessories_id"] = accessoriesId?.map((e)=>e.toJson()).toList();
    }
    data["deleted"] = deleted;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    return data;
  }
}

class AccessoriesId {
  String? id;
  String? name;
  String? description;
  String? insurance;
  String? supplierId;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? serviceId;
  int? price;

  AccessoriesId({this.id, this.name, this.description, this.insurance, this.supplierId, this.deleted, this.createdAt, this.updatedAt, this.v, this.serviceId, this.price});

  AccessoriesId.fromJson(Map<dynamic, dynamic> json) {
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
    if(json["supplier_id"] is String) {
      supplierId = json["supplier_id"];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["insurance"] = insurance;
    data["supplier_id"] = supplierId;
    data["deleted"] = deleted;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    data["service_id"] = serviceId;
    data["price"] = price;
    return data;
  }
}