import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
String logoString =  'assets/images/logo.svg';
final Widget logo = SvgPicture.asset(logoString,
width: 134, height: 52,);
final Widget imgStartScreen = SvgPicture.asset('assets/images/img_start_screen.svg',
    width: 220,
    height: 220);
// final Widget bottomSvgPicture = SvgPicture.asset('assets/images/bottomSvgPicture.svg',
//     fit: BoxFit.fill);
