class StoryModel {
  String? name;
  String? dateTime;
  String? uId;
  String? image;
  String? object;

  StoryModel({
    this.name,
    this.dateTime,
    this.uId,
    this.image,
    this.object,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      name: json['name'],
      dateTime: json['dateTime'],
      uId: json['uId'],
      image: json['image'],
      object: json['object'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': dateTime, // Convert DateTime to string
      'uId': uId,
      'image': image,
      'object': object,
    };
  }
}
