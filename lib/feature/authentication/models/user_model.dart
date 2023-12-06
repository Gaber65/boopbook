import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final Map<String,dynamic> name;
  final Map<String,dynamic>  email;
  final Map<String,dynamic>  phone;
  Map<String,dynamic> ? uId;
  Map<String,dynamic> ? isEmailVerified;
  Map<String,dynamic> ? image;
  Map<String,dynamic> ? cover;
  Map<String,dynamic> ? bio;

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
