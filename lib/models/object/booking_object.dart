
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
  String? updatedAt;
  String? cusId;
  String? createdAt;
  int? v;
  String? accId;

  Booking({this.cusAddress, this.id, this.cusName, this.services, this.description, this.type, this.time, this.status, this.phonenum, this.updatedAt, this.cusId, this.createdAt, this.v, this.accId});

  Booking.fromJson(Map<dynamic, dynamic> json) {
    cusAddress = json["cus_address"] == null ? null : CusAddress.fromJson(json["cus_address"]);
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
    accId = json["acc_id"];
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
    data["acc_id"] = accId;
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