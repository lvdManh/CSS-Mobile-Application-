
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
  int? discount;
  String? serviceId;
  String? accessoryId;
  int? amountSer;
  int? amountAcc;

  Datas({this.discount, this.serviceId, this.amountAcc, this.accessoryId, this.amountSer});

  Datas.fromJson(Map<String, dynamic> json) {
    if(json["discount"] is int) {
      discount = json["discount"];
    }
    if(json["service_id"] is String) {
      serviceId = json["service_id"];
    }
    if(json["accessory_id"] is String) {
      accessoryId = json["accessory_id"];
    }
    if(json["amount_ser"] is int) {
      amountSer = json["amount_ser"];
    }
    if(json["amount_acc"] is int) {
      amountAcc = json["amount_acc"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(discount != null){
      data["discount"] = discount;
    }
    if(serviceId != null) {
      data["service_id"] = serviceId;
    }
    if(accessoryId != null) {
      data["accessory_id"] = accessoryId;
    }
    if(amountSer != null) {
      data["amount_ser"] = amountSer;
    }
    if(amountAcc != null) {
      data["amount_acc"] = amountAcc;
    }
    return data;
  }
}
