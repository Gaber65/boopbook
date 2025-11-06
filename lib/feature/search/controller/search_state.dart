part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class GetAllUserLoadingSearchState extends SearchState {}

class GetAllUserSuccessSearchState extends SearchState {}

class GetAllUserErrorSearchState extends SearchState {}
class SocialLikeSearchStateSuccess extends SearchState {}
class SocialLikeSearchStateError extends SearchState {}
