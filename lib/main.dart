import 'package:at_app2/dependency_injection.dart';
import 'package:at_app2/pages/home_page.dart';
import 'package:at_app2/pages/login_page.dart';
import 'package:at_app2/presentation/auth_bloc.dart' as authBloc;
import 'package:at_app2/presentation/auth_bloc.dart';
import 'package:at_app2/splash_page.dart';
import 'package:at_app2/themes/dark_mode.dart';
import 'package:at_app2/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://prxovcnwshtjnzvysoxa.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InByeG92Y253c2h0am56dnlzb3hhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTAwMzg2NTQsImV4cCI6MjAyNTYxNDY1NH0.8wmzzkc3mBS8AXIPPmJYQEUC3aD4Tk70fp2YQ59nG90',
  );

  configureDependencies();

  runApp(BlocProvider(
    create: (_) => getIt<authBloc.AuthBloc>()..add(AuthInitialCheckRequested()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ABCD',
        home: BlocConsumer<AuthBloc, authBloc.AuthState>(
        listener: (context, state) {
          if (state is AuthUserUnauthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const LoginPage(),
              ),
            );
          }
          if (state is AuthUserAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const HomePage(),
              ),
            );
          }
        },
        builder: (context, state) => const SplashPage(),
      ),
        theme: lightMode,
        darkTheme: darkMode,
        /*routes: {
          '/login_register_page': (context) => const LoginOrRegisterPage(),
          '/users_page': (context) => const UsersPage(),
          '/home_page': (context) => const HomePage(),
          '/profile_page': (context) => ProfilePage(),
          '/forgot_password_page': (context) => const ForgotPasswordPage(),
          '/following_post_page': (context) => const FollowingPostPage(),
          '/create_post_page': (context) => const CameraExampleHome(),
          '/search_page': (context) => const SearchPage(),
          '/saved_page': (context) => const SavedPage(),
          '/settings_page': (context) => SettingsPage(),
          '/message_page': (context) => MessagePage(),
          '/screen_wrapper': (context) => ScreenWrapper(),
        }*/);
        
  }
