class PostModel {
  String? name;
  String? uId;
  String? dateTime;
  String? image;
  String? text;
  String? postImage;
  String? video;
  String? createTime;
  String? updateTime;

  PostModel({
    this.name,
    this.uId,
    this.dateTime,
    this.image,
    this.text,
    this.postImage,
    this.video,
    this.createTime,
    this.updateTime,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final fields = json['fields'] as Map<String, dynamic>;

    return PostModel(
      name: fields['name']['stringValue'],
      uId: fields['uId']['stringValue'],
      dateTime: fields['dateTime']['stringValue'],
      image: fields['image']['stringValue'],
      text: fields['text']['stringValue'],
      postImage: fields['postImage']['stringValue'],
      video: fields['video']['stringValue'],
      createTime: json['createTime'],
      updateTime: json['updateTime'],
    );
  }
}

