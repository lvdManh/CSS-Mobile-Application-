
class Booking {
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
  String? accId;
  String? orderId;

  Booking({this.cusAddress, this.id, this.cusName, this.services, this.description, this.type, this.time, this.status, this.phonenum, this.createdAt, this.updatedAt, this.v, this.accId, this.orderId});

  Booking.fromJson(Map<String, dynamic> json) {
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
    if(json["acc_id"] is String) {
      accId = json["acc_id"];
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
    data["acc_id"] = accId;
    data["order_id"] = orderId;
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