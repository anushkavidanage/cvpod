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

import 'package:cvpod/constants/app.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/utils/misc.dart';

class CvManager {
  /// Summary of the user
  static Map _summary = {};

  /// Personal details
  static Map _aboutData = {};

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
  Map get getSummary {
    return _summary.isNotEmpty ? _summary : {summaryStr: ''};
  }

  Map get getAbout {
    return _aboutData;
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
      case summaryStr:
        _summary = valDetails;
        break;

      case aboutStr:
        _aboutData = valDetails;
        break;

      case educationStr:
        for (String valId in valDetails.keys) {
          _educationData[valId] = valDetails[valId];
        }
        break;

      case professionalStr:
        for (String valId in valDetails.keys) {
          _professionalData[valId] = valDetails[valId];
        }
        break;

      case researchStr:
        for (String valId in valDetails.keys) {
          _researchData[valId] = valDetails[valId];
        }
        break;

      case publicationsStr:
        for (String valId in valDetails.keys) {
          _publicationsData[valId] = valDetails[valId];
        }
        break;

      case presentationsStr:
        for (String valId in valDetails.keys) {
          _presentationsData[valId] = valDetails[valId];
        }
        break;

      case awardsStr:
        for (String valId in valDetails.keys) {
          _awardsData[valId] = valDetails[valId];
        }
        break;

      case extraStr:
        for (String valId in valDetails.keys) {
          _extraData[valId] = valDetails[valId];
        }
        break;

      case refereesStr:
        for (String valId in valDetails.keys) {
          _refereeData[valId] = valDetails[valId];
        }
        break;

      default:
        {
          debugPrint('Cannot happen');
        }
        break;
    }
  }

  Map getCvData(String dataType) {
    Map funcMap = {
      summaryStr: getSummary,
      aboutStr: getAbout,
      educationStr: getEducation,
      professionalStr: getProfessional,
      researchStr: getResearch,
      publicationsStr: getPublications,
      awardsStr: getAwards,
      presentationsStr: getPresentations,
      extraStr: getExtra,
      refereesStr: getReferees,
    };

    return funcMap[dataType];
  }

  void updateCvData(Map cvDataMap) {
    for (String dataType in cvDataMap.keys) {
      final cvData = cvDataMap[dataType];

      if (cvData.isNotEmpty || cvData != '') {
        setCvData(dataType, cvData);
      }
    }
  }

  void deleteCvData(Map cvDataMap) {
    for (String dataType in cvDataMap.keys) {
      final cvData = cvDataMap[dataType];

      switch (dataType) {
        case educationStr:
          for (String valId in cvData.keys) {
            _educationData.remove(valId);
          }
          break;

        case professionalStr:
          for (String valId in cvData.keys) {
            _professionalData.remove(valId);
          }
          break;

        case researchStr:
          for (String valId in cvData.keys) {
            _researchData.remove(valId);
          }
          break;

        case publicationsStr:
          for (String valId in cvData.keys) {
            _publicationsData.remove(valId);
          }
          break;

        case presentationsStr:
          for (String valId in cvData.keys) {
            _presentationsData.remove(valId);
          }
          break;

        case awardsStr:
          for (String valId in cvData.keys) {
            _awardsData.remove(valId);
          }
          break;

        case extraStr:
          for (String valId in cvData.keys) {
            _extraData.remove(valId);
          }
          break;

        case refereesStr:
          for (String valId in cvData.keys) {
            _refereeData.remove(valId);
          }
          break;

        default:
          {
            debugPrint('Cannot happen');
          }
          break;
      }
    }
  }

  /// Update updated date string
  void updateDate() {
    updatedDateStr = getDateStr();
  }

  /// Check if the last updated date is one day ago or if it is empty
  bool checkUpdatedDateExpired() {
    if (updatedDateStr.isEmpty) {
      return true;
    } else {
      String nowDateStr = getDateStr();
      if (nowDateStr != updatedDateStr) {
        return true;
      } else {
        return false;
      }
    }
  }
}
