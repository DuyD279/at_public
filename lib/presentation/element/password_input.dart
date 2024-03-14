import 'package:at_app2/presentation/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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