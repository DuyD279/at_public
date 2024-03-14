import 'package:at_app2/presentation/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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