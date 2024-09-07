import 'package:auto_route/auto_route.dart';
import 'package:yourevent/features/features.dart';
part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: StartRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: SignInRoute.page, 
          path: '/signin',
        ),
        AutoRoute(
          page: SignUpRoute.page, 
          path: '/signup',
        ),
        AutoRoute(
          page: MainRoute.page,
          path: '/main',
          children: [
            AutoRoute(
              page: HomeRoute.page,
              path: 'home',
            ),
            AutoRoute(
              page: ProfileRoute.page,
              path: 'profile',
            ),
            AutoRoute(
              page: MyEventsRoute.page,
              path: 'myevents',
            ),
            AutoRoute(
              page: AgentsRoute.page,
              path: 'agents',
            ),
          ],
        ),
      ];
}