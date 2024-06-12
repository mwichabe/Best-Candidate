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
  //
  static String consumerKey ="hyfVQv3FvvKgbhPpcUbg4aMf7bW4ThHknTf4UP4v0qpCsKkP";
  static String consumerSecret="tJy9Gs3ATOiOP51LSaWILC9odHkWF0D79DZZncVGJdNVFd7mdjGNQT4G7MRgwuGb";
  static String testCredentials="dIxD2TC9UVNVjp2ZPP5OavBrgHKymDaqMBS3cmzLyN8zyB/x73GRgV+Ddow9YPlOKLKhcaJ80IcX6Fwh0ENGUJ8C5AefcqYNt8fh7VLG2ubz4BzXKyF0Qt7ZPQI0nlcFyD/yJySuAg4SpOXfirWR5dUTW4ESYAuCD/VvF2EUiD9s0NRGbOQ3Vl9GWYlU+D56nJhovNVTfDAa2JtO9x1DicJ7MzcGYCuwaXffRi4IbwCyadE+l8KiqauKs3GkQQGgF1d8DJp8Fhh+xThaBryVWPSQevPFMpK8F66VcU/dxX81wdb84xg0H/M/Cd5uaone9XvL/cBllWyEAjUtNGj7sQ==";
  ///////////////////////////////////////////////
  static String bseImageUrl = 'assets/images/';
  static String splashBg = bseImageUrl + "background.png";
  static String logo = bseImageUrl + "Best_candidate.png";
  static String success = bseImageUrl + "success.jpg";
  static String cartEmpty = bseImageUrl + "cart_empty.png";
  static String internet = bseImageUrl + "internet.jpg";


  ////////////////////////////////////////////
  static String bseIconUrl = 'assets/icons/';
  static String paypal= bseIconUrl + "paypal_logo.jpg";
  static String mpesa= bseIconUrl + "mpsea_logo.png";


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