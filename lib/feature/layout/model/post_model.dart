class PostModel {
  String? name;
  String? uId;
  String? dateTime;
  String? image;
  String? text;
  String? postImage;
  String? video;
  List<dynamic>? postComments;
  List<dynamic>? postLikes;

  dynamic? longitude;
  dynamic? latitude;

  PostModel({
    this.name,
    this.uId,
    this.dateTime,
    this.image,
    this.text,
    this.postImage,
    this.postLikes,
    this.postComments,
    this.video,
    this.longitude,
    this.latitude,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      name: json['name'],
      uId: json['uId'],
      dateTime: json['dateTime'],
      image: json['image'],
      text: json['text'],
      postImage: json['postImage'],
      postLikes: json['postLikes'],
      postComments: json['postComments'],
      video: json['video'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
      'video': video,
      'longitude': longitude,
      'latitude': latitude,
      'postLikes': postLikes,
      'postComments': postComments,
    };
  }
}
