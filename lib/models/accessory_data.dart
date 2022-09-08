
class AccessoryMix {
  int? count;
  List<Accessories>? accessories;

  AccessoryMix({this.count, this.accessories});

  AccessoryMix.fromJson(Map<String, dynamic> json) {
    if(json["count"] is int) {
      count = json["count"];
    }
    if(json["sortedAcc"] is List) {
      accessories = json["sortedAcc"]==null ? null : (json["sortedAcc"] as List).map((e)=>Accessories.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["count"] = count;
    if(accessories != null) {
      data["accessories"] = accessories?.map((e)=>e.toJson()).toList();
    }
    return data;
  }
}

class Accessories {
  String? id;
  String? name;
  int? price;
  String? type;
  String? component;
  String? description;
  String? insurance;
  String? supplierId;
  List<String>? orderdetailId;
  List<String>? serHasAcc;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? imgUrl;

  Accessories({this.id, this.name, this.price, this.type, this.component, this.description, this.insurance, this.supplierId, this.orderdetailId, this.serHasAcc, this.deleted, this.createdAt, this.updatedAt, this.v, this.imgUrl});

  Accessories.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["price"] is int) {
      price = json["price"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["component"] is String) {
      component = json["component"];
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
    if(json["orderdetail_id"] is List) {
      orderdetailId = json["orderdetail_id"]==null ? null : List<String>.from(json["orderdetail_id"]);
    }
    if(json["serHasAcc"] is List) {
      serHasAcc = json["serHasAcc"]==null ? null : List<String>.from(json["serHasAcc"]);
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
    if(json["imgURL"] is String) {
      imgUrl = json["imgURL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["type"] = type;
    data["component"] = component;
    data["description"] = description;
    data["insurance"] = insurance;
    data["supplier_id"] = supplierId;
    if(orderdetailId != null) {
      data["orderdetail_id"] = orderdetailId;
    }
    if(serHasAcc != null) {
      data["serHasAcc"] = serHasAcc;
    }
    data["deleted"] = deleted;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    data["imgURL"] = imgUrl;
    return data;
  }
}