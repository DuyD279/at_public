import 'dart:async';

import 'package:at_app2/domain/i_authentication_repository.dart';
import 'package:at_app2/presentation/element/email.dart';
import 'package:at_app2/presentation/element/password.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


part 'registration_event.dart';
part 'registration_state.dart';

@Injectable()
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final IAuthenticationRepository _authenticationRepository;

  RegistrationBloc(this._authenticationRepository)
      : super(const RegistrationState()) {
    on<RegistrationButtonPressed>(_onRegistrationRegisterButtonPressed);
    on<RegistrationEmailAddressChanged>(_onEmailAddressChanged);
    on<RegistrationPasswordChanged>(_onPasswordChanged);
    on<RegistrationConfirmPasswordChanged>(_onConfirmPasswordChanged);
  }

  Future<void> _onRegistrationRegisterButtonPressed(
    RegistrationButtonPressed event,
    Emitter<RegistrationState> emit,
  ) async {
    if (!state.isValid) return;

    emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.submitting));

    if (!_isConfirmPasswordMatchedWithPassword(
      state.password.value,
      state.confirmPassword.value,
    )) {
      emit(state.copyWith(
          formSubmissionStatus:
              FormSubmissionStatus.confirmPasswordNotMatchWithPassword));

      return;
    }

    try {
      await _authenticationRepository.signUpWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.failure));
    }
  }

  Future<void> _onEmailAddressChanged(
    RegistrationEmailAddressChanged event,
    Emitter<RegistrationState> emit,
  ) async =>
      emit(state.copyWith(
        email: EmailAddress.create(event.value),
        formSubmissionStatus: FormSubmissionStatus.initial,
      ));

  Future<void> _onPasswordChanged(
    RegistrationPasswordChanged event,
    Emitter<RegistrationState> emit,
  ) async =>
      emit(state.copyWith(
        password: Password.create(event.value),
        formSubmissionStatus: FormSubmissionStatus.initial,
      ));

  Future<void> _onConfirmPasswordChanged(
    RegistrationConfirmPasswordChanged event,
    Emitter<RegistrationState> emit,
  ) async =>
      emit(state.copyWith(
        confirmPassword: Password.create(event.value),
        formSubmissionStatus: FormSubmissionStatus.initial,
      ));

  bool _isConfirmPasswordMatchedWithPassword(
    String password,
    String confirmPassword,
  ) =>
      password == confirmPassword;
}
