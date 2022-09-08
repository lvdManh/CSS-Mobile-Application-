
import 'order_data.dart';

class OrderInfo {
  int? totalPrice;
  String? id;
  String? status;
  String? workSlot;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? bookingId;
  List<OrderDetailsId>? orderDetailsId;
  Computer? computerId;
  List<String>? imgComUrls;
  OrderInfo({this.totalPrice, this.id, this.status, this.workSlot, this.createdAt, this.updatedAt, this.v, this.bookingId, this.orderDetailsId, this.computerId, this.imgComUrls});
  bool checkNullValue() {
    return [computerId].contains(null);
  }
  OrderInfo.fromJson(Map<String, dynamic> json) {
    if(json["totalPrice"] is int) {
      totalPrice = json["totalPrice"];
    }
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["work_slot"] is String) {
      workSlot = json["work_slot"];
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
    if(json["booking_id"] is String) {
      bookingId = json["booking_id"];
    }
    if(json["orderDetails_id"] is List) {
      orderDetailsId = json["orderDetails_id"]==null ? null : (json["orderDetails_id"] as List).map((e)=>OrderDetailsId.fromJson(e)).toList();
    }
    if(json["computer_id"] is Map) {
      computerId = json["computer_id"] == null ? null : Computer.fromJson(json["computer_id"]);
    }
    if(json["imgComUrls"] is List) {
      imgComUrls = json["imgComUrls"] ==null ? null : List<String>.from(json["imgComUrls"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["totalPrice"] = totalPrice;
    data["_id"] = id;
    data["status"] = status;
    data["work_slot"] = workSlot;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    data["booking_id"] = bookingId;
    if(orderDetailsId != null) {
      data["orderDetails_id"] = orderDetailsId?.map((e)=>e.toJson()).toList();
    }
    return data;
  }
}


class OrderDetailsId {
  int? amountAcc;
  String? id;
  int? amountSer;
  int? discount;
  ServiceId? serviceId;
  AccessoryId? accessoryId;
  int? priceAfter;

  OrderDetailsId({this.amountAcc, this.id, this.amountSer, this.discount, this.serviceId, this.priceAfter, this.accessoryId});

  OrderDetailsId.fromJson(Map<String, dynamic> json) {
    if(json["amount_acc"] is int) {
      amountAcc = json["amount_acc"];
    }
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["amount_ser"] is int) {
      amountSer = json["amount_ser"];
    }
    if(json["discount"] is int) {
      discount = json["discount"];
    }
    if(json["service_id"] is Map) {
      serviceId = json["service_id"] == null ? null : ServiceId.fromJson(json["service_id"]);
    }
    if(json["accessory_id"] is Map) {
      accessoryId = json["accessory_id"] == null ? null : AccessoryId.fromJson(json["accessory_id"]);
    }
    if(json["price_after"] is int) {
      priceAfter = json["price_after"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["amount_acc"] = amountAcc;
    data["_id"] = id;
    data["amount_ser"] = amountSer;
    data["discount"] = discount;
    if(serviceId != null) {
      data["service_id"] = serviceId?.toJson();
    }
    if(serviceId != null) {
      data["accessory_id"] = accessoryId?.toJson();
    }
    data["price_after"] = priceAfter;
    return data;
  }
}

class ServiceId {
  String? id;
  String? name;
  int? price;

  ServiceId({this.id, this.name, this.price});

  ServiceId.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["price"] is int) {
      price = json["price"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["price"] = price;
    return data;
  }
}

class AccessoryId {
  String? id;
  String? name;
  int? price;

  AccessoryId({this.id, this.name, this.price});

  AccessoryId.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["price"] is int) {
      price = json["price"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["price"] = price;
    return data;
  }
}