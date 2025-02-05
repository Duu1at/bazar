import 'package:flutter/material.dart';

/// AppColors
/// This class contains all the colors used in the app
abstract class AppColors {
  /// Transparent figma style properties
  /// hex: #000000
  /// opacity: 0
  /// This is a transparent color
  static const Color transparent = Color(0x00000000);

  /// White figma style properties
  /// hex: #ffffff
  /// opacity: 1
  /// This is a white color
  static const Color white = Color(0xffffffff);

  /// whitesmoke figma style properties
  /// hex: #F3F3F3
  /// opacity: 1
  /// This is a whitesmoke color
  static const Color whitesmoke = Color(0xdee4e7e9);

  /// mediumseagreen figma style properties
  /// hex: #4AB65E
  /// opacity: 1
  /// This is a mediumseagreen color
  static const Color mediumseagreen = Color(0xff4AB65E);

  /// Black figma style properties
  /// hex: #000000
  /// opacity: 1
  /// This is a black color
  static const Color black = Color(0xff000000);

  /// Black2 figma style properties
  /// hex: #0E0E0F
  /// opacity: 1
  /// This is a black2 color
  static const Color black2 = Color(0x37474f4f);

  /// Black3 figma style properties
  /// hex: #1C1C1E
  /// opacity: 1
  /// This is a black3 color
  static const Color black3 = Color(0xff1C1C1E);

  /// Black4 figma style properties
  /// hex: #1D1D1D
  /// opacity: 1
  /// This is a black4 color
  static const Color black4 = Color(0xff1D1D1D);

  /// Black5 figma style properties
  /// hex: #222222
  /// opacity: 1
  /// This is a black5 color
  static const Color black5 = Color(0xff222222);

  /// darkslategray figma style properties
  /// hex: #2A2B30
  /// opacity: 1
  /// This is a darkslategray color
  static const Color darkslategray = Color(0xff2A2B30);

  /// darkslategray2 figma style properties
  /// hex: #373737
  /// opacity: 1
  /// This is a darkslategray2 color
  static const Color darkslategray2 = Color(0xff373737);

  /// slategray figma style properties
  /// hex: #6D7081
  /// opacity: 1
  /// This is a slategray color
  static const Color slategray = Color(0xff6D7081);

  /// darkgray figma style properties
  /// hex: #9FA1B5
  /// opacity: 1
  /// This is a darkgray color
  static const Color darkgray = Color(0xff9FA1B5);

  /// gainsboro figma style properties
  /// hex: #E3E3E3
  /// opacity: 1
  /// This is a gainsboro color
  static const Color gainsboro = Color(0xffE3E3E3);

  /// Papaya Whip figma style properties
  /// hex: #FFEED6
  /// opacity: 1
  /// This is a papayaWhip color
  static const Color papayaWhip = Color(0xffFFEED6);

  /// Whatsapp figma style properties
  /// hex: #25D366
  /// opacity: 1
  /// This is a whatsapp color
  static const Color whatsapp = Color(0xff25D366);

  /// Telegram figma style properties
  /// hex: #2BABEE
  /// opacity: 1
  /// This is a telegram color
  static const Color telegram = Color(0xff2BABEE);

  // static LinearGradient cardGradient(ThemeData theme, {bool isTomato = false, bool isBlue = false}) {
  //   final brightness = theme.brightness;
  //   if ((theme.colorScheme.primary == AppColors.tomato || isTomato) && isBlue == false) {
  //     return switch (brightness) {
  //       Brightness.light => const LinearGradient(
  //           colors: [
  //             Color(0xFFFCEBE6),
  //             Color(0xFFFFFDFD),
  //             Color(0xFFFCEBE6),
  //           ],
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //         ),
  //       Brightness.dark => const LinearGradient(
  //           colors: [
  //             Color(0xFF3C2D2B),
  //             Color(0xFF2B292A),
  //             Color(0xFF2B292A),
  //             Color(0xFF3C2D2B),
  //           ],
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //         ),
  //     };
  //   } else {
  //     return switch (brightness) {
  //       Brightness.light => const LinearGradient(
  //           colors: [
  //             Color(0xFFEAF5FE),
  //             Color(0xFFFDFEFF),
  //             Color(0xFFFDFEFF),
  //             Color(0xFFEAF5FE),
  //           ],
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //         ),
  //       Brightness.dark => const LinearGradient(
  //           colors: [
  //             Color(0xFF2D353D),
  //             Color(0xFF2A2A2C),
  //             Color(0xFF2A2A2C),
  //             Color(0xFF2D353D),
  //           ],
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //         ),
  //     };
  //   }
  // }
}
