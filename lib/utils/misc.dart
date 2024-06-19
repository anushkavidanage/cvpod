import 'package:cvpod/utils/cv_managet.dart';
import 'package:intl/intl.dart';

/// Common functions used in the app
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

/// Capitalise the first letter of a string
String capitalize(String word) {
  return "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
}

/// Get the profile name from the webId
String getNameFromWebId(String webId) {
  String name = webId.split('/').reversed.elementAt(2);
  List nameList = name.split('-');

  List capNameList = [];
  for (final subName in nameList) {
    String capName = capitalize(subName);
    capNameList.add(capName);
  }

  return capNameList.join(' ');
}

String getDateStr() {
  return DateFormat('yyyyMMdd').format(DateTime.now());
}

String getDateTimeStr() {
  return DateFormat('yyyyMMddTHHmmss').format(DateTime.now());
}

bool checkVarValidity(String varStr) {
  if (varStr.isNotEmpty && varStr != ' ') {
    return true;
  } else {
    return false;
  }
}

double calcProfComplete(Map dataMap) {
  int nonEmptyVar = 0;

  for (String dataVal in dataMap.values) {
    if (dataVal.isNotEmpty && dataVal != ' ') {
      nonEmptyVar += 1;
    }
  }

  return (100.0 * nonEmptyVar / dataMap.length);
}

bool checkCvEmpty(CvManager cvManager) {
  bool allEmpty = true;

  if (cvManager.getAbout.isNotEmpty) {
    allEmpty = false;
  }
  if (cvManager.getSummary['summary'].isNotEmpty) {
    allEmpty = false;
  }
  if (cvManager.getProfessional.isNotEmpty) {
    allEmpty = false;
  }
  if (cvManager.getEducation.isNotEmpty) {
    allEmpty = false;
  }
  if (cvManager.getResearch.isNotEmpty) {
    allEmpty = false;
  }
  if (cvManager.getPublications.isNotEmpty) {
    allEmpty = false;
  }
  if (cvManager.getAwards.isNotEmpty) {
    allEmpty = false;
  }
  if (cvManager.getPresentations.isNotEmpty) {
    allEmpty = false;
  }
  if (cvManager.getExtra.isNotEmpty) {
    allEmpty = false;
  }
  if (cvManager.getReferees.isNotEmpty) {
    allEmpty = false;
  }

  return allEmpty;
}
