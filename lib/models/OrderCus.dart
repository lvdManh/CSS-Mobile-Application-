
import 'order_data.dart';

class OrderCus {
  String? id;
  int? totalPrice;
  String? status;
  List<String>? imgComUrls;
  String? createdAt;
  String? updatedAt;
  int? v;
  BookingId? bookingId;
  Computer? computerId;
  WorkSlot? workSlot;
  List<OrderDetailsId>? orderDetailsId;

  OrderCus({this.id, this.totalPrice, this.status, this.imgComUrls, this.createdAt, this.updatedAt, this.v, this.bookingId, this.workSlot, this.orderDetailsId,this.computerId});

  OrderCus.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["totalPrice"] is int) {
      totalPrice = json["totalPrice"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["imgComUrls"] is List) {
      imgComUrls = json["imgComUrls"]==null ? null : List<String>.from(json["imgComUrls"]);
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
    if(json["booking_id"] is Map) {
      bookingId = json["booking_id"] == null ? null : BookingId.fromJson(json["booking_id"]);
    }
    if(json["work_slot"] is Map) {
      workSlot = json["work_slot"] == null ? null : WorkSlot.fromJson(json["work_slot"]);
    }
    if(json["orderDetails_id"] is List) {
      orderDetailsId = json["orderDetails_id"]==null ? null : (json["orderDetails_id"] as List).map((e)=>OrderDetailsId.fromJson(e)).toList();
    }
    if(json["computer_id"] is Map) {
      computerId = json["computer_id"] == null ? null : Computer.fromJson(json["computer_id"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["totalPrice"] = totalPrice;
    data["status"] = status;
    if(imgComUrls != null) {
      data["imgComUrls"] = imgComUrls;
    }
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    if(bookingId != null) {
      data["booking_id"] = bookingId?.toJson();
    }
    if(workSlot != null) {
      data["work_slot"] = workSlot?.toJson();
    }
    if(orderDetailsId != null) {
      data["orderDetails_id"] = orderDetailsId?.map((e)=>e.toJson()).toList();
    }
    return data;
  }
}

class OrderDetailsId {
  String? id;
  int? discount;
  int? amountSer;
  AccessoryId? accessoryId;
  ServiceId? serviceId;
  int? amountAcc;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? orderId;
  int? priceAfter;

  OrderDetailsId({this.id, this.discount, this.amountSer, this.accessoryId, this.serviceId,this.amountAcc, this.createdAt, this.updatedAt, this.v, this.orderId, this.priceAfter});

  OrderDetailsId.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["discount"] is int) {
      discount = json["discount"];
    }
    if(json["amount_ser"] is int) {
      amountSer = json["amount_ser"];
    }
    if(json["accessory_id"] is Map) {
      accessoryId = json["accessory_id"] == null ? null : AccessoryId.fromJson(json["accessory_id"]);
    }
    if(json["service_id"] is Map) {
      serviceId = json["service_id"] == null ? null : ServiceId.fromJson(json["service_id"]);
    }
    if(json["amount_acc"] is int) {
      amountAcc = json["amount_acc"];
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
    if(json["order_id"] is String) {
      orderId = json["order_id"];
    }
    if(json["price_after"] is int) {
      priceAfter = json["price_after"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["discount"] = discount;
    data["amount_ser"] = amountSer;
    if(accessoryId != null) {
      data["accessory_id"] = accessoryId?.toJson();
    }
    if(serviceId != null) {
      data["service_id"] = serviceId?.toJson();
    }
    data["amount_acc"] = amountAcc;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    data["order_id"] = orderId;
    data["price_after"] = priceAfter;
    return data;
  }
}

class AccessoryId {
  String? id;
  String? name;
  int? price;
  String? imgUrl;

  AccessoryId({this.id, this.name, this.price, this.imgUrl});

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
    if(json["imgURL"] is String) {
      imgUrl = json["imgURL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["imgURL"] = imgUrl;
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
class WorkSlot {
  String? id;
  StaffId? staffId;

  WorkSlot({this.id, this.staffId});

  WorkSlot.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["staff_id"] is Map) {
      staffId = json["staff_id"] == null ? null : StaffId.fromJson(json["staff_id"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    if(staffId != null) {
      data["staff_id"] = staffId?.toJson();
    }
    return data;
  }
}

class StaffId {
  String? id;
  UserId? userId;

  StaffId({this.id, this.userId});

  StaffId.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["user_id"] is Map) {
      userId = json["user_id"] == null ? null : UserId.fromJson(json["user_id"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    if(userId != null) {
      data["user_id"] = userId?.toJson();
    }
    return data;
  }
}

class UserId {
  String? id;
  String? name;
  String? phoneNum;
  UserId({this.id, this.name, this.phoneNum});

  UserId.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["phonenum"] is String) {
      phoneNum = json["phonenum"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["phonenum"] = phoneNum;
    return data;
  }
}

class BookingId {
  String? id;
  String? accId;

  BookingId({this.id, this.accId});

  BookingId.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["acc_id"] is String) {
      accId = json["acc_id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["acc_id"] = accId;
    return data;
  }
}
