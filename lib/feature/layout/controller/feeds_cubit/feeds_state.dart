part of 'feeds_cubit.dart';

@immutable
abstract class FeedsState {}

class FeedsInitial extends FeedsState {}

class GetUserDataLoading extends FeedsState {}
class GetUserDataSuccess extends FeedsState {}
class GetUserDataError extends FeedsState {}


class GetStoryLoading extends FeedsState {}
class GetStorySuccess extends FeedsState {}
class GetStoryError extends FeedsState {}

class GetPostsLoading extends FeedsState {}
class GetPostsSuccess extends FeedsState {}
class GetPostsError extends FeedsState {}
