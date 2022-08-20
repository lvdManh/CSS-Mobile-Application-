class ServiceAccessoryList{
   ServiceAccessory? serviceAccessory;
   ServiceAccessoryList({this.serviceAccessory});
}
class ServiceAccessory {
  String? id;
  String? name;
  String? type;
  int? price;
  bool? hasAccessory;
  List<SerHasAcc>? serHasAcc;

  ServiceAccessory({this.id, this.name, this.type, this.price, this.hasAccessory, this.serHasAcc});

  ServiceAccessory.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
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
      serHasAcc = json["serHasAcc"]==null ? null : (json["serHasAcc"] as List).map((e)=>SerHasAcc.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["type"] = type;
    data["price"] = price;
    data["hasAccessory"] = hasAccessory;
    if(serHasAcc != null) {
      data["serHasAcc"] = serHasAcc?.map((e)=>e.toJson()).toList();
    }
    return data;
  }
}

class SerHasAcc {
  String? id;
  int? amount;
  AccessoryIdL? accessoryId;

  SerHasAcc({this.id, this.amount, this.accessoryId});

  SerHasAcc.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["amount"] is int) {
      amount = json["amount"];
    }
    if(json["accessory_id"] is Map) {
      accessoryId = json["accessory_id"] == null ? null : AccessoryIdL.fromJson(json["accessory_id"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["amount"] = amount;
    if(accessoryId != null) {
      data["accessory_id"] = accessoryId?.toJson();
    }
    return data;
  }
}

class AccessoryIdL {
  String? id;
  String? name;
  int? price;
  String? insurance;
  SupplierId? supplierId;

  AccessoryIdL({this.id, this.name, this.price, this.insurance, this.supplierId});

  AccessoryIdL.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["price"] is int) {
      price = json["price"];
    }
    if(json["insurance"] is String) {
      insurance = json["insurance"];
    }
    if(json["supplier_id"] is Map) {
      supplierId = json["supplier_id"] == null ? null : SupplierId.fromJson(json["supplier_id"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["insurance"] = insurance;
    if(supplierId != null) {
      data["supplier_id"] = supplierId?.toJson();
    }
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