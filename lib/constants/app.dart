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

import 'package:cvpod/utils/rdf.dart';
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

// /// Data card icons
// Map cardIcons = {
//   DataType.education: ,
//   DataType.professional: ,
//   DataType.research: ,
//   DataType.publication: ,
//   DataType.award: ,
//   DataType.referee: ,
// };

// /// Data tab numbers
// Map tabNumbers = {
//   DataType.education: 2,
//   professionalStr: 3,
//   researchStr: 4,
//   publicationsStr: 5,
//   awardsStr: 6,
//   presentationsStr: 7,
//   extraStr: 8,
//   refereesStr: 9,
// };

/// Data types for CV Pod
enum DataType {
  summary('summary', Icons.summarize_outlined, 0, parseSummary),

  about('about', Icons.person_search_outlined, 1, parseAbout),

  education('education', Icons.school_outlined, 2, parseEducation),

  professional(
      'professional', Icons.work_outline_outlined, 3, parseProfessional),

  research('research', Icons.stacked_line_chart_sharp, 4, parseResearch),

  publication('publication', Icons.verified_outlined, 5, parsePublications),

  award('award', Icons.emoji_events, 6, parseAwards),

  presentation('presentation', Icons.bar_chart_outlined, 7, parsePresentations),

  extra('extra', Icons.highlight, 8, parseExtra),

  referee('referee', Icons.person_search, 9, parseReferees);

  /// Generative enum constructor
  const DataType(this._value, this._icon, this._tab, this._dataParser);

  /// String label of data type
  final String _value;

  /// Icon of the data type
  final IconData _icon;

  /// Tab number for the data type
  final int _tab;

  /// Data parse function
  final Function _dataParser;

  /// Return the string value of data type
  String get label => _value;

  /// Return the icon of the data type
  IconData get icon => _icon;

  /// Return the tab number for the data type
  int get tab => _tab;

  /// Reurn the data parse function
  Function get dataParser => _dataParser;

  /// Return the file name for the data type in POD
  String get ttlFile => 'cv-$_value.ttl';

  /// Return the file path for the data type in POD
  String get ttlFilePath => 'cvpod/data/$ttlFile';
}

const dataTypeList = [
  DataType.summary,
  DataType.about,
  DataType.education,
  DataType.professional,
  DataType.research,
  DataType.publication,
  DataType.award,
  DataType.presentation,
  DataType.extra,
  DataType.referee
];

/// Random
Random random = Random(2356874);

/// Loading sample data flag
bool loadSampleData = false;
