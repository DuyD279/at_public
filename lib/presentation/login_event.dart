part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailAddressChanged extends LoginEvent {
  final String value;

  const LoginEmailAddressChanged({required this.value});

  @override
  List<Object> get props => [value];
}

class LoginPasswordChanged extends LoginEvent {
  final String value;

  const LoginPasswordChanged({required this.value});

  @override
  List<Object> get props => [value];
}

class LoginButtonPressed extends LoginEvent {
  @override
  List<Object> get props => [];
}