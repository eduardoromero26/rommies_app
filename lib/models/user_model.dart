class UserModel {
  final String userId;
  final String email;
  final String name;
  final String houseId;
  final String uid;

  UserModel(
      {required this.userId,
      required this.email,
      required this.name,
      required this.houseId,
      required this.uid});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      email: json['email'],
      name: json['name'],
      houseId: json['houseId'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'houseId': houseId,
      'uid': uid,
    };
  }
}
