import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../design/Design.dart';


class CustomTheme {
  var baseTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: kPrimaryColor,
    primaryColor: kPrimaryColor,
    appBarTheme: AppBarTheme(
      toolbarHeight: SizerUtil.deviceType == DeviceType.tablet ? 9.h : 7.h,
      backgroundColor: kPrimaryColor,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: SizerUtil.deviceType == DeviceType.tablet ? 12.sp : 13.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 2.0,
      ),
      iconTheme: IconThemeData(
        color: kOtherColor,
        size: SizerUtil.deviceType == DeviceType.tablet ? 17.sp : 18.sp,
      ),
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
          fontSize: 11.sp, color: kTextLightColor, fontWeight: FontWeight.w400),
      hintStyle: TextStyle(fontSize: 16.0, color: kTextBlackColor, height: 0.5),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kTextLightColor, width: 0.7),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: kTextLightColor),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kTextLightColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: kPrimaryColor,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kErrorBorderColor, width: 1.2),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: kErrorBorderColor,
          width: 1.2,
        ),
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headline5: GoogleFonts.chewy(
        color: kTextWhiteColor,
        fontSize: SizerUtil.deviceType == DeviceType.tablet ? 45.sp : 40.sp,
      ),
      bodyText1: TextStyle(
          color: kTextWhiteColor, fontSize: 35.0, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(
        color: kTextWhiteColor,
        fontSize: 28.0,
      ),
      subtitle1: TextStyle(
          color: kTextWhiteColor,
          fontSize: SizerUtil.deviceType == DeviceType.tablet ? 14.sp : 17.sp,
          fontWeight: FontWeight.w700),
      subtitle2: GoogleFonts.poppins(
          color: kTextWhiteColor,
          fontSize: SizerUtil.deviceType == DeviceType.tablet ? 12.sp : 13.sp,
          fontWeight: FontWeight.w200),
      caption: GoogleFonts.poppins(
          color: kTextLightColor,
          fontSize: SizerUtil.deviceType == DeviceType.tablet ? 5.sp : 7.sp,
          fontWeight: FontWeight.w300),
    ),
  );
}
