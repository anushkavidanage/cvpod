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

// ignore_for_file: avoid_function_literals_in_foreach_calls

library;

import 'package:cvpod/utils/cvData/aboutItem.dart';
import 'package:cvpod/utils/cvData/summaryItem.dart';

import 'package:cvpod/utils/misc.dart';
import 'package:cvpod/constants/app.dart';
import 'package:cvpod/utils/cvData/educationItem.dart';
import 'package:cvpod/utils/cvData/awardItem.dart';
import 'package:cvpod/utils/cvData/extraItem.dart';
import 'package:cvpod/utils/cvData/presentationItem.dart';
import 'package:cvpod/utils/cvData/professionalItem.dart';
import 'package:cvpod/utils/cvData/publicationItem.dart';
import 'package:cvpod/utils/cvData/refereeItem.dart';
import 'package:cvpod/utils/cvData/researchItem.dart';
import 'package:flutter/services.dart';

class CvManager {
  /// Summary of the user
  static final Map _summary = {};

  /// Personal details
  static final Map _aboutData = {};

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

  /// Profile picture path
  Uint8List? portraitBytes;

  /// Last updated date
  String updatedDateStr = '';

  /// Define getters
  Map get getSummary {
    return _summary;
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
  void setCvData(DataType dataType, Map valDetails) {
    switch (dataType) {
      case DataType.summary:
        for (String valId in valDetails.keys) {
          var data = [
            valDetails[valId][TimeLiteral.createdTime.value],
            valDetails[valId][TimeLiteral.updatedTime.value],
            valDetails[valId][DataType.summary.value],
          ];
          _summary[valId] = SummaryItem(data.first, data[1], data.last);
        }

        break;

      case DataType.about:
        for (String valId in valDetails.keys) {
          var data = [
            valDetails[valId][TimeLiteral.createdTime.value],
            valDetails[valId][TimeLiteral.updatedTime.value]
          ];
          AboutLiteral.values
              .forEach((element) => data.add(valDetails[valId][element.value]));
          _aboutData[valId] = AboutItem(data.first, data[1], data[2], data[3],
              data[4], data[5], data[6], data[7], data[8], data.last);
        }

        break;

      case DataType.education:
        for (String valId in valDetails.keys) {
          var data = [
            valDetails[valId][TimeLiteral.createdTime.value],
            valDetails[valId][TimeLiteral.updatedTime.value]
          ];
          EducationLiteral.values
              .forEach((element) => data.add(valDetails[valId][element.value]));
          _educationData[valId] = EducationItem(
              data.first, data[1], data[2], data[3], data[4], data.last);
        }
        break;

      case DataType.professional:
        for (String valId in valDetails.keys) {
          var data = [
            valDetails[valId][TimeLiteral.createdTime.value],
            valDetails[valId][TimeLiteral.updatedTime.value]
          ];
          ProfessionalLiteral.values
              .forEach((element) => data.add(valDetails[valId][element.value]));
          _professionalData[valId] = ProfessionalItem(
              data.first, data[1], data[2], data[3], data[4], data.last);
        }
        break;

      case DataType.research:
        for (String valId in valDetails.keys) {
          var data = [
            valDetails[valId][TimeLiteral.createdTime.value],
            valDetails[valId][TimeLiteral.updatedTime.value]
          ];
          ResearchLiteral.values
              .forEach((element) => data.add(valDetails[valId][element.value]));
          _researchData[valId] = ResearchItem(
              data.first, data[1], data[2], data[3], data[4], data.last);
        }
        break;

      case DataType.publication:
        for (String valId in valDetails.keys) {
          var data = [
            valDetails[valId][TimeLiteral.createdTime.value],
            valDetails[valId][TimeLiteral.updatedTime.value]
          ];
          PublicationLiteral.values
              .forEach((element) => data.add(valDetails[valId][element.value]));
          _publicationsData[valId] =
              PublicationItem(data.first, data[1], data[2], data.last);
        }
        break;

      case DataType.presentation:
        for (String valId in valDetails.keys) {
          var data = [
            valDetails[valId][TimeLiteral.createdTime.value],
            valDetails[valId][TimeLiteral.updatedTime.value]
          ];
          PresentationLiteral.values
              .forEach((element) => data.add(valDetails[valId][element.value]));
          _presentationsData[valId] = PresentationItem(
              data.first, data[1], data[2], data[3], data.last);
        }
        break;

      case DataType.award:
        for (String valId in valDetails.keys) {
          var data = [
            valDetails[valId][TimeLiteral.createdTime.value],
            valDetails[valId][TimeLiteral.updatedTime.value]
          ];
          AwardLiteral.values
              .forEach((element) => data.add(valDetails[valId][element.value]));
          _awardsData[valId] =
              AwardItem(data.first, data[1], data[2], data[3], data.last);
        }
        break;

      case DataType.extra:
        for (String valId in valDetails.keys) {
          var data = [
            valDetails[valId][TimeLiteral.createdTime.value],
            valDetails[valId][TimeLiteral.updatedTime.value]
          ];
          ExtraLiteral.values
              .forEach((element) => data.add(valDetails[valId][element.value]));
          _extraData[valId] =
              ExtraItem(data.first, data[1], data[2], data.last);
        }
        break;

      case DataType.referee:
        for (String valId in valDetails.keys) {
          var data = [
            valDetails[valId][TimeLiteral.createdTime.value],
            valDetails[valId][TimeLiteral.updatedTime.value]
          ];
          RefereeLiteral.values
              .forEach((element) => data.add(valDetails[valId][element.value]));
          _refereeData[valId] = RefereeItem(
              data.first, data[1], data[2], data[3], data[4], data.last);
        }
        break;

      case DataType.portrait:
        portraitBytes = valDetails[dataType];
        break;
    }
  }

  Map getCvData(DataType dataType) {
    Map funcMap = {
      DataType.summary: getSummary,
      DataType.about: getAbout,
      DataType.education: getEducation,
      DataType.professional: getProfessional,
      DataType.research: getResearch,
      DataType.publication: getPublications,
      DataType.award: getAwards,
      DataType.presentation: getPresentations,
      DataType.extra: getExtra,
      DataType.referee: getReferees,
    };

    return funcMap[dataType];
  }

  void updateCvData(
      DataType dataType, String instanceId, Object newDataInstance) {
    Map dataMap = {
      DataType.summary: _summary,
      DataType.about: _aboutData,
      DataType.education: _educationData,
      DataType.professional: _professionalData,
      DataType.research: _researchData,
      DataType.publication: _publicationsData,
      DataType.award: _awardsData,
      DataType.presentation: _presentationsData,
      DataType.extra: _extraData,
      DataType.referee: _refereeData,
    };

    dataMap[dataType][instanceId] = newDataInstance;
  }

  void initialSetupCvData(Map cvDataMap) {
    for (DataType dataType in cvDataMap.keys) {
      final cvData = cvDataMap[dataType];

      if (cvData.isNotEmpty || cvData != '') {
        setCvData(dataType, cvData);
      }
    }
  }

  void deleteCvData(Map cvDataMap) {
    for (DataType dataType in cvDataMap.keys) {
      final cvData = cvDataMap[dataType];

      switch (dataType) {
        case DataType.summary:
          for (String valId in cvData.keys) {
            _summary.remove(valId);
          }

        case DataType.about:
          for (String valId in cvData.keys) {
            _aboutData.remove(valId);
          }

        case DataType.education:
          for (String valId in cvData.keys) {
            _educationData.remove(valId);
          }

        case DataType.professional:
          for (String valId in cvData.keys) {
            _professionalData.remove(valId);
          }

        case DataType.research:
          for (String valId in cvData.keys) {
            _researchData.remove(valId);
          }

        case DataType.publication:
          for (String valId in cvData.keys) {
            _publicationsData.remove(valId);
          }

        case DataType.presentation:
          for (String valId in cvData.keys) {
            _presentationsData.remove(valId);
          }

        case DataType.award:
          for (String valId in cvData.keys) {
            _awardsData.remove(valId);
          }

        case DataType.extra:
          for (String valId in cvData.keys) {
            _extraData.remove(valId);
          }

        case DataType.referee:
          for (String valId in cvData.keys) {
            _refereeData.remove(valId);
          }

        case DataType.portrait:
          portraitBytes;
      }
    }
  }

  /// Delete all CV data
  void deleteAllCvData() {
    _summary.clear();
    _aboutData.clear();
    _educationData.clear();
    _professionalData.clear();
    _publicationsData.clear();
    _researchData.clear();
    _awardsData.clear();
    _presentationsData.clear();
    _extraData.clear();
    _refereeData.clear();
    portraitBytes;
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
