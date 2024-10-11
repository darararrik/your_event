import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/data/models/event_model.dart';
import 'package:yourevent/features/features.dart';
import 'package:yourevent/router/auth_guard.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: StartRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: SignInRoute.page,
        ),
        AutoRoute(
          page: SignUpRoute.page,
        ),
        AutoRoute(
          page: MainRoute.page,
          guards: [AuthGuard()],
          children: [
            AutoRoute(
              page: HomeRoute.page,
              initial: true,
            ),
            AutoRoute(
              page: ProfileRoute.page,
            ),
            AutoRoute(
              page: MyEventsRoute.page,
            ),
            AutoRoute(
              page: AgentsRoute.page,
            ),
          ],
        ),
        AutoRoute(
          page: EventTypeRoute.page,
        ),
         AutoRoute(
          page: EventDeatailsRouteView.page,
        ),
      ];
}
