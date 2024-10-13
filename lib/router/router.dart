import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/data/models/event_model.dart';
import 'package:yourevent/features/about/presentation/view/about_screen.dart';
import 'package:yourevent/features/account/presentation/view/account_screen.dart';
import 'package:yourevent/features/change_email/presentation/view/change_email_screen.dart';
import 'package:yourevent/features/change_password/presentation/view/change_password.dart';
import 'package:yourevent/features/features.dart';
import 'package:yourevent/features/options/presentation/view/settings_screen.dart';
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
          guards: [AuthGuard()],
          page: ArticlesRoute.page,
        ),
        AutoRoute(
          guards: [AuthGuard()],
          page: EventTypeRoute.page,
        ),
        AutoRoute(
          guards: [AuthGuard()],
          page: EventDeatailsRouteView.page,
        ),
        AutoRoute(
          guards: [AuthGuard()],
          page: AccountRoute.page,
        ),
        AutoRoute(
          guards: [AuthGuard()],
          page: SettingsRoute.page,
        ),
        AutoRoute(
          guards: [AuthGuard()],
          page: AboutRoute.page,
        ),
        AutoRoute(
          guards: [AuthGuard()],
          page: ChangeEmailRoute.page,
        ),
        AutoRoute(
          guards: [AuthGuard()],
          page: ChangePasswordRoute.page,
        ),
      ];
}
