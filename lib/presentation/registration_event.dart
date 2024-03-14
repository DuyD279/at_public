part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationEmailAddressChanged extends RegistrationEvent {
  final String value;

  const RegistrationEmailAddressChanged({required this.value});

  @override
  List<Object> get props => [value];
}

class RegistrationPasswordChanged extends RegistrationEvent {
  final String value;

  const RegistrationPasswordChanged({required this.value});

  @override
  List<Object> get props => [value];
}

class RegistrationConfirmPasswordChanged extends RegistrationEvent {
  final String value;

  const RegistrationConfirmPasswordChanged({required this.value});

  @override
  List<Object> get props => [value];
}

class RegistrationButtonPressed extends RegistrationEvent {
  @override
  List<Object> get props => [];
}