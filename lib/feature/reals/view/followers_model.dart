class FollowerModel {
  String name;
  String image;
  String uId;

  FollowerModel({
    required this.name,
    required this.image,
    required this.uId,
  });

  factory FollowerModel.fromJson(Map<String, dynamic> json) {
    return FollowerModel(
      name: json['name'],
      image: json['image'],
      uId: json['uId'],
    );
  }
}
