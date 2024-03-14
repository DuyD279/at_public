import 'package:at_app2/data/authentication_repository.dart';
import 'package:at_app2/domain/i_authentication_repository.dart';
import 'package:at_app2/presentation/auth_bloc.dart';
import 'package:at_app2/presentation/login_bloc.dart';
import 'package:at_app2/presentation/registration_bloc.dart';

import 'dependency_injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class AppModule {
  @preResolve
  IAuthenticationRepository get authenticationRepository => GetIt.instance<AuthenticationRepository>();

  @injectable
  LoginBloc get loginBloc => LoginBloc(authenticationRepository);

  @injectable
  RegistrationBloc get registrationBloc => RegistrationBloc(authenticationRepository);

  @injectable
  AuthBloc get authBloc => AuthBloc(authenticationRepository);
}