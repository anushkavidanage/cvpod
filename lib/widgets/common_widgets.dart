import 'package:flutter/material.dart';

import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/utils/responsive.dart';

/// Build Error Card
Row buildErrCard(BuildContext context, IconData errIcon, Color errColour,
    String errTitle, String errBody) {
  return Row(children: [
    Expanded(
      flex: Responsive.isDesktop(context) ? 10 : 8,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(60, 50, 60, 0),
        child: Card(
          elevation: 10,
          shadowColor: Colors.black,
          color: appLightGrey2,
          child: SizedBox(
            height: 180,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      errIcon,
                      color: errColour,
                      size: 55,
                    ),
                    alignment: Alignment.center,
                  ), //CircleAvatar
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  Text(
                    errTitle,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  Text(
                    errBody,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ), //Textstyle
                  ), //SizedBox
                ],
              ), //Column
            ), //Padding
          ), //SizedBox
        ),
      ),
    ),
  ]);
}

/// Build message box
/// av:2024.06.06 - Following function is too complicated for now
/// Therefore commented out
// Container buildMsgBox(
//     BuildContext context, String msgType, String title, String msg) {
//   /// if you want to use this in materialBanner
//   bool isRTL = false;

//   final size = MediaQuery.of(context).size;

//   final loc = Localizations.maybeLocaleOf(context);
//   final localeLanguageCode = loc?.languageCode;

//   if (localeLanguageCode != null) {
//     for (var code in Languages.codes) {
//       if (localeLanguageCode.toLowerCase() == code.toLowerCase()) {
//         isRTL = true;
//       }
//     }
//   }
//   // screen dimensions
//   bool isMobile = size.width <= 730;
//   bool isTablet = size.width > 730 && size.width <= 1050;
//   //bool isDesktop = size.width >= 1050;

//   /// for reflecting different color shades in the SnackBar
//   final hsl = HSLColor.fromColor(getContentColour(msgType));
//   final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

//   double horizontalPadding = 0.0;
//   double leftSpace = size.width * 0.12;
//   double rightSpace = size.width * 0.12;

//   if (isMobile) {
//     horizontalPadding = size.width * 0.01;
//   } else if (isTablet) {
//     leftSpace = size.width * 0.05;
//     horizontalPadding = size.width * 0.03;
//   } else {
//     leftSpace = size.width * 0.05;
//     horizontalPadding = size.width * 0.04;
//   }

//   return Container(
//     margin: EdgeInsets.symmetric(
//       horizontal: horizontalPadding,
//     ),
//     height: !isMobile
//         ? !isTablet
//             ? size.height * (1500.0 / size.width) * getWidgetHeight(msg)
//             : size.height * (1000.0 / size.width) * getWidgetHeight(msg)
//         : size.height * (650.0 / size.width) * getWidgetHeight(msg),
//     child: Stack(
//       clipBehavior: Clip.none,
//       alignment: Alignment.topCenter,
//       children: [
//         // background container
//         Container(
//           width: size.width,
//           decoration: BoxDecoration(
//             color: getContentColour(msgType),
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),

//         /// SVGs in body
//         Positioned(
//           bottom: 0,
//           left: 0,
//           child: ClipRRect(
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//             ),
//             child: SvgPicture.asset(
//               AssetsPath.bubbles,
//               height: size.height * 0.06,
//               width: size.width * 0.05,
//               colorFilter: ColorFilter.mode(hslDark.toColor(), BlendMode.srcIn),
//             ),
//           ),
//         ),

//         Positioned(
//           top: -size.height * 0.02,
//           left: !isRTL
//               ? leftSpace - (isMobile ? size.width * 0.075 : size.width * 0.035)
//               : null,
//           right: isRTL
//               ? rightSpace -
//                   (isMobile ? size.width * 0.075 : size.width * 0.035)
//               : null,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               SvgPicture.asset(
//                 AssetsPath.back,
//                 height: size.height * 0.06,
//                 colorFilter:
//                     ColorFilter.mode(hslDark.toColor(), BlendMode.srcIn),
//               ),
//               Positioned(
//                 top: size.height * 0.015,
//                 child: Icon(msgIcon(msgType), color: Colors.white),
//                 //     SvgPicture.asset(
//                 //   assetSVG(msgType),
//                 //   height: size.height * 0.022,
//                 // ),
//               )
//             ],
//           ),
//         ),

//         /// content
//         Positioned.fill(
//           left: isRTL ? size.width * 0.03 : leftSpace,
//           right: isRTL ? rightSpace : size.width * 0.03,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: size.height * 0.02,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   /// `title` parameter
//                   Expanded(
//                     flex: 3,
//                     child: Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: !isMobile
//                             ? size.height * 0.03
//                             : size.height * 0.025,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: size.height * 0.005,
//               ),

//               /// `message` body text parameter
//               Expanded(
//                 child: Text(
//                   msg,
//                   softWrap: true,
//                   style: TextStyle(
//                     fontSize: size.height * 0.016,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: size.height * 0.015,
//               ),
//             ],
//           ),
//         )
//       ],
//     ),
//   );
// }