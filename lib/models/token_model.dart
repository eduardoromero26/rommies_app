class TokenModel {
  final String userId;

  TokenModel({required this.userId});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
    };
  }
}
