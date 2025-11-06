part of 'community_cubit.dart';

@immutable
abstract class CommunityState {}

class FeedsInitial extends CommunityState {}

class GetUserDataLoading extends CommunityState {}
class GetUserDataSuccess extends CommunityState {}
class GetUserDataError extends CommunityState {}

class GetStoryLoading extends CommunityState {}
class GetStorySuccess extends CommunityState {}
class GetStoryError extends CommunityState {}

class GetPostsLoading extends CommunityState {}
class GetPostsSuccess extends CommunityState {}
class GetPostsError extends CommunityState {}

class RequestLocationPermission extends CommunityState {}
class GetLocationSuccess extends CommunityState {}
class GetLocationError extends CommunityState {}

class NoImageSelectedState extends CommunityState {}
class ImageSelectedState extends CommunityState {
  File file;
  ImageSelectedState(this.file);
}

class UploadImageToFireStateLoading extends CommunityState {}
class UploadImageToFireStateSuccess extends CommunityState {}
class UploadImageToFireStateError extends CommunityState {}


class CreatePostToFireStateLoading extends CommunityState {}
class CreatePostToFireStateSuccess extends CommunityState {}
class CreatePostToFireStateError extends CommunityState {}

class SocialSuccessRemovePostState extends CommunityState {}
class SocialErrorRemovePostState extends CommunityState {}

class SocialLikePostStateSuccess extends CommunityState {}
class SocialLikePostStateError extends CommunityState {}
