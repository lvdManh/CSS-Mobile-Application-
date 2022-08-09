
import 'dart:convert';

class User {
  final String id;
  final String username;
  final String status;
  final String role;
  final List<dynamic> booking;
  final bool deleted;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String refreshToken;
  final String accessToken;

  User({
    required this.id,
    required this.username,
    required this.status,
    required this.role,
    required this.booking,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.refreshToken,
    required this.accessToken,
    });

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'username' : username,
      'status' : status,
      'role' : role,
      'booking' : booking,
      'deleted' : deleted,
      'createdAt' : createdAt,
      'updatedAt' : updatedAt,
      'v': v,
      'refreshToken' : refreshToken,
      'accessToken' : accessToken,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      username: map['username'] ?? '',
      status: map['status'] ?? '',
      role: map['role'] ?? '',
      booking: map['booking'] ?? '',
      deleted: map['deleted'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      v: map['v'] ?? 0,
      refreshToken: map['refreshToken'] ?? '',
      accessToken: map['accessToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
     String? id,
     String? username,
     String? status,
     String? role,
     List<dynamic>? booking,
     bool? deleted,
     String? createdAt,
     String? updatedAt,
     int? v,
     String? refreshToken,
     String? accessToken,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      status:  status ?? this.status,
      role: role ?? this.role,
      booking: booking ?? this.booking,
      deleted: deleted ?? this.deleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      refreshToken: refreshToken ?? this.refreshToken,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}


class Account {
  Address? address;
  String? img;
  String? id;
  String? name;
  String? email;
  String? phonenum;
  String? birth;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? accId;

  Account({this.address, this.img, this.id, this.name, this.email, this.phonenum, this.birth, this.createdAt, this.updatedAt, this.v, this.accId});

  Account.fromJson(Map<String, dynamic> json) {
    if(json["address"] is Map) {
      address = json["address"] == null ? null : Address.fromJson(json["address"]);
    }
    if(json["img"] is String) {
      img = json["img"];
    }
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["phonenum"] is String) {
      phonenum = json["phonenum"];
    }
    if(json["birth"] is String) {
      birth = json["birth"];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(address != null) {
      data["address"] = address?.toJson();
    }
    data["img"] = img;
    data["_id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["phonenum"] = phonenum;
    data["birth"] = birth;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    data["acc_id"] = accId;
    return data;
  }
}

class Address {
  String? city;
  String? district;
  String? ward;
  String? street;

  Address({this.city, this.district, this.ward, this.street});

  Address.fromJson(Map<String, dynamic> json) {
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

