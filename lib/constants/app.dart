/// App-wide constants.
///
/// Copyright (C) 2024, Software Innovation Institute
///
/// Licensed under the GNU General Public License, Version 3 (the "License");
///
/// License: https://www.gnu.org/licenses/gpl-3.0.en.html
//
// Time-stamp: <Wednesday 2023-11-01 08:26:39 +1100 Graham Williams>
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

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const solidServerUrl = 'https://pods.solidcommunity.au/';

const String applicationName = 'CVPod';
const String applicationVersion = '0.1.0';
const String applicationRepo = 'https://github.com/anushkavidanage/cvpod';
const String siiUrl = 'https://sii.anu.edu.au';

const String authors = 'Authors: Anushka Vidanage';

const kDefaultPadding = 20.0;
const double normalLoadingScreenHeight = 200.0;
const double buttonBorderRadius = 5;
const double standardSpace = 20.0;

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

/// Local secure storage instance.
FlutterSecureStorage secureStorage = const FlutterSecureStorage();

Map permMap = {1: 'Read', 2: 'Write', 3: 'Control'};

SizedBox standardHeight() {
  return const SizedBox(
    height: standardSpace / 2,
  );
}

const double desktopWidthThreshold = 960;

/// The threshold for small mobile width.
const double smallMobileWidthThreshold = 500;

Map cardIcons = {
  'edu': Icons.school_outlined,
  'prof': Icons.work_outline_outlined,
  'res': Icons.stacked_line_chart_sharp,
  'pub': Icons.verified_outlined,
  'award': Icons.emoji_events,
  'ref': Icons.person_search,
};

Map tabNumbers = {
  'edu': 2,
  'prof': 3,
  'res': 4,
  'pub': 5,
  'award': 6,
  'pres': 7,
  'extra': 8,
  'ref': 9,
};

/// Random
Random random = Random(2356874);

/// Loading sample data flag
bool loadSampleData = false;
