class Order {
  StaffId? staffId;
  OrderId? orderId;

  Order({this.staffId, this.orderId});

  Order.fromJson(Map<dynamic, dynamic> json) {
    staffId =
        json["staff_id"] == null ? null : StaffId.fromJson(json["staff_id"]);
    orderId =
        json["order_id"] == null ? null : OrderId.fromJson(json["order_id"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (staffId != null) data["staff_id"] = staffId?.toJson();
    if (orderId != null) data["order_id"] = orderId?.toJson();
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

  OrderId(
      {this.id,
      this.totalPrice,
      this.status,
      this.orderDetailsId,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.bookingId,
      this.workSlot});

  OrderId.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    totalPrice = json["totalPrice"];
    status = json["status"];
    orderDetailsId = json["orderDetails_id"] ?? [];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
    bookingId = json["booking_id"] == null
        ? null
        : BookingId.fromJson(json["booking_id"]);
    workSlot = json["work_slot"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["totalPrice"] = totalPrice;
    data["status"] = status;
    if (orderDetailsId != null) {
      data["orderDetails_id"] = orderDetailsId;
    }
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    if (bookingId != null) data["booking_id"] = bookingId?.toJson();
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
  AccId? accId;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? orderId;

  BookingId(
      {this.cusAddress,
      this.id,
      this.cusName,
      this.services,
      this.description,
      this.type,
      this.time,
      this.status,
      this.phonenum,
      this.accId,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.orderId});

  BookingId.fromJson(Map<String, dynamic> json) {
    cusAddress = json["cus_address"] == null
        ? null
        : CusAddress.fromJson(json["cus_address"]);
    id = json["_id"];
    cusName = json["cus_name"];
    services =
        json["services"] == null ? null : List<String>.from(json["services"]);
    description = json["description"];
    type = json["type"];
    time = json["time"];
    status = json["status"];
    phonenum = json["phonenum"];
    accId = json["acc_id"] == null ? null : AccId.fromJson(json["acc_id"]);
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
    orderId = json["order_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cusAddress != null) {
      data["cus_address"] = cusAddress?.toJson();
    }
    data["_id"] = id;
    data["cus_name"] = cusName;
    if (services != null) data["services"] = services;
    data["description"] = description;
    data["type"] = type;
    data["time"] = time;
    data["status"] = status;
    data["phonenum"] = phonenum;
    if (accId != null) data["acc_id"] = accId?.toJson();
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    data["order_id"] = orderId;
    return data;
  }
}

class AccId {
  String? id;
  UserId1? userId;

  AccId({this.id, this.userId});

  AccId.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    userId = json["user_id"] == null ? null : UserId1.fromJson(json["user_id"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    if (userId != null) data["user_id"] = userId?.toJson();
    return data;
  }
}

class UserId1 {
  String? id;
  String? name;

  UserId1({this.id, this.name});

  UserId1.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
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
    city = json["city"];
    district = json["district"];
    ward = json["ward"];
    street = json["street"];
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
    id = json["_id"];
    userId = json["user_id"] == null ? null : UserId.fromJson(json["user_id"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    if (userId != null) data["user_id"] = userId?.toJson();
    return data;
  }
}

class UserId {
  String? id;
  String? name;

  UserId({this.id, this.name});

  UserId.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    return data;
  }
}

// class Order {
//   int? totalPrice;
//   String? id;
//   String? status;
//   List<dynamic>? orderDetailsId;
//   String? workSlot;
//   String? createdAt;
//   String? updatedAt;
//   int? v;
//   BookingId? bookingId;

//   Order(
//       {this.totalPrice,
//       this.id,
//       this.status,
//       this.orderDetailsId,
//       this.workSlot,
//       this.createdAt,
//       this.updatedAt,
//       this.v,
//       this.bookingId});

//   Order.fromJson(Map<dynamic, dynamic> json) {
//     totalPrice = json["totalPrice"];
//     id = json["_id"];
//     status = json["status"];
//     orderDetailsId = json["orderDetails_id"] ?? [];
//     workSlot = json["work_slot"];
//     createdAt = json["createdAt"];
//     updatedAt = json["updatedAt"];
//     v = json["__v"];
//     bookingId = json["booking_id"] == null
//         ? null
//         : BookingId.fromJson(json["booking_id"]);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["totalPrice"] = totalPrice;
//     data["_id"] = id;
//     data["status"] = status;
//     if (orderDetailsId != null) {
//       data["orderDetails_id"] = orderDetailsId;
//     }
//     data["work_slot"] = workSlot;
//     data["createdAt"] = createdAt;
//     data["updatedAt"] = updatedAt;
//     data["__v"] = v;
//     if (bookingId != null) data["booking_id"] = bookingId?.toJson();
//     return data;
//   }
// }

// class BookingId {
//   CusAddress? cusAddress;
//   String? id;
//   String? cusName;
//   List<String>? services;
//   String? description;
//   String? type;
//   String? time;
//   String? status;
//   String? phonenum;
//   String? createdAt;
//   String? updatedAt;
//   int? v;
//   String? accId;
//   String? orderId;

//   BookingId(
//       {this.cusAddress,
//       this.id,
//       this.cusName,
//       this.services,
//       this.description,
//       this.type,
//       this.time,
//       this.status,
//       this.phonenum,
//       this.createdAt,
//       this.updatedAt,
//       this.v,
//       this.accId,
//       this.orderId});

//   BookingId.fromJson(Map<String, dynamic> json) {
//     cusAddress = json["cus_address"] == null
//         ? null
//         : CusAddress.fromJson(json["cus_address"]);
//     id = json["_id"];
//     cusName = json["cus_name"];
//     services =
//         json["services"] == null ? null : List<String>.from(json["services"]);
//     description = json["description"];
//     type = json["type"];
//     time = json["time"];
//     status = json["status"];
//     phonenum = json["phonenum"];
//     createdAt = json["createdAt"];
//     updatedAt = json["updatedAt"];
//     v = json["__v"];
//     accId = json["acc_id"];
//     orderId = json["order_id"];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (cusAddress != null) {
//       data["cus_address"] = cusAddress?.toJson();
//     }
//     data["_id"] = id;
//     data["cus_name"] = cusName;
//     if (services != null) data["services"] = services;
//     data["description"] = description;
//     data["type"] = type;
//     data["time"] = time;
//     data["status"] = status;
//     data["phonenum"] = phonenum;
//     data["createdAt"] = createdAt;
//     data["updatedAt"] = updatedAt;
//     data["__v"] = v;
//     data["acc_id"] = accId;
//     data["order_id"] = orderId;
//     return data;
//   }
// }

// class CusAddress {
//   String? city;
//   String? district;
//   String? ward;
//   String? street;

//   CusAddress({this.city, this.district, this.ward, this.street});

//   CusAddress.fromJson(Map<String, dynamic> json) {
//     city = json["city"];
//     district = json["district"];
//     ward = json["ward"];
//     street = json["street"];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["city"] = city;
//     data["district"] = district;
//     data["ward"] = ward;
//     data["street"] = street;
//     return data;
//   }
// }
