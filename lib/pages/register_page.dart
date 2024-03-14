import 'package:at_app2/failures/show_message.dart';
import 'package:at_app2/pages/login_page.dart';
import 'package:at_app2/presentation/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocListener<RegistrationBloc, RegistrationState>(
        listenWhen: (previous, current) =>
            current.isSubmissionSuccessOrFailure(),
        listener: (context, state) {
          if (state.formSubmissionStatus == FormSubmissionStatus.success) {
            showSuccessScaffold(
                context, 'Registration success. Please check your e-mail.');
           Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const LoginPage(),
              ),
            );
          }

          if (state.formSubmissionStatus == FormSubmissionStatus.failure) {
            showErrorScaffold(context, 'Registration failed.');
          }

          if (state.formSubmissionStatus ==
              FormSubmissionStatus.confirmPasswordNotMatchWithPassword) {
            showErrorScaffold(
                context, 'Confirm password does not match password.');
          }
        },
        child: Column(
          children: const [
            _EmailInputField(),
            SizedBox(height: 8.0),
            _PasswordInputField(),
            SizedBox(height: 8.0),
            _ConfirmPasswordInputField(),
            SizedBox(height: 8.0),
            _RegisterButton(),
          ],
        ),
      );
}

class _EmailInputField extends StatelessWidget {
  const _EmailInputField();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationBloc, RegistrationState>(
          buildWhen: (previous, current) => current.email != previous.email,
          builder: (context, state) => TextField(
                onChanged: (email) => context
                    .read<RegistrationBloc>()
                    .add(RegistrationEmailAddressChanged(value: email)),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email address',
                  errorText:
                      state.email.hasError ? state.email.errorMessage : null,
                ),
              ));
}

class _PasswordInputField extends StatelessWidget {
  const _PasswordInputField();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationBloc, RegistrationState>(
        buildWhen: (previous, current) => current.password != previous.password,
        builder: (context, state) => TextFormField(
          onChanged: (password) => context
              .read<RegistrationBloc>()
              .add(RegistrationPasswordChanged(value: password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText:
                state.password.hasError ? state.password.errorMessage : null,
          ),
        ),
      );
}

class _ConfirmPasswordInputField extends StatelessWidget {
  const _ConfirmPasswordInputField();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationBloc, RegistrationState>(
        buildWhen: (previous, current) =>
            current.confirmPassword != previous.confirmPassword,
        builder: (context, state) => TextFormField(
          onChanged: (confirmPassword) => context
              .read<RegistrationBloc>()
              .add(RegistrationConfirmPasswordChanged(value: confirmPassword)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            errorText: state.confirmPassword.hasError
                ? state.confirmPassword.errorMessage
                : null,
          ),
        ),
      );
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) => ElevatedButton(
          onPressed: () => state.isSubmitting() || !state.isValid
              ? null
              : context
                  .read<RegistrationBloc>()
                  .add(RegistrationButtonPressed()),
          child: Text(state.isSubmitting() ? 'Submitting' : 'Register'),
        ),
      );
}
