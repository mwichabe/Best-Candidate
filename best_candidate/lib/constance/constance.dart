// ignore_for_file: unrelated_type_equality_checks, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const defaultRadius = 12.0;
const defaultPadding = 15.0;
const blueColor = Color(0xff1ab1dc);
const redColor = Color(0xfff1323a);
const greenColor = Color(0xff3ad5b6);
const primarycolor = Color(0xff2C4CBC);
const textColor = Color(0xff3054cf);
const lightGreyColor = Color(0xffF3F3F3);

ColorThemes(BuildContext context) {
  Theme.of(context);
}

TextThemes(BuildContext context) {
  Theme.of(context).textTheme;
}

///
/* 
Color backgroundColor = Colors.white;
var foregroundColor =
    backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
 */
///

Size displaySize(BuildContext context) {
  debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  debugPrint('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  debugPrint('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;
}

showToast(String? message) => Fluttertoast.showToast(
    msg: message.toString(),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 10,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0);

class ConstanceData {
  static String bseImageUrl = 'assets/images/';
  static String splashBg = bseImageUrl + "background.png";
  static String logo = bseImageUrl + "Best_candidate.png";


  ////////////////////////////////////////////
  static String bseIconUrl = 'assets/icons/';


  //static String bseJsonUrl = "assets/jsonImage/";
  //////////////////////////////////////////
  ///
  static String bseVideoUrl = "assets/videos/";
  static String logoVideo = bseImageUrl + "Best_candidate.mp4";


  List<String> colors = [
    '#f4651f',
    '#FF2222',
    '#32a852',
    '#4C4CFF',
    '#B323BA',
    '#4FBE9F'
  ];
}

int colorsIndex = 0;

var primaryColorString = '#3054cf';
var secondaryColorString = '#0ab7e4';