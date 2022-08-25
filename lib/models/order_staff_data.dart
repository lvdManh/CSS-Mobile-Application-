

class OrderStaff {
  StaffId? staffId;
  OrderId? orderId;

  OrderStaff({this.staffId, this.orderId});

  OrderStaff.fromJson(Map<String, dynamic> json) {
    if(json["staff_id"] is Map) {
      staffId = json["staff_id"] == null ? null : StaffId.fromJson(json["staff_id"]);
    }
    if(json["order_id"] is Map) {
      orderId = json["order_id"] == null ? null : OrderId.fromJson(json["order_id"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(staffId != null) {
      data["staff_id"] = staffId?.toJson();
    }
    if(orderId != null) {
      data["order_id"] = orderId?.toJson();
    }
    return data;
  }
}

class OrderId {
  String? id;
  int? totalPrice;
  String? status;
  List<dynamic>? orderDetailsId;
  String? createdAt;
  String? updatedAt;
  int? v;
  BookingId? bookingId;
  String? workSlot;
  String? computerId;
  OrderId({this.id, this.totalPrice, this.status, this.orderDetailsId, this.createdAt, this.updatedAt, this.v, this.bookingId, this.workSlot, this.computerId});

  OrderId.fromJson(Map<String, dynamic> json) {
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
      orderDetailsId = json["orderDetails_id"] ?? [];
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
    if(json["work_slot"] is String) {
      workSlot = json["work_slot"];
    }
    if(json["computer_id"] is String) {
      computerId = json["computer_id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["totalPrice"] = totalPrice;
    data["status"] = status;
    if(orderDetailsId != null) {
      data["orderDetails_id"] = orderDetailsId;
    }
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    if(bookingId != null) {
      data["booking_id"] = bookingId?.toJson();
    }
    data["work_slot"] = workSlot;
    return data;
  }
}

class BookingId {
  CusAddress? cusAddress;
  String? id;
  String? cusName;
  List<String>? services;
  String? description;
  String? type;
  String? time;
  String? status;
  String? phonenum;
  String? createdAt;
  String? updatedAt;
  int? v;
  AccId? accId;
  String? orderId;

  BookingId({this.cusAddress, this.id, this.cusName, this.services, this.description, this.type, this.time, this.status, this.phonenum, this.createdAt, this.updatedAt, this.v, this.accId, this.orderId});

  BookingId.fromJson(Map<String, dynamic> json) {
    if(json["cus_address"] is Map) {
      cusAddress = json["cus_address"] == null ? null : CusAddress.fromJson(json["cus_address"]);
    }
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["cus_name"] is String) {
      cusName = json["cus_name"];
    }
    if(json["services"] is List) {
      services = json["services"]==null ? null : List<String>.from(json["services"]);
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["time"] is String) {
      time = json["time"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["phonenum"] is String) {
      phonenum = json["phonenum"];
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
    if(json["acc_id"] is Map) {
      accId = json["acc_id"] == null ? null : AccId.fromJson(json["acc_id"]);
    }
    if(json["order_id"] is String) {
      orderId = json["order_id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(cusAddress != null) {
      data["cus_address"] = cusAddress?.toJson();
    }
    data["_id"] = id;
    data["cus_name"] = cusName;
    if(services != null) {
      data["services"] = services;
    }
    data["description"] = description;
    data["type"] = type;
    data["time"] = time;
    data["status"] = status;
    data["phonenum"] = phonenum;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    if(accId != null) {
      data["acc_id"] = accId?.toJson();
    }
    data["order_id"] = orderId;
    return data;
  }
}

class AccId {
  String? id;
  UserId1? userId;

  AccId({this.id, this.userId});

  AccId.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["user_id"] is Map) {
      userId = json["user_id"] == null ? null : UserId1.fromJson(json["user_id"]);
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

class UserId1 {
  String? id;
  String? name;

  UserId1({this.id, this.name});

  UserId1.fromJson(Map<String, dynamic> json) {
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

class CusAddress {
  String? city;
  String? district;
  String? ward;
  String? street;

  CusAddress({this.city, this.district, this.ward, this.street});

  CusAddress.fromJson(Map<String, dynamic> json) {
    if(json["city"] is String) {
      city = json["city"];
    }
    if(json["district"] is String) {
      district = json["district"];
    }
    if(json["ward"] is String) {
      ward = json["ward"];
    }
    if(json["street"] is String) {
      street = json["street"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["city"] = city;
    data["district"] = district;
    data["ward"] = ward;
    data["street"] = street;
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

  UserId({this.id, this.name});

  UserId.fromJson(Map<String, dynamic> json) {
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