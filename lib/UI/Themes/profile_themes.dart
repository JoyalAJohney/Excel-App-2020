import 'package:flutter/material.dart';
import '../constants.dart';

class ProfileTheme {
  static var bgColor = Colors.grey[200];
  static double imageHeight = 160;
  static var headingStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 22.0,
    color: primaryColor,
  );
  static var nameStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20.0,
    color: primaryColor,
  );
  static var buttonTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
  static var detailsTextStyle = TextStyle(
    color: primaryColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}
