class Service {
  String? id;
  String? name;
  String? description;
  String? type;
  int? price;
  List<String>? accessoriesId;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? v;
  bool? hasAccessory;
  List<String>? orderDetailId;

  Service({this.id, this.name, this.description, this.type, this.price, this.accessoriesId, this.deleted, this.createdAt, this.updatedAt, this.v, this.hasAccessory,this.orderDetailId});

  Service.fromJson(Map<String, dynamic> json) {
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
      accessoriesId = json["accessories_id"]==null ? null : List<String>.from(json["accessories_id"]);
    }
    if(json["orderdetail_id"] is List) {
      orderDetailId = json["orderdetail_id"]==null ? null : List<String>.from(json["orderdetail_id"]);
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
    data["_id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["type"] = type;
    data["price"] = price;
    if(accessoriesId != null) {
      data["accessories_id"] = accessoriesId;
    }
    if(orderDetailId != null) {
      data["orderdetail_id"] = orderDetailId;
    }
    data["deleted"] = deleted;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    data["hasAccessory"] = hasAccessory;
    return data;
  }
}