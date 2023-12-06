
class StoryModel {
  String? name;
  String? text;
  String? id;
  String? dateTime;
  String? uId;
  String? image;
  String? object;
  String? createTime;
  String? updateTime;

  StoryModel({
    this.name,
    this.text,
    this.id,
    this.dateTime,
    this.uId,
    this.image,
    this.object,
    this.createTime,
    this.updateTime,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    final fields = json['fields'] as Map<String, dynamic>;

    return StoryModel(
      name: fields['name']['stringValue'],
      text: fields['text']['stringValue'],
      id: json['name'],
      dateTime: fields['dateTime']['stringValue'],
      uId: fields['uId']['stringValue'],
      image: fields['image']['stringValue'],
      object: fields['object']['stringValue'],
      createTime: json['createTime'],
      updateTime: json['updateTime'],
    );
  }
}
