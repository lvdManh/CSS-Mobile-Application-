
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
    required this.accessToken});

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