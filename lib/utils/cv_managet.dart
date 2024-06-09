/// Utilities for managing cv data.
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
import 'package:intl/intl.dart';

class CvManager {
  /// Summary of the user
  static String _summary = '';

  /// Personal details
  static Map _bioData = {};

  /// Professional qualifications
  static final Map _professionalData = {};

  /// Educational qualifications
  static final Map _educationData = {};

  /// Research data
  static final Map _researchData = {};

  /// Publications - citations and year
  static final Map _publicationsData = {};

  /// Awards
  static final Map _awardsData = {};

  /// Presentations
  static final Map _presentationsData = {};

  /// Volunteering / Involvement activities
  static final Map _extraData = {};

  /// Referee details
  static final Map _refereeData = {};

  /// Last updated date
  String updatedDateStr = '';

  /// Define getters
  String get getSummary {
    return _summary;
  }

  Map get getBio {
    return _bioData;
  }

  Map get getEducation {
    return _educationData;
  }

  Map get getProfessional {
    return _professionalData;
  }

  Map get getResearch {
    return _researchData;
  }

  Map get getPublications {
    return _publicationsData;
  }

  Map get getAwards {
    return _awardsData;
  }

  Map get getPresentations {
    return _presentationsData;
  }

  Map get getExtra {
    return _extraData;
  }

  Map get getReferees {
    return _refereeData;
  }

  /// Set data values
  void setCvData(String dataType, Map valDetails) {
    switch (dataType) {
      case 'summary':
        _summary = valDetails['summary'];
        break;

      case 'bio':
        _bioData = valDetails;
        break;

      case 'education':
        if (_educationData.isEmpty) {
          _educationData[1] = valDetails;
        } else {
          _educationData[(_educationData.length + 1)] = valDetails;
        }
        break;

      case 'professional':
        if (_professionalData.isEmpty) {
          _professionalData[1] = valDetails;
        } else {
          _professionalData[(_professionalData.length + 1)] = valDetails;
        }
        break;

      case 'research':
        if (_researchData.isEmpty) {
          _researchData[1] = valDetails;
        } else {
          _researchData[(_researchData.length + 1)] = valDetails;
        }
        break;

      case 'publications':
        if (_publicationsData.isEmpty) {
          _publicationsData[1] = valDetails;
        } else {
          _publicationsData[(_publicationsData.length + 1)] = valDetails;
        }
        break;

      case 'presentations':
        if (_presentationsData.isEmpty) {
          _presentationsData[1] = valDetails;
        } else {
          _presentationsData[(_presentationsData.length + 1)] = valDetails;
        }
        break;

      case 'awards':
        if (_awardsData.isEmpty) {
          _awardsData[1] = valDetails;
        } else {
          _awardsData[(_awardsData.length + 1)] = valDetails;
        }
        break;

      case 'extra':
        if (_extraData.isEmpty) {
          _extraData[1] = valDetails;
        } else {
          _extraData[(_extraData.length + 1)] = valDetails;
        }
        break;

      case 'referees':
        if (_refereeData.isEmpty) {
          _refereeData[1] = valDetails;
        } else {
          _refereeData[(_refereeData.length + 1)] = valDetails;
        }
        break;

      default:
        {
          debugPrint('Cannot happen');
        }
        break;
    }
  }

  void updateCvData(Map cvDataMap) {
    for (String dataType in cvDataMap.keys) {
      String cvData = cvDataMap[dataType];

      if (cvData.isNotEmpty || cvData != '') {
        Map genDataMap = {};
        setCvData(dataType, genDataMap);
      }
    }
  }

  /// Update updated date string
  void updateDate() {
    updatedDateStr = DateFormat('yyyyMMdd').format(DateTime.now());
  }

  /// Check if the last updated date is one day ago or if it is empty
  bool checkUpdatedDateExpired() {
    if (updatedDateStr.isEmpty) {
      return true;
    } else {
      String nowDateStr = DateFormat('yyyyMMdd').format(DateTime.now());
      if (nowDateStr != updatedDateStr) {
        return true;
      } else {
        return false;
      }
    }
  }
}
