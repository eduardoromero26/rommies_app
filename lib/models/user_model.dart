import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String houseId;
  final String uid;

  UserModel(
      {required this.email,
      required this.name,
      required this.houseId,
      required this.uid});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      houseId: json['houseId'],
      uid: json['uid'],
    );
  }

  factory UserModel.fromDocument(Map<String, dynamic> data, String documentId) {
    return UserModel(
      email: data['email'],
      name: data['name'],
      houseId: data['houseId'],
      uid: documentId,
    );
  }

  String toJsonEncode() {
    return jsonEncode(toJson());
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'houseId': houseId,
      'uid': uid,
    };
  }
}
