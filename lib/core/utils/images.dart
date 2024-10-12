import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yourevent/core/utils/utils.dart';

final Widget logo = SvgPicture.asset(
  "assets/images/logo.svg",
  width: 134,
  height: 52,
);
final Widget faqSearch = SvgPicture.asset(
  "assets/images/search.svg",
  width: 70,
  height: 70,
);
final Widget package = SvgPicture.asset(
  "assets/images/package.svg",
  width: 70,
  height: 70,
);
final Widget imgStartScreen = SvgPicture.asset(
    'assets/images/img_start_screen.svg',
    width: 220,
    height: 220);
// final Widget bottomSvgPicture = SvgPicture.asset('assets/images/bottomSvgPicture.svg',
//     fit: BoxFit.fill);
final Widget placeholder = Image.asset("assets/images/placeholder.png");
final Widget like = Image.asset("/assets/images/like.png");

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
final Widget agents = SvgPicture.asset(
  'assets/images/Agents.svg',
  width: 32, // ширина иконки
  height: 32, // высота иконки
);
final Widget agentsSelected = SvgPicture.asset(
  colorFilter: const ColorFilter.mode(orange, BlendMode.srcIn),

  'assets/images/Agents.svg',
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
