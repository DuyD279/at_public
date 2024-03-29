import 'dart:async';
import 'package:at_app2/domain/i_authentication_repository.dart';
import 'package:at_app2/presentation/element/email.dart';
import 'package:at_app2/presentation/element/password.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_event.dart';
part 'login_state.dart';

@Injectable()
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthenticationRepository _authenticationRepository;
  
  LoginBloc(this._authenticationRepository) : super(const LoginState()) {
    on<LoginEmailAddressChanged>(_onEmailAddressChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }
  
  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isValid) return;

    emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.submitting));
    
    try {
      await _authenticationRepository.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.failure));
    }
  }

  Future<void> _onEmailAddressChanged(
    LoginEmailAddressChanged event,
    Emitter<LoginState> emit,
  ) async =>
      emit(state.copyWith(
        email: EmailAddress.create(event.value),
        formSubmissionStatus: FormSubmissionStatus.initial,
      ));

  Future<void> _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) async =>
      emit(state.copyWith(
        password: Password.create(event.value),
        formSubmissionStatus: FormSubmissionStatus.initial,
      ));
}