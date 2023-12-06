part of 'ath_cubit.dart';

@immutable
abstract class AthState {}

class AthInitial extends AthState {}

class SignInLoading extends AthState {}
class SignInError extends AthState {
  final String e;

  SignInError(this.e);
}
class SignInSuccess extends AthState {
  final String r;

  SignInSuccess(this.r);
}


class SignUpLoading extends AthState {}
class SignUpError extends AthState {
  final String e;

  SignUpError(this.e);
}
class SignUpSuccess extends AthState {
  final dynamic r;

  SignUpSuccess(this.r);
}


class CreateUserLoading extends AthState {}
class CreateUserError extends AthState {
  final String e;

  CreateUserError(this.e);
}
class CreateUserSuccess extends AthState {
  final dynamic r;

  CreateUserSuccess(this.r);
}


class RestPasswordLoading extends AthState {}
class RestPasswordError extends AthState {
  final String e;

  RestPasswordError(this.e);
}
class RestPasswordSuccess extends AthState {}
