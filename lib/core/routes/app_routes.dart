import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_talk/core/networking/dio_handler.dart';
import 'package:hack_talk/core/routes/routes.dart';
import 'package:hack_talk/features/auth/data/repo/forget_password_repo.dart';
import 'package:hack_talk/features/auth/data/repo/login_repo.dart';
import 'package:hack_talk/features/auth/data/repo/register_repo.dart';
import 'package:hack_talk/features/auth/logic/cubit/auth_cubit.dart';
import 'package:hack_talk/features/auth/logic/cubit/forget_password_cubit.dart';
import 'package:hack_talk/features/auth/presentation/screens/forget_password.dart';
import 'package:hack_talk/features/auth/presentation/screens/login_screen.dart';
import 'package:hack_talk/features/auth/presentation/screens/reset_screen.dart';
import 'package:hack_talk/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:hack_talk/features/auth/presentation/screens/verfication_screen.dart';
import 'package:hack_talk/features/home/data/repo/logout_repo.dart';
import 'package:hack_talk/features/home/presentation/screen/home/Computer_vision_screen.dart';
import 'package:hack_talk/features/home/presentation/screen/home/home_screen.dart';
import 'package:hack_talk/features/setting/change_password/data/repo/change_password_repo.dart';
import 'package:hack_talk/features/setting/change_password/presentation/screens/change_password_screen.dart';
import 'package:hack_talk/features/setting/logic/cubit/settings_cubit.dart';
import 'package:hack_talk/features/setting/personal_information/data/repo/profile_repo.dart';
import 'package:hack_talk/features/setting/setting/view/screens/setting_screen.dart';

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({required super.builder});
}

class AppRoutes {
  Route onGenerateRoute(RouteSettings settings) {
    DioHandler dioHandler = DioHandler();
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SettingsCubit(
                    ProfileRepo(dioHandler),
                    ChangePasswordRepo(dioHandler),
                    LogoutRepo(dioHandler),
                  ),
                  child: const HomeScreen(),
                ));
      case Routes.login:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(
                    SignUpRepo(dioHandler),
                    LoginRepo(dioHandler),
                  ),
                  child: const LoginScreen(),
                ));
      case Routes.register:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      AuthCubit(SignUpRepo(dioHandler), LoginRepo(dioHandler)),
                  child: const SignUpScreen(),
                ));
      case Routes.forgetPassword:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ForgetPasswordCubit(
                    ForgetPasswordRepo(dioHandler),
                  ),
                  child: const ForgotPassword(),
                ));
      case Routes.verification:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ForgetPasswordCubit(
                    ForgetPasswordRepo(dioHandler),
                  ),
                  child: const VerficationScreen(),
                ));
      case Routes.resetscreen:
        return MaterialPageRoute(builder: (_) => const ResetScreen());
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const SettingScreen());
      case Routes.changePasswordScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SettingsCubit(
                    ProfileRepo(dioHandler),
                    ChangePasswordRepo(dioHandler),
                    LogoutRepo(dioHandler),
                  ),
                  child: const ChangePasswordScreen(),
                ));
      case Routes.personInformationScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SettingsCubit(
                    ProfileRepo(dioHandler),
                    ChangePasswordRepo(dioHandler),
                    LogoutRepo(dioHandler),
                  ),
                  child: const ChangePasswordScreen(),
                ));
      case Routes.computerVisionScreen:
        return MaterialPageRoute(
            builder: (_) => const ComputerVisionScreen());
    }

    throw Exception('Invalid route: ${settings.name}');
  }
}
