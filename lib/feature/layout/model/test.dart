import 'package:flutter/material.dart.';

class UserModels {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? cover;
  String? bio;

  UserModels(
      {this.name,
      this.email,
      this.phone,
      this.uId,
      this.image,
      this.cover,
      this.bio});

  UserModels.fromJson(Map<String, dynamic>? json) {
    email = json!['email'] ?? '';
    name = json['name'] ?? '';
    phone = json['phone'] ?? '';
    uId = json['uId'] ?? '';
    image = json['image'] ?? '';
    cover = json['cover'] ?? '';
    bio = json['bio'] ?? '';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'cover': cover,
      'bio': bio,
    };
  }
}
