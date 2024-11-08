class TokenModel {
  final String uid;

  TokenModel({required this.uid});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
    };
  }
}
