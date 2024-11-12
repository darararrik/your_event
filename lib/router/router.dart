import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/data/repositories/models/event_model.dart';
import 'package:yourevent/features/about/presentation/view/about_screen.dart';
import 'package:yourevent/features/account/presentation/view/account_screen.dart';
import 'package:yourevent/features/profile_screens/change_email/presentation/view/change_email_screen.dart';
import 'package:yourevent/features/profile_screens/change_password/presentation/view/change_password.dart';
import 'package:yourevent/features/features.dart';
import 'package:yourevent/features/profile_screens/options/presentation/view/settings_screen.dart';

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
          page: ArticlesRoute.page,
        ),
        AutoRoute(
          page: EventTypeRoute.page,
        ),
        AutoRoute(
          page: EventDeatailsRouteView.page,
        ),
        AutoRoute(
          page: AccountRoute.page,
        ),
        AutoRoute(
          page: SettingsRoute.page,
        ),
        AutoRoute(
          page: AboutRoute.page,
        ),
        AutoRoute(
          page: ChangeEmailRoute.page,
        ),
        AutoRoute(
          page: ChangePasswordRoute.page,
        ),
      ];
}
