import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  static const double currentWidth = 430;

  static const double minWidth = 320;
  static const double maxWidth = 768;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height -
        _mediaQueryData!.padding.bottom -
        _mediaQueryData!.padding.top;
    orientation = _mediaQueryData!.orientation;
  }
}

// ignore: non_constant_identifier_names
double responsive_size(double current_val, {bool asMaxSize = false}) {
  // ignore: non_constant_identifier_names
  double min_val =
      ((current_val * SizeConfig.minWidth) / SizeConfig.currentWidth);
  // ignore: non_constant_identifier_names
  double max_val =
      ((current_val * SizeConfig.maxWidth) / SizeConfig.currentWidth);

  double v = (min_val +
      (max_val - min_val) *
          ((SizeConfig.screenWidth! - SizeConfig.minWidth) /
              (SizeConfig.maxWidth - SizeConfig.minWidth)));
  if (asMaxSize) {
    if (v > current_val) {
      return current_val;
    }
  }
  return v;
}

// ignore: non_constant_identifier_names
double? height_container_intro() {
  if (SizeConfig.screenHeight! < SizeConfig.screenWidth!) {
    return SizeConfig.screenWidth;
  }
  return SizeConfig.screenHeight;
}


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:minutes_1440_app/size_config.dart';

// import 'colors.dart';
// import "package:minutes_1440_app/globals.dart" as globals;

// ThemeData lightThemeDataApp = ThemeData.light().copyWith(
//   textTheme: GoogleFonts.interTextTheme(),
//   primaryColor: CustomColors.primaryColor,
//   scaffoldBackgroundColor: CustomColors.secondaryColor,
// );

// double s5 = 5;
// double s4 = 4;
// double s2 = 2;

// double s8 = 8;
// double s10 = 10;
// double s10f = 10;
// double s12 = 12;
// double s13 = 13;

// double s14 = 14;
// double s15 = 15;

// double s16 = 16;
// double s18 = 18;
// double s17 = 17;
// double s20 = 20;
// double s22 = 22;

// double s24 = 24;
// double s25 = 25;

// double s26 = 26;

// double s27 = 27;
// double s28 = 28;

// double s30 = 30;
// double s32 = 32;

// double s38 = 38;
// double s40 = 40;
// double s42 = 42;
// double s45 = 42;

// double s50 = 50;
// double s51 = 50;

// double s60 = 60;
// double s60f = 60;

// double s64 = 64;
// double s65 = 65;

// double s70 = 70;
// double s70f = 70;

// double s72 = 72;
// double s78 = 78;
// double s78f = 78;

// double s80 = 80;
// double s85 = 85;
// double s90 = 90;
// double s98 = 98;

// double s120 = 120;
// double s160 = 160;
// double s160f = 160;

// double s175 = 175;

// double s177 = 177;
// double s185 = 185;
// double s185f = 185;

// double s195 = 195;
// double s195f = 195;

// double s201 = 330;
// double s303 = 303;

// double s330 = 330;
// double s330f = 330;

// double s335 = 335;

// double s338 = 338;
// double s338f = 338;

// double s340 = 340;
// double s350 = 350;
// double s350f = 350;

// double s358 = 358;
// double s358f = 358;

// double s390 = 390;
// double s390f = 390;

// double s430f = 430;

// double s666 = 666;

// double s340f = 340;

// /** For Border Radius */
// double r10 = 10;
// double r8 = 8;
// double r4 = 4;
// double r6 = 6;

// /** Box Decorations */
// BoxDecoration taskBoxDecoration = BoxDecoration(
//   border: Border.all(color: CustomColors.borderColor, width: 1),
//   borderRadius: BorderRadius.circular(r8),
// );

// BoxDecoration containerBoxDecoration = BoxDecoration(
//   border: Border.all(color: CustomColors.borderColor, width: 1),
//   borderRadius: BorderRadius.circular(r8),
// );

// TextStyle textStyleBase = const TextStyle(
//   color: CustomColors.secondaryColor,
// );
// TextStyle textStyleDanger = const TextStyle(
//   color: CustomColors.dangerColor,
// );
// TextStyle titleLargeStyle = textStyleBase.copyWith(
//   fontSize: 20,
//   fontWeight: FontWeight.bold,
// );
// TextStyle titleMediumStyle = textStyleBase.copyWith(
//   fontSize: 16,
//   fontWeight: FontWeight.bold,
// );
// TextStyle titleSmallStyle = textStyleBase.copyWith(
//   fontSize: 12,
//   fontWeight: FontWeight.bold,
// );

// TextStyle headlineSmallStyle = textStyleBase.copyWith(
//   fontSize: 10,
//   fontWeight: FontWeight.w700,
// );

// TextStyle textStyleSecondary = const TextStyle(
//     color: CustomColors.secondaryColor,
//     decorationColor: CustomColors.secondaryColor);

// TextStyle textStyleTwo = const TextStyle(
//     color: CustomColors.colorb5, decorationColor: CustomColors.colorb5);

// TextStyle textStyleThree = const TextStyle(
//     color: CustomColors.color72, decorationColor: CustomColors.color72);
// TextStyle textStyleFour = const TextStyle(
//     color: CustomColors.color0000, decorationColor: CustomColors.color0000);
// TextStyle textStyleFive = const TextStyle(
//     color: CustomColors.greyColor, decorationColor: CustomColors.greyColor);
// TextStyle textStyleSix = const TextStyle(
//     color: CustomColors.colord9, decorationColor: CustomColors.colord9);
// TextStyle textStyleSeven = const TextStyle(
//     color: CustomColors.color5E, decorationColor: CustomColors.color5E);
// TextStyle textStyleEight = const TextStyle(
//     color: CustomColors.color7B, decorationColor: CustomColors.color7B);
// TextStyle textStyleNine = const TextStyle(
//     color: CustomColors.color7B, decorationColor: CustomColors.color7B);
// TextStyle textStyleten = const TextStyle(
//     color: CustomColors.colorEF, decorationColor: CustomColors.colorEF);
// TextStyle textStyleEleven = const TextStyle(
//     color: CustomColors.colorC4, decorationColor: CustomColors.colorC4);

// TextStyle textStyleSize10 = const TextStyle(fontSize: 10);
// TextStyle textStyleSize10W400 =
//     textStyleSize10.copyWith(fontWeight: FontWeight.w400);

// /** Font Sized 12 */
// TextStyle textStyleSize12 = const TextStyle(fontSize: 12);
// TextStyle textStyleSize12W400 =
//     textStyleSize12.copyWith(fontWeight: FontWeight.w400);
// TextStyle textStyleSize12W500 =
//     textStyleSize12.copyWith(fontWeight: FontWeight.w500);
// TextStyle textStyleSize12W600 =
//     textStyleSize12.copyWith(fontWeight: FontWeight.w600);
// /** Font Sized 14 */
// TextStyle textStyleSize14 = const TextStyle(fontSize: 14);
// TextStyle textStyleSize14W500 =
//     textStyleSize14.copyWith(fontWeight: FontWeight.w500);
// TextStyle textStyleSize14W400 =
//     textStyleSize14.copyWith(fontWeight: FontWeight.w400);

// /** Font Sized 16 */
// TextStyle textStyleSize16 = const TextStyle(fontSize: 16);
// TextStyle textStyleSize18 = const TextStyle(fontSize: 18);
// TextStyle textStyleSize18W500 =
//     textStyleSize18.copyWith(fontWeight: FontWeight.w500);

// TextStyle textStyleSize16W400 =
//     textStyleSize16.copyWith(fontWeight: FontWeight.w400);
// TextStyle textStyleSize16W500 =
//     textStyleSize16.copyWith(fontWeight: FontWeight.w500);

// TextStyle textStyleSize16W600 =
//     textStyleSize16.copyWith(fontWeight: FontWeight.w600);

// TextStyle textStyleSize16W700 =
//     textStyleSize16.copyWith(fontWeight: FontWeight.w700);
// /** Font Sized 20 */
// TextStyle textStyleSize20 = const TextStyle(fontSize: 20);
// TextStyle textStyleSize20W500 =
//     textStyleSize20.copyWith(fontWeight: FontWeight.w500);

// TextStyle textStyleSize20W600 =
//     textStyleSize20.copyWith(fontWeight: FontWeight.w600);
// /** Font Sized 24 */
// TextStyle textStyleSize24 = const TextStyle(fontSize: 24);
// TextStyle textStyleSize26 = const TextStyle(fontSize: 26);
// TextStyle textStyleSize26W500 =
//     textStyleSize26.copyWith(fontWeight: FontWeight.w500);

// TextStyle textStyleSize24W600 =
//     textStyleSize24.copyWith(fontWeight: FontWeight.w600);
// TextStyle textStyleSize24W700 =
//     textStyleSize24.copyWith(fontWeight: FontWeight.w700);
// TextStyle textStyleSize32 = const TextStyle(fontSize: 32);
// TextStyle textStyleSize32w700 =
//     textStyleSize32.copyWith(fontWeight: FontWeight.w700);

// TextStyle textStyleSize36 = const TextStyle(fontSize: 36);
// TextStyle textStyleSize36w700 =
//     textStyleSize36.copyWith(fontWeight: FontWeight.w700);

// TextStyle textStyleSize17 = const TextStyle(fontSize: 17);

// TextStyle textStyleSize17w400 =
//     textStyleSize17.copyWith(fontWeight: FontWeight.w400);

// TextStyle textStyleSize16w400 =
//     textStyleSize16.copyWith(fontWeight: FontWeight.w400);

// /** Gradinent Title Text Style */
// TextStyle gradientAnimationTextStyle = TextStyle(
//   fontSize: 40,
//   height: 1,
//   fontWeight: FontWeight.w600,
// );

// TextStyle gradientAnimationTextStyle2 = TextStyle(
//   fontSize: 24,
//   height: 1,
//   fontWeight: FontWeight.w600,
// );

// List<Color> gradientAnimationTextListColors = [
//   CustomColors.gradient1,
//   CustomColors.gradient2,
//   CustomColors.secondaryColor,
// ];

// /** Input Border */
// InputBorder inputBorder = OutlineInputBorder(
//   borderSide: BorderSide(color: CustomColors.color2d, width: 0),
//   borderRadius: BorderRadius.circular(r10),
// );
// InputBorder inputBorderDanger = OutlineInputBorder(
//   borderSide: const BorderSide(color: CustomColors.dangerColor, width: 1),
//   borderRadius: BorderRadius.circular(r10),
// );
// InputBorder inputBorderFocus = OutlineInputBorder(
//   borderSide: const BorderSide(color: CustomColors.secondaryColor, width: 1),
//   borderRadius: BorderRadius.circular(r10),
// );
// ButtonStyle elevatedButtonStyle1 = ElevatedButton.styleFrom(
//   backgroundColor: CustomColors.colorEEE,
//   foregroundColor: CustomColors.primaryColor,
//   surfaceTintColor: CustomColors.thirdColor,
//   fixedSize: const Size(390, 50),
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(r8),
//   ),
//   textStyle: TextStyle(
//     fontSize: s18,
//     fontWeight: FontWeight.w500,
//   ),
// );

// ButtonStyle elevatedButtonStyle2 = ElevatedButton.styleFrom(
//   backgroundColor: CustomColors.color18,
//   foregroundColor: CustomColors.secondaryColor,
//   surfaceTintColor: CustomColors.thirdColor,
//   fixedSize: const Size(338, 34),
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(r8),
//   ),
//   textStyle: const TextStyle(
//     fontSize: 17,
//     fontWeight: FontWeight.w400,
//   ),
// );

// ButtonStyle elevatedButtonStyle3 = elevatedButtonStyle2.copyWith(
//     fixedSize: MaterialStateProperty.all(const Size(390, 55)));

// ButtonStyle elevatedButtonStyle4 = elevatedButtonStyle1.copyWith(
//     fixedSize: MaterialStateProperty.all(const Size(390, 55)),
//     backgroundColor: MaterialStateProperty.all(CustomColors.secondaryColor),
//     elevation: MaterialStateProperty.all(0),
//     side: MaterialStateProperty.all(BorderSide(color: CustomColors.colord9)));

// ButtonStyle elevatedButtonStyle5 = ElevatedButton.styleFrom(
//   backgroundColor: CustomColors.colorEEE,
//   foregroundColor: CustomColors.primaryColor,
//   surfaceTintColor: CustomColors.thirdColor,
//   fixedSize: Size(s330, s50),
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(r8),
//   ),
//   textStyle: const TextStyle(
//     fontSize: 18,
//     fontWeight: FontWeight.w500,
//   ),
// );
// ButtonStyle elevatedButtonStyle6 = ElevatedButton.styleFrom(
//   backgroundColor: CustomColors.colorEEE,
//   foregroundColor: CustomColors.primaryColor,
//   surfaceTintColor: CustomColors.thirdColor,
//   fixedSize: Size(s50, 50),
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(r8),
//   ),
//   textStyle: const TextStyle(
//     fontSize: 18,
//     fontWeight: FontWeight.w500,
//   ),
// );

// ButtonStyle textButtonStyle1 = TextButton.styleFrom(
//   foregroundColor: CustomColors.secondaryColor,
//   textStyle: const TextStyle(
//     fontSize: 14,
//     fontWeight: FontWeight.w600,
//   ),
// );

// ButtonStyle textButtonStyle2 = TextButton.styleFrom(
//   foregroundColor: CustomColors.secondaryColor,
//   textStyle: const TextStyle(
//     fontSize: 17,
//     fontWeight: FontWeight.w400,
//   ),
// );

// TextStyle headingTexStyle = const TextStyle(
//   fontSize: 20,
//   fontWeight: FontWeight.w600,
// );

// ThemeData darkThemeDataApp = ThemeData.dark().copyWith(
//     textTheme: GoogleFonts.interTextTheme().copyWith(
//       titleLarge: titleLargeStyle,
//       titleMedium: titleMediumStyle,
//       titleSmall: titleSmallStyle,
//       headlineLarge: titleLargeStyle.copyWith(
//         fontSize: 24,
//         fontWeight: FontWeight.w700,
//       ),
//       headlineMedium: titleMediumStyle.copyWith(
//         color: CustomColors.greyColor,
//         fontWeight: FontWeight.w400,
//       ),
//       headlineSmall: headlineSmallStyle,
//     ),
//     primaryColor: CustomColors.primaryColor,
//     scaffoldBackgroundColor: CustomColors.primaryColor,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: CustomColors.primaryColor,
//       elevation: 0,
//       toolbarHeight: 54,
//       titleTextStyle: TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//     bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
//     splashFactory: NoSplash.splashFactory,
//     checkboxTheme: CheckboxThemeData(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(2),
//       ),
//       fillColor: MaterialStateProperty.resolveWith((states) {
//         if (states.contains(MaterialState.selected)) {
//           return CustomColors.successColor;
//         }
//         return CustomColors.primaryColor;
//       }),
//       checkColor: MaterialStateProperty.all(CustomColors.primaryColor),
//       side: BorderSide(width: 1, color: CustomColors.secondaryColor),
//     ));

// initThemeSizes() {
//   s8 = responsive_size(8, asMaxSize: true);
//   s2 = responsive_size(2, asMaxSize: true);

//   s10 = responsive_size(10, asMaxSize: true);
//   s12 = responsive_size(12, asMaxSize: true);
//   s13 = responsive_size(13, asMaxSize: true);

//   s16 = responsive_size(16, asMaxSize: true);
//   s14 = responsive_size(14, asMaxSize: true);
//   s15 = responsive_size(15, asMaxSize: true);

//   s17 = responsive_size(17, asMaxSize: true);
//   s18 = responsive_size(18, asMaxSize: true);
//   s20 = responsive_size(20, asMaxSize: true);
//   s22 = responsive_size(22, asMaxSize: true);

//   s24 = responsive_size(24, asMaxSize: true);
//   s25 = responsive_size(25, asMaxSize: true);

//   s26 = responsive_size(26, asMaxSize: true);

//   s27 = responsive_size(27, asMaxSize: true);
//   s28 = responsive_size(28, asMaxSize: true);

//   s32 = responsive_size(32, asMaxSize: true);

//   s38 = responsive_size(38, asMaxSize: true);
//   s40 = responsive_size(40, asMaxSize: true);
//   s42 = responsive_size(42, asMaxSize: true);
//   s45 = responsive_size(45, asMaxSize: true);

//   s30 = responsive_size(30, asMaxSize: true);
//   s50 = responsive_size(50, asMaxSize: true);
//   s60 = responsive_size(60, asMaxSize: true);
//   s60f = responsive_size(60, asMaxSize: false);

//   s64 = responsive_size(64, asMaxSize: true);
//   s65 = responsive_size(65, asMaxSize: true);
//   s70 = responsive_size(70, asMaxSize: true);
//   s70f = responsive_size(70, asMaxSize: false);

//   s72 = responsive_size(72, asMaxSize: true);
//   s78 = responsive_size(78, asMaxSize: true);
//   s78f = responsive_size(78, asMaxSize: false);

//   s80 = responsive_size(80, asMaxSize: true);
//   s85 = responsive_size(85, asMaxSize: true);
//   s90 = responsive_size(90, asMaxSize: true);
//   s98 = responsive_size(98, asMaxSize: true);

//   s120 = responsive_size(120, asMaxSize: true);
//   s160 = responsive_size(160, asMaxSize: true);
//   s160f = responsive_size(160, asMaxSize: false);

//   s175 = responsive_size(175, asMaxSize: true);

//   s177 = responsive_size(177, asMaxSize: true);
//   s185 = responsive_size(185, asMaxSize: true);
//   s185f = responsive_size(185, asMaxSize: false);

//   s195 = responsive_size(195, asMaxSize: true);
//   s195f = responsive_size(195, asMaxSize: false);

//   s330 = responsive_size(330, asMaxSize: true);

//   s330 = responsive_size(330, asMaxSize: true);
//   s330f = responsive_size(330, asMaxSize: false);

//   s335 = responsive_size(335, asMaxSize: true);

//   s338 = responsive_size(338, asMaxSize: true);
//   s338f = responsive_size(338, asMaxSize: false);

//   s340 = responsive_size(340, asMaxSize: true);
//   s350 = responsive_size(350, asMaxSize: true);
//   s350f = responsive_size(350, asMaxSize: false);

//   s358 = responsive_size(358, asMaxSize: true);
//   s358f = responsive_size(358, asMaxSize: false);

//   s390 = responsive_size(390, asMaxSize: true);
//   s390f = responsive_size(390, asMaxSize: false);

//   s201 = responsive_size(201, asMaxSize: true);

//   s340f = responsive_size(340, asMaxSize: false);
//   s430f = responsive_size(430, asMaxSize: false);

//   s666 = responsive_size(666, asMaxSize: false);
// }