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
import 'package:rdflib/rdflib.dart';

import 'package:cvpod/constants/schema.dart';
import 'package:cvpod/utils/rdf.dart';

const solidServerUrl = 'https://pods.solidcommunity.au/';

const String applicationName = 'CVPod';
const String applicationVersion = '0.1.0';
const String applicationRepo = 'https://github.com/anushkavidanage/cvpod';
const String siiUrl = 'https://sii.anu.edu.au';

const String authors = 'Authors: Anushka Vidanage';

const smallPadding = 10.0;
const largePadding = 40.0;
const double normalLoadingScreenHeight = 200.0;
const double buttonBorderRadius = 5;
const double standardSpace = 20.0;

// Height gap widgets
const smallHeightGap = SizedBox(height: smallPadding);
const largeHeightGap = SizedBox(height: largePadding);

// Width gap widgets
const smallWidthGap = SizedBox(width: smallPadding);
const largeWidthGap = SizedBox(width: largePadding);

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

/// Data types for CV Pod
enum DataType {
  summary('summary', Icons.summarize_outlined, 0, parseSummary),

  about('about', Icons.person_outlined, 1, parseAbout),

  education('education', Icons.school_outlined, 2, parseEducation),

  professional(
      'professional', Icons.work_outline_outlined, 3, parseProfessional),

  research('research', Icons.stacked_line_chart_sharp, 4, parseResearch),

  publication('publication', Icons.verified_outlined, 5, parsePublications),

  award('award', Icons.emoji_events_outlined, 6, parseAwards),

  presentation('presentation', Icons.bar_chart_outlined, 7, parsePresentations),

  extra('extra', Icons.front_hand_outlined, 8, parseExtra),

  referee('referee', Icons.person_search_outlined, 9, parseReferees),

  portrait('portrait', Icons.person, 10, parseReferees);

  /// Generative enum constructor
  const DataType(this.value, this.icon, this.tab, this.dataParser);

  /// String label of data type
  final String value;

  /// Icon of the data type
  final IconData icon;

  /// Tab number for the data type
  final int tab;

  /// Data parse function
  final Function dataParser;

  /// Return the file name for the data type in POD
  String get ttlFile => 'cv-$value.ttl';

  /// Return profile portrait file
  String get portaitFile => 'cv-$value.jpeg';

  /// Return portrait file path
  String get portaitFilePath => 'cvpod/data/$portaitFile';

  /// Return the file path for the data type in POD
  String get ttlFilePath => 'cvpod/data/$ttlFile';
}

String profPicPath = 'cvpod/data/pro-pic.jpeg';

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
  DataType.referee,
  DataType.portrait,
];

const cvSelectList = [
  DataType.summary,
  DataType.education,
  DataType.professional,
  DataType.research,
  DataType.publication,
  DataType.award,
  DataType.presentation,
  DataType.extra,
  DataType.referee,
  DataType.portrait,
];

/// Time data literals for CV Pod
enum TimeLiteral {
  createdTime('createdTime'),

  updatedTime('updatedTime');

  /// Generative enum constructor
  const TimeLiteral(this.value);

  /// String label of data type
  final String value;

  /// Return the URIRef of literal predicate
  URIRef get uriRef => URIRef('$cvData$value');
}

/// HTTP request type
enum HttpRequest {
  get('get'),

  post('post'),

  put('put'),

  patch('patch');

  /// Generative enum constructor
  const HttpRequest(this.value);

  /// String label of request type
  final String value;
}

/// Types of the content of resources
enum ResourceContentType {
  /// TTL text file
  turtleText('text/turtle'),

  /// Plain text file
  plainText('text/plain'),

  /// Directory
  directory('application/octet-stream'),

  /// Binary data
  binary('application/octet-stream'),

  /// Sparql update
  sparql('application/sparql-update'),

  image('image/jpeg'),

  /// Any
  any('*/*');

  /// Constructor
  const ResourceContentType(this.value);

  /// String value of the access type
  final String value;
}

/// Random
Random random = Random(2356874);

/// Loading sample data flag
bool loadSampleData = false;
