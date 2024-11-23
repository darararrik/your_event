import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';
import 'package:yourevent/core/data/repositories/models/models.dart';
import 'package:yourevent/features/about/Presentation/view/about_screen.dart';
import 'package:yourevent/features/profile_screens/account/Presentation/view/account_screen.dart';
import 'package:yourevent/features/agents/view/agents_screen.dart';
import 'package:yourevent/features/articles/view/articles_screen.dart';
import 'package:yourevent/features/auth_screens/sign_in/view/sign_in_screen.dart';
import 'package:yourevent/features/auth_screens/sign_up/view/sign_up_screen.dart';
import 'package:yourevent/features/event_screens/create_event/presentation/view/event_details_page_view.dart';
import 'package:yourevent/features/event_screens/create_event/presentation/view/event_type_screen.dart';
import 'package:yourevent/features/event_screens/event/presentation/view/event_screen.dart';
import 'package:yourevent/features/event_screens/wrapper.dart';
import 'package:yourevent/features/home/Presentation/view/home_screen.dart';
import 'package:yourevent/features/main/view/main_screen.dart';
import 'package:yourevent/features/my_events/Presentation/view/my_events_screen.dart';
import 'package:yourevent/features/profile_screens/change_email/Presentation/view/change_email_screen.dart';
import 'package:yourevent/features/profile_screens/change_password/Presentation/view/change_password.dart';
import 'package:yourevent/features/profile_screens/options/Presentation/view/settings_screen.dart';
import 'package:yourevent/features/profile_screens/profile/Presentation/view/profile_screen.dart';
import 'package:yourevent/features/start/view/start_screen.dart';
import '../features/event_screens/service_details/presentation/view/service_details_screen.dart';
import '../features/event_screens/service_selection/presentation/view/service_selection_screen.dart';

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
          page: WrapperRoute.page,
          children: [
            AutoRoute(
              initial: true,
              page: EventRoute.page,
            ),
            AutoRoute(
              page: ServiceSelectionRoute.page,
            ),
            AutoRoute(
              page: ServiceDetailsRoute.page,
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
          page: EventDetailsRouteView.page,
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
