import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/cubit/initial_cubit/initial_cubit.dart';
import '../../features/auth/presentation/cubit/initial_cubit/initial_state.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/solidary/presentation/pages/solidary_page.dart';
import '../../features/splash&onboarding/presentation/pages/on_boarding_page.dart';
import 'app_routes.dart';

class RouteManager {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.loginRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const OnBoardingPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );
      case AppRoutes.rootRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // return const LoginPage();
            return BlocBuilder<InitialCubit, InitialState>(
              builder: (context, authState) {
                if (authState is Initialized) {
                  return const SolidaryPage();
                } else {
                  return const LoginPage();
                }
              },
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.solidaryRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const SolidaryPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Text("Rota não existente"),
        );
    }
  }
}
