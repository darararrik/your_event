import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/router/router.dart';

abstract class CreateEventRoutes {
  static final routes = AutoRoute(
    page: EventTypeRoute.page, 
    children: [
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


