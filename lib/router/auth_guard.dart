import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/Presentation/blocs/auth/auth_bloc.dart';
import 'package:yourevent/router/router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final context = router.navigatorKey.currentContext;
    if (context != null) {
      final authState = context.read<AuthBloc>().state;

      if (authState is AuthSuccess) {
        resolver.next();
      } else {
        router.replace(const StartRoute());
      }
    } else {
      // Обработка случая, когда контекст не доступен
      router.replace(const StartRoute());
    }
  }
}
