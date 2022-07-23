
class Bookings {
  CusAddress? cusAddress;
  String? id;
  String? cusName;
  List<String>? services;
  String? description;
  String? type;
  String? time;
  String? status;
  String? phonenum;
  String? updatedAt;
  String? cusId;
  String? createdAt;
  int? v;
  AccId? accId;

  Bookings({this.cusAddress, this.id, this.cusName, this.services, this.description, this.type, this.time, this.status, this.phonenum, this.updatedAt, this.cusId, this.createdAt, this.v, this.accId});

  Bookings.fromJson(Map<dynamic, dynamic> json) {
    cusAddress = json["cus_address"] == null ? null : CusAddress.fromJson(Map<String,dynamic>.from(json["cus_address"]));
    id = json["_id"];
    cusName = json["cus_name"];
    services = json["services"]==null ? null : List<String>.from(json["services"]);
    description = json["description"];
    type = json["type"];
    time = json["time"];
    status = json["status"];
    phonenum = json["phonenum"];
    updatedAt = json["updatedAt"];
    cusId = json["cus_id"];
    createdAt = json["createdAt"];
    v = json["__v"];
    accId = json["acc_id"]== null ? null : AccId.fromJson(Map<String,dynamic>.from(json["acc_id"]));

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
    data["updatedAt"] = updatedAt;
    data["cus_id"] = cusId;
    data["createdAt"] = createdAt;
    data["__v"] = v;
    //data["acc_id"] = accId;
    if(accId != null) {
      data["acc_id"] = accId?.toJson();
    }
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
class AccId {
  String? accountId;
  String? username;

  AccId({this.accountId, this.username});

  AccId.fromJson(Map<String, dynamic> json) {
    accountId = json["_id"];
    username = json["username"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = accountId;
    data["username"] = username;

    return data;
  }
}