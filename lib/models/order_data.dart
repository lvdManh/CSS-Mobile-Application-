

class Order {
  String? id;
  int? totalPrice;
  String? status;
  List<OrderDetailId>? orderDetailsId;
  String? createdAt;
  String? updatedAt;
  int? v;
  BookingId? bookingId;

  Order({this.id, this.totalPrice, this.status, this.orderDetailsId, this.createdAt, this.updatedAt, this.v, this.bookingId});

  Order.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["totalPrice"] is int) {
      totalPrice = json["totalPrice"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["orderDetails_id"] is List) {
      orderDetailsId = json["orderDetails_id"] == null ? null : (json["orderDetails_id"] as List).map((e)=>OrderDetailId.fromJson(e)).toList();
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["totalPrice"] = totalPrice;
    data["status"] = status;
    if(orderDetailsId != null) {
      data["orderDetails_id"] = orderDetailsId?.map((e)=>e.toJson()).toList();
    }
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    if(bookingId != null) {
      data["booking_id"] = bookingId?.toJson();
    }
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

class OrderDetailId {
  int? amountSer;
  int? amountAcc;
  int? discount;
  int? priceAfter;
  ServiceId? serviceId;
  ServiceId? accessoriesId;


  OrderDetailId({this.amountSer, this.amountAcc, this.discount, this.priceAfter, this.serviceId, this.accessoriesId});

  OrderDetailId.fromJson(Map<String, dynamic> json) {
    if(json["amount_ser"] is int) {
      amountSer = json["amount_ser"];
    }
    if(json["amount_acc"] is int) {
      amountAcc = json["amount_acc"];
    }
    if(json["discount"] is int) {
      discount = json["discount"];
    }
    if(json["price_after"] is int) {
      priceAfter = json["price_after"];
    }
    if(json["service_id"] is Map) {
      serviceId = json["service_id"] == null ? null : ServiceId.fromJson(json["service_id"]);
    }
    if(json["accessory_id"] is Map) {
      accessoriesId = json["accessory_id"] == null ? null : ServiceId.fromJson(json["accessory_id"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["amount_ser"] = amountSer;
    data["amount_acc"] = amountAcc;
    data["discount"] = discount;
    data["price_after"] = priceAfter;
    if(serviceId != null) {
      data["service_id"] = serviceId?.toJson();
    }
    if(accessoriesId != null) {
      data["accessory_id"] = accessoriesId?.toJson();
    }
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



