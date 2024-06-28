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

/// Different data types
const summaryStr = 'summary';
const aboutStr = 'about';
const educationStr = 'education';
const professionalStr = 'professional';
const researchStr = 'research';
const publicationsStr = 'publications';
const awardsStr = 'awards';
const presentationsStr = 'presentations';
const extraStr = 'extra';
const refereesStr = 'referees';

const dataTypeSelectList = [
  summaryStr,
  educationStr,
  professionalStr,
  researchStr,
  publicationsStr,
  awardsStr,
  presentationsStr,
  extraStr,
  refereesStr
];

/// Data card icons
Map cardIcons = {
  educationStr: Icons.school_outlined,
  professionalStr: Icons.work_outline_outlined,
  researchStr: Icons.stacked_line_chart_sharp,
  publicationsStr: Icons.verified_outlined,
  awardsStr: Icons.emoji_events,
  refereesStr: Icons.person_search,
};

/// Data tab numbers
Map tabNumbers = {
  educationStr: 2,
  professionalStr: 3,
  researchStr: 4,
  publicationsStr: 5,
  awardsStr: 6,
  presentationsStr: 7,
  extraStr: 8,
  refereesStr: 9,
};

/// Random
Random random = Random(2356874);

/// Loading sample data flag
bool loadSampleData = false;
