part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}
class UpdateUserLoadingSettingState extends SettingState {}

class UpdateUserSuccessSettingState extends SettingState {}

class UpdateUserErrorSettingState extends SettingState {
  final String error;
  UpdateUserErrorSettingState(this.error);
}

class GetUserDataLoading extends SettingState {}
class GetUserDataSuccess extends SettingState {}
class GetUserDataError extends SettingState {}
class ProfileImageCoverSuccessState extends SettingState {}
class ProfileImageCoverErrorState extends SettingState {}