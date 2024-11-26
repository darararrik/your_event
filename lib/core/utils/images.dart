import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yourevent/core/utils/utils.dart';

//Логотип
final Widget logo = SvgPicture.asset(
  "assets/images/logo.svg",
  width: 134,
  height: 52,
);
final Widget calendarIcon = SvgPicture.asset(
  "assets/images/calendar.svg",
);
//Иконка глаза скрыть\раскрыть пароль
final Widget passwordHiddenIcon = SvgPicture.asset(
  "assets/images/eye-hidden.svg",
//Иконка глаза скрыть\раскрыть пароль
);
final Widget passwordOpenIcon = SvgPicture.asset(
  "assets/images/eye-open.svg",
);
//Иконка сердца
final Widget favoriteIcon = SvgPicture.asset(
  "assets/images/heart.svg",
  width: 24,
  height: 24,
);
final Widget filterIcon = SvgPicture.asset(
  "assets/images/filterIcon.svg",
  width: 24,
  height: 24,
);
final Widget sortIcon = SvgPicture.asset(
  "assets/images/sort.svg",
  width: 24,
  height: 24,
);
final Widget editIcon = SvgPicture.asset(
  "assets/images/edit.svg",
);
final Widget rubIcon = SvgPicture.asset(
  "assets/images/rub.svg",
);
final Widget location = SvgPicture.asset(
  "assets/images/location.svg",
  width: 20,
  height: 20,
);
final Widget people = SvgPicture.asset(
  "assets/images/people.svg",
);
final Widget surprise = SvgPicture.asset(
  "assets/images/surprise.svg",
  width: 24,
  height: 24,
);

final Widget placeholder = Image.asset(
  "assets/images/placeholder.png",
);

final Widget home = SvgPicture.asset(
  'assets/images/Nav1Home.svg',
  width: 32, // ширина иконки
  height: 32, // высота иконки
);
final Widget homeSelected = SvgPicture.asset(
  'assets/images/Nav1Home.svg',
  colorFilter: const ColorFilter.mode(orange, BlendMode.srcIn),
  width: 32, // ширина иконки
  height: 32, // высота иконки
);
final Widget chat = SvgPicture.asset(
  'assets/images/chat.svg',
  width: 32, // ширина иконки
  height: 32, // высота иконки
);
final Widget addEventIcon = SvgPicture.asset(
  'assets/images/add_event.svg',
  width: 64, // ширина иконки
  height: 64, // высота иконки
);
final Widget chatSelected = SvgPicture.asset(
  colorFilter: const ColorFilter.mode(orange, BlendMode.srcIn),

  'assets/images/chat.svg',
  width: 32, // ширина иконки
  height: 32, // высота иконки
);
final Widget profile = SvgPicture.asset(
  'assets/images/profile.svg',
  width: 32, // ширина иконки
  height: 32, // высота иконки
);
final Widget profileSelected = SvgPicture.asset(
  colorFilter: const ColorFilter.mode(orange, BlendMode.srcIn),

  'assets/images/profile.svg',
  width: 32, // ширина иконки
  height: 32, // высота иконки
);

final Widget myEvents = SvgPicture.asset(
  'assets/images/MyEv.svg',
  width: 32, // ширина иконки
  height: 32, // высота иконки
);
final Widget myEventsSelected = SvgPicture.asset(
  colorFilter: const ColorFilter.mode(orange, BlendMode.srcIn),

  'assets/images/MyEv.svg',
  width: 32, // ширина иконки
  height: 32, // высота иконки
);
final Widget emailCheck = SvgPicture.asset(
  colorFilter: const ColorFilter.mode(orange, BlendMode.srcIn),

  'assets/images/email.svg',
  width: 64, // ширина иконки
  height: 64, // высота иконки
);
final Widget successPicture = SvgPicture.asset('assets/images/success.svg');
final Widget emptyEventsPicture =
    SvgPicture.asset('assets/images/emptyEvents.svg');
final Widget passwordResetPicture = SvgPicture.asset(
  'assets/images/passwordReset.svg',
  width: 64,
  height: 64,
);
