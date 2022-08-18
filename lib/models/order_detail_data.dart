
class OrderDetails {
  List<Datas>? datas;

  OrderDetails({this.datas});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    if(json["datas"] is List) {
      datas = json["datas"]==null ? null : (json["datas"] as List).map((e)=>Datas.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(datas != null) {
      data["datas"] = datas?.map((e)=>e.toJson()).toList();
    }
    return data;
  }
}

class Datas {
  bool? hasAccessory;
  int? discount;
  String? serviceId;
  List<Accessories>? accessories;

  Datas({this.hasAccessory, this.discount, this.serviceId, this.accessories});

  Datas.fromJson(Map<String, dynamic> json) {
    if(json["hasAccessory"] is bool) {
      hasAccessory = json["hasAccessory"];
    }
    if(json["discount"] is int) {
      discount = json["discount"];
    }
    if(json["serviceId"] is String) {
      serviceId = json["serviceId"];
    }
    if(json["accessories"] is List) {
      accessories = json["accessories"]==null ? null : (json["accessories"] as List).map((e)=>Accessories.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["hasAccessory"] = hasAccessory;
    data["discount"] = discount;
    data["serviceId"] = serviceId;
    if(accessories != null) {
      data["accessories"] = accessories?.map((e)=>e.toJson()).toList();
    }
    return data;
  }
}

class Accessories {
  String? accessoryId;
  int? amountAcc;

  Accessories({this.accessoryId, this.amountAcc});

  Accessories.fromJson(Map<String, dynamic> json) {
    if(json["accessory_id"] is String) {
      accessoryId = json["accessory_id"];
    }
    if(json["amount_acc"] is int) {
      amountAcc = json["amount_acc"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["accessory_id"] = accessoryId;
    data["amount_acc"] = amountAcc;
    return data;
  }
}