import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/router/router.dart';

abstract class HomeRoutes {
  static final routes = AutoRoute(page: HomeWrapperRoute.page, children: [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(
      page: EventTypeRoute.page,
      path: 'event-type',
    ),
    AutoRoute(
      page: EventDetailsRoute.page,
      path: 'event-details',
    ),
    AutoRoute(
      page: CreateEventRoute.page,
      path: 'event-confirm',
    ),
  ]);
}


