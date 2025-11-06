part of 'reals_cubit.dart';

@immutable
abstract class RealsState {}

class RealsInitial extends RealsState {}

class GetRealsLoading extends RealsState {}
class GetRealsSuccess extends RealsState {}
class GetRealsError extends RealsState {}

class NoImageSelectedState extends RealsState {}
class ImageSelectedState extends RealsState {}

class GetUserDataLoading extends RealsState {}
class GetUserDataSuccess extends RealsState {}
class GetUserDataError extends RealsState {}


class UploadVideoToFireStateLoading extends RealsState {}
class UploadImageToFireStateSuccess extends RealsState {}
class UploadImageToFireStateError extends RealsState {}

class SocialLikePostStateSuccess extends RealsState {}
class SocialLikePostStateError extends RealsState {}

