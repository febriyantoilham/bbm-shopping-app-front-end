import 'package:flutter/cupertino.dart';

class UserModel {
  int id;
  String name;
  String email;
  String phone;
  String gender;
  int orderCount;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.orderCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      gender: json["gender"],
      orderCount: json["order_count"],
    );
  }
}
