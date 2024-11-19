// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AboutScreen]
class AboutRoute extends PageRouteInfo<void> {
  const AboutRoute({List<PageRouteInfo>? children})
      : super(
          AboutRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AboutScreen();
    },
  );
}

/// generated route for
/// [AccountScreen]
class AccountRoute extends PageRouteInfo<void> {
  const AccountRoute({List<PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AccountScreen();
    },
  );
}

/// generated route for
/// [AgentsScreen]
class AgentsRoute extends PageRouteInfo<void> {
  const AgentsRoute({List<PageRouteInfo>? children})
      : super(
          AgentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AgentsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AgentsScreen();
    },
  );
}

/// generated route for
/// [ArticlesScreen]
class ArticlesRoute extends PageRouteInfo<void> {
  const ArticlesRoute({List<PageRouteInfo>? children})
      : super(
          ArticlesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ArticlesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ArticlesScreen();
    },
  );
}

/// generated route for
/// [ChangeEmailScreen]
class ChangeEmailRoute extends PageRouteInfo<ChangeEmailRouteArgs> {
  ChangeEmailRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ChangeEmailRoute.name,
          args: ChangeEmailRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ChangeEmailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChangeEmailRouteArgs>(
          orElse: () => const ChangeEmailRouteArgs());
      return ChangeEmailScreen(key: args.key);
    },
  );
}

class ChangeEmailRouteArgs {
  const ChangeEmailRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ChangeEmailRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ChangePasswordScreen]
class ChangePasswordRoute extends PageRouteInfo<void> {
  const ChangePasswordRoute({List<PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [EventDetailsPageView]
class EventDetailsRouteView extends PageRouteInfo<EventDetailsRouteViewArgs> {
  EventDetailsRouteView({
    Key? key,
    required EventTypeModel eventType,
    List<PageRouteInfo>? children,
  }) : super(
          EventDetailsRouteView.name,
          args: EventDetailsRouteViewArgs(
            key: key,
            eventType: eventType,
          ),
          initialChildren: children,
        );

  static const String name = 'EventDetailsRouteView';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventDetailsRouteViewArgs>();
      return EventDetailsPageView(
        key: args.key,
        eventType: args.eventType,
      );
    },
  );
}

class EventDetailsRouteViewArgs {
  const EventDetailsRouteViewArgs({
    this.key,
    required this.eventType,
  });

  final Key? key;

  final EventTypeModel eventType;

  @override
  String toString() {
    return 'EventDetailsRouteViewArgs{key: $key, eventType: $eventType}';
  }
}

/// generated route for
/// [EventScreen]
class EventRoute extends PageRouteInfo<EventRouteArgs> {
  EventRoute({
    Key? key,
    required EventModel eventData,
    List<PageRouteInfo>? children,
  }) : super(
          EventRoute.name,
          args: EventRouteArgs(
            key: key,
            eventData: eventData,
          ),
          initialChildren: children,
        );

  static const String name = 'EventRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventRouteArgs>();
      return EventScreen(
        key: args.key,
        eventData: args.eventData,
      );
    },
  );
}

class EventRouteArgs {
  const EventRouteArgs({
    this.key,
    required this.eventData,
  });

  final Key? key;

  final EventModel eventData;

  @override
  String toString() {
    return 'EventRouteArgs{key: $key, eventData: $eventData}';
  }
}

/// generated route for
/// [EventTypeScreen]
class EventTypeRoute extends PageRouteInfo<void> {
  const EventTypeRoute({List<PageRouteInfo>? children})
      : super(
          EventTypeRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventTypeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EventTypeScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [MyEventsScreen]
class MyEventsRoute extends PageRouteInfo<void> {
  const MyEventsRoute({List<PageRouteInfo>? children})
      : super(
          MyEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyEventsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MyEventsScreen();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}

/// generated route for
/// [SignInScreen]
class SignInRoute extends PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SignInRoute.name,
          args: SignInRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SignInRouteArgs>(orElse: () => const SignInRouteArgs());
      return SignInScreen(key: args.key);
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SignUpScreen]
class SignUpRoute extends PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SignUpRouteArgs>(orElse: () => const SignUpRouteArgs());
      return SignUpScreen(key: args.key);
    },
  );
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}

/// generated route for
/// [StartScreen]
class StartRoute extends PageRouteInfo<void> {
  const StartRoute({List<PageRouteInfo>? children})
      : super(
          StartRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const StartScreen();
    },
  );
}
