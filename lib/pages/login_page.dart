import 'package:at_app2/failures/show_message.dart';
import 'package:at_app2/pages/home_page.dart';
import 'package:at_app2/presentation/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage();

  @override
  Widget build(BuildContext context) => BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) =>
            current.isSubmissionSuccessOrFailure(),
        listener: (context, state) {
          if (state.formSubmissionStatus == FormSubmissionStatus.success) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const HomePage(),
              ),
            );
          }
          if (state.formSubmissionStatus == FormSubmissionStatus.failure) {
            showErrorScaffold(
                context, 'Login failed. Please check your credentials.');
          }
        },
        child: Column(
          children: const [
            _EmailInputField(),
            SizedBox(height: 8.0),
            _PasswordInputField(),
            SizedBox(height: 8.0),
            _LoginButton()
          ],
        ),
      );
}

class _EmailInputField extends StatelessWidget {
  const _EmailInputField();

@override
  Widget build(BuildContext context) => BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => current.email != previous.email,
      builder: (context, state) => TextField(
            onChanged: (email) => context
                .read<LoginBloc>()
                .add(LoginEmailAddressChanged(value: email)),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email address',
              errorText: state.email.hasError ? 
                         state.email.errorMessage : null,
            ),
          ));
}

class _PasswordInputField extends StatelessWidget {
  const _PasswordInputField();

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => current.password != previous.password,
        builder: (context, state) => TextFormField(
          onChanged: (password) => context
              .read<LoginBloc>()
              .add(LoginPasswordChanged(value: password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText:
                state.password.hasError ? state.password.errorMessage : null,
          ),
        ),
      );
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => ElevatedButton(
          onPressed: () => state.isSubmitting() || !state.isValid
              ? null
              : context.read<LoginBloc>().add(LoginButtonPressed()),
          child: Text(state.isSubmitting() ? 'Submitting' : 'Login'),
        ),
      );
}