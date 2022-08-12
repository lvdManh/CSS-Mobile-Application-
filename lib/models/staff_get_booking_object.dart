// ignore_for_file: camel_case_types

import 'dart:convert';

appointment appointmentFromJson(String str) =>
    appointment.fromJson(json.decode(str));

String appointmentToJson(appointment data) => json.encode(data.toJson());

class appointment {
  int? count;
  List<Booking>? bookings;

  appointment({this.count, this.bookings});

  appointment.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['bookings'] != null) {
      bookings = <Booking>[];
      json['bookings'].forEach((v) {
        bookings!.add(Booking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (bookings != null) {
      data['bookings'] = bookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Booking {
  CusAddress? cusAddress;
  String? sId;
  String? cusName;
  List<String>? services;
  String? description;
  String? type;
  String? time;
  String? status;
  String? phonenum;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? accId;

  Booking(
      {this.cusAddress,
      this.sId,
      this.cusName,
      this.services,
      this.description,
      this.type,
      this.time,
      this.status,
      this.phonenum,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.accId});

  Booking.fromJson(Map<String, dynamic> json) {
    cusAddress = json['cus_address'] != null
        ? CusAddress.fromJson(json['cus_address'])
        : null;
    sId = json['_id'];
    cusName = json['cus_name'];
    services = json['services'].cast<String>();
    description = json['description'];
    type = json['type'];
    time = json['time'];
    status = json['status'];
    phonenum = json['phonenum'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    accId = json['acc_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cusAddress != null) {
      data['cus_address'] = cusAddress!.toJson();
    }
    data['_id'] = sId;
    data['cus_name'] = cusName;
    data['services'] = services;
    data['description'] = description;
    data['type'] = type;
    data['time'] = time;
    data['status'] = status;
    data['phonenum'] = phonenum;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['acc_id'] = accId;
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
    city = json['city'];
    district = json['district'];
    ward = json['ward'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['district'] = district;
    data['ward'] = ward;
    data['street'] = street;
    return data;
  }
}


// class appointment {
//   int? count;
//   List<Booking>? bookings;
//   appointment({this.count, this.bookings});
//   appointment.fromJson(Map<String, dynamic> json) {
//     count = json['count'];
//     if (json['bookings'] != null) {
//       bookings = <Booking>[];
//       json['bookings'].forEach((v) {
//         bookings!.add(new Booking.fromJson(v));
//       });
//     }
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['count'] = this.count;
//     if (this.bookings != null) {
//       data['bookings'] = this.bookings!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Booking {
//   CusAddress? cusAddress;
//   String? id;
//   String? cusName;
//   List<dynamic>? services;
//   String? description;
//   String? type;
//   String? time;
//   String? status;
//   String? phonenum;
//   String? updatedAt;
//   String? cusId;
//   String? createdAt;
//   int? v;
//   String? accId;

//   Booking(
//       {this.cusAddress,
//       this.id,
//       this.cusName,
//       this.services,
//       this.description,
//       this.type,
//       this.time,
//       this.status,
//       this.phonenum,
//       this.updatedAt,
//       this.cusId,
//       this.createdAt,
//       this.v,
//       this.accId});

//   Booking.fromJson(Map<String, dynamic> json) {
//     cusAddress = json["cus_address"] == null
//         ? null
//         : CusAddress.fromJson(json["cus_address"]);
//     id = json["_id"];
//     cusName = json["cus_name"];
//     services = json["services"] ?? [];
//     description = json["description"];
//     type = json["type"];
//     time = json["time"];
//     status = json["status"];
//     phonenum = json["phonenum"];
//     updatedAt = json["updatedAt"];
//     cusId = json["cus_id"];
//     createdAt = json["createdAt"];
//     v = json["__v"];
//     accId = json["acc_id"];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (cusAddress != null) {
//       data["cus_address"] = cusAddress?.toJson();
//     }
//     data["_id"] = id;
//     data["cus_name"] = cusName;
//     if (services != null) {
//       data["services"] = services;
//     }
//     data["description"] = description;
//     data["type"] = type;
//     data["time"] = time;
//     data["status"] = status;
//     data["phonenum"] = phonenum;
//     data["updatedAt"] = updatedAt;
//     data["cus_id"] = cusId;
//     data["createdAt"] = createdAt;
//     data["__v"] = v;
//     data["acc_id"] = accId;
//     return data;
//   }

//   Booking copyWith({
//     CusAddress? cusAddress,
//     String? id,
//     String? cusName,
//     List<dynamic>? services,
//     String? description,
//     String? type,
//     String? time,
//     String? status,
//     String? phonenum,
//     String? updatedAt,
//     String? cusId,
//     String? createdAt,
//     int? v,
//     String? accId,
//   }) {
//     return Booking(
//       cusAddress: cusAddress ?? this.cusAddress,
//       id: id ?? this.id,
//       cusName: cusName ?? this.cusName,
//       services: services ?? this.services,
//       description: description ?? this.description,
//       type: type ?? this.type,
//       time: time ?? this.time,
//       status: status ?? this.status,
//       phonenum: phonenum ?? this.phonenum,
//       updatedAt: updatedAt ?? this.updatedAt,
//       cusId: cusId ?? this.cusId,
//       createdAt: createdAt ?? this.createdAt,
//       v: v ?? this.v,
//       accId: accId ?? this.accId,
//     );
//   }
// }

// class CusAddress {
//   String? street;
//   String? ward;
//   String? district;
//   String? city;

//   CusAddress({this.street, this.ward, this.district, this.city});

//   CusAddress.fromJson(Map<String, dynamic> json) {
//     street = json["street"];
//     ward = json["ward"];
//     district = json["district"];
//     city = json["city"];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["street"] = street;
//     data["ward"] = ward;
//     data["district"] = district;
//     data["city"] = city;
//     return data;
//   }

//   CusAddress copyWith({
//     String? street,
//     String? ward,
//     String? district,
//     String? city,
//   }) {
//     return CusAddress(
//       street: street ?? this.street,
//       ward: ward ?? this.ward,
//       district: district ?? this.district,
//       city: city ?? this.city,
//     );
//   }
// }
