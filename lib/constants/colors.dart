/// Colors used in the app.
///
/// Copyright (C) 2024 Software Innovation Institute, Australian National University
///
/// License: GNU General Public License, Version 3 (the "License")
/// https://www.gnu.org/licenses/gpl-3.0.en.html
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later
// version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
// details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <https://www.gnu.org/licenses/>.
///
/// Authors: Anushka Vidanage

library;

import 'package:flutter/material.dart';

/// Light color for card background.
const bgCardLight = Color(0xFFEEEEEE);

/// Color for card border.
const cardBorder = Color(0xFFd9d9d9);

const topCardNotSelect = Color(0xFFe6e6e6);

const topCardSelect = Color(0xFFcccccc);

const topCardIcon = Color(0xFF595959);

const appLightBlue1 = Color(0xFFb7e4f8);

const appLightBlue2 = Color(0xFF6fc8f1);

const appMidBlue1 = Color(0xFF64acce);

const appMidBlue2 = Color(0xFF388cb2);

const appDarkBlue1 = Color(0xFF265d77);

const appDarkBlue2 = Color(0xFF132f3b);

const appLightGrey = Color.fromARGB(255, 190, 190, 190);

const appLightGrey2 = Color.fromARGB(255, 221, 221, 221);

const backgroundWhite = Color(0xFFF5F6FC);

const infoRed = Color(0xFFd6473a);

const darkAsh = Color(0xFF30384D);

/// Color for Anu Brick Red.
const anuBrickRed = Color(0xFFD89E7A);

/// Color for Anu Copper.
const anuCopper = Color(0xFFBE4E0E);

/// Color for Anu Gold.
const anuGold = Color(0xFFBE830E);

/// Color for icon red.
const iconRed = Color.fromARGB(255, 214, 14, 14);

/// Color for icon green.
const iconGreen = Colors.green;

/// Color for Anu Light Gold.
const anuLightGold = Color(0xFFDBBA78);

/// Color for autumn brown.
const autumnBrown = Color(0xFFb65d22);

/// Color for Android light brown.
const androidLightBrown = Color.fromARGB(255, 241, 215, 159);

/// Choice of the first bar colour in the "My Mob" two bar plots - typically
/// Male/Female. Originally they were blue and red but red stands out too
/// much. So we softenned them to more pastel type colours. Chosing orange for
/// the first bar. The second bar is [barColour2]. See the
/// [Colors](https://api.flutter.dev/flutter/material/Colors-class.html) class
/// for choice of colours. **20230705 gjw**
const barColour1 = Colors.orange;

/// Choice of the second bar colour in the "My Mob" two bar plots - typically
/// Male/Female. See [barColour1] for the first bar colour. Chosing deep purple
/// with a shade of 200 for this second bar. **20230705 gjw**
const barColour2 = Color(0xFFB39DDB);

/// Color for the bottom border side.
const bottomBorderSideColor1 = Color(0xff4e4964);

/// Color used to indicate confirmation or success.
const confirmGreen = Colors.green;

/// Default color for line 1.
const defaultLineColor1 = Colors.white;

/// Default color for line 2.
const defaultLineColor2 = Colors.white;

/// Background color in dark mode.
const kBgDarkColor = Color(0xFFD8ECF3);

/// Background color in light mode.
const kBgLightColor = Color(0xFFF2F4FC);

/// Gray color.
const kGrayColor = Color(0xFF8793B2);

/// Primary color.
const kPrimaryColor = Color(0xFFDBBA78);

/// Secondary color.
const kSecondaryColor = Color(0xFFF5F6FC);

/// Title text color.
const kTitleTextColor = Color(0xFF30384D);

/// Text color for left-aligned titles.
const leftTitleTextColor1 = Colors.black;

/// Light gold color.
const lightGold = Color(0xffF5EDDE);

/// Color of high plot band.
const plotHighBandColor = Color.fromARGB(255, 230, 73, 73);

/// Color of low plot band.
const plotLowBandColor = Color.fromARGB(255, 159, 230, 73);

/// Color for the clickable tiles when the tile is tabbed.
const triggeredClickableTileColor = Color.fromARGB(255, 240, 226, 198);

/// The color for the version text gold.
const versionTextGold = Color.fromARGB(255, 240, 226, 198);

/// The color red used for warning messages.
const warningRed = Colors.red;

/// Color of grey out icon
Color iconGreyOutColor = Colors.grey[400]!;

/// Color for the text in the strip.
Color stripTextColor = Colors.grey[600]!;

/// Color for the tooltip background.
Color toolTipBgColor1 = Colors.blueGrey.withOpacity(0.8);
