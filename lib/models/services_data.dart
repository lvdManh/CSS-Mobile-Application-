
class Service {
  List<dynamic>? orderdetailId;
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
  bool? hasAccessory;

  Service({this.orderdetailId, this.id, this.name, this.description, this.type, this.price, this.accessoriesId, this.deleted, this.createdAt, this.updatedAt, this.v, this.hasAccessory});

  Service.fromJson(Map<String, dynamic> json) {
    if(json["orderdetail_id"] is List) {
      orderdetailId = json["orderdetail_id"] ?? [];
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
    if(json["hasAccessory"] is bool) {
      hasAccessory = json["hasAccessory"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(orderdetailId != null) {
      data["orderdetail_id"] = orderdetailId;
    }
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
    data["hasAccessory"] = hasAccessory;
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
  List<String>? orderdetailId;

  AccessoriesId({this.id, this.name, this.description, this.insurance, this.supplierId, this.deleted, this.createdAt, this.updatedAt, this.v, this.serviceId, this.price, this.orderdetailId});

  AccessoriesId.fromJson(Map<String, dynamic> json) {
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
    if(json["orderdetail_id"] is List) {
      orderdetailId = json["orderdetail_id"]==null ? null : List<String>.from(json["orderdetail_id"]);
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
    if(orderdetailId != null) {
      data["orderdetail_id"] = orderdetailId;
    }
    return data;
  }
}