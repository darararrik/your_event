import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/features/articles/view/article_screen.dart';
import 'package:yourevent/features/articles/view/articles_screen.dart';
import 'package:yourevent/features/create_event/view/event_confirm_screen.dart';
import 'package:yourevent/features/create_event/view/event_details_screen.dart';
import 'package:yourevent/features/create_event/view/event_type_screen.dart';
import 'package:yourevent/features/features.dart';
import 'package:yourevent/features/home/routes/home_routes.dart';
import 'package:yourevent/features/home/view/home_wrapper_screen.dart';
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
            HomeRoutes.routes,
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
      ];
}
