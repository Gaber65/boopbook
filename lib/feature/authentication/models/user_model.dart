import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  String? uId;
  bool? isEmailVerified;
  String? image;
  String? cover;
  String? bio;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.uId,
    this.isEmailVerified,
    this.image,
    this.cover,
    this.bio,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      uId: json['uId'],
      image: json['image'],
      bio: json['bio'],
      cover: json['cover'],
      isEmailVerified: json['isEmailVerified'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'isEmailVerified': false,
      'image': image,
      'cover': cover,
      'bio': bio,
      'uId': uId,
    };
  }

  @override
  List<Object?> get props {
    return [
      name,
      email,
      phone,
      image,
      isEmailVerified,
      image,
      cover,
      bio,
      uId,
    ];
  }
}
