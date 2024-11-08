class HouseModel {
  final String houseId;

  HouseModel({required this.houseId});

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
      houseId: json['houseId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'houseId': houseId,
    };
  }
}
