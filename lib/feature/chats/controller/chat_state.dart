part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}
class SocialGetMessagesSuccessState extends ChatState {}
class SocialSendMessageSuccessState extends ChatState {}
class SocialSendMessageErrorState extends ChatState {}
class SocialPostImagePickedSuccessState extends ChatState {}
class SocialPostImagePickedErrorState extends ChatState {}
class UpdateUserLoadingHomePageStates extends ChatState {}
class UpdateUserSuccessHomePageStates extends ChatState {}
class UpdateUserErrorHomePageStates extends ChatState {}
class SocialRemovePostImageState extends ChatState {}
