/// Functions to generation turtle structures
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

import 'package:cvpod/constants/schema.dart';
import 'package:cvpod/utils/misc.dart';
import 'package:flutter/material.dart';

/// Generates the body of a turtle file.
///
/// This function constructs a string representing the body of an RDF file, which includes various
/// prefixed namespaces such as FOAF (Friend of a Friend) and custom application-specific terms.
/// The key file body includes a definition for a personal profile document with a title
/// "Individual Encryption Keys". The prefixes used ('foaf:', 'terms:', etc.) are placeholders
/// that should be replaced with actual URIs in a real-world application.

String genTtlFileBody(String fileName, String initialContent) {
  String ttlFileBody =
      '@prefix : <#>.\n@prefix foaf: <$foaf>.\n@prefix terms: <$terms>.\n@prefix cvDataId: <$cvDataId>.\n@prefix cvData: <$cvData>.\n:me\n    a foaf:PersonalProfileDocument;\n    terms:title "$fileName".\n\n$initialContent';

  return ttlFileBody;
}

String genSummaryRdfLine(String summary) {
  String dateTimeStr = getDateTimeStr();
  String sumRdfLine = 'cvDataId:$dateTimeStr cvData:summary "$summary".';

  return sumRdfLine;
}

String genAboutRdfLine(Map bioData) {
  String dateTimeStr = getDateTimeStr();
  String bioRdfLine =
      'cvDataId:$dateTimeStr\n    cvData:name "${bioData['name']}";\n    cvData:gender "${bioData['gender']}";\n    cvData:address "${bioData['address']}";\n    cvData:email "${bioData['email']}";\n    cvData:phone "${bioData['phone']}";\n    cvData:linkedin "${bioData['linkedin']}";\n    cvData:web "${bioData['web']}".';

  return bioRdfLine;
}

String genEduRdfLine(Map eduData) {
  String dateTimeStr = getDateTimeStr();
  String eduRdfLine =
      'cvDataId:$dateTimeStr\n    cvData:degree "${eduData['degree']}";\n    cvData:duration "${eduData['duration']}";\n    cvData:institute "${eduData['institute']}";\n    cvData:comments "${eduData['comments']}".';

  return eduRdfLine;
}

String genProfRdfLine(Map profData) {
  String dateTimeStr = getDateTimeStr();
  String profRdfLine =
      'cvDataId:$dateTimeStr\n    cvData:title "${profData['title']}";\n    cvData:duration "${profData['duration']}";\n    cvData:company "${profData['company']}";\n    cvData:comments "${profData['comments']}".';

  return profRdfLine;
}

String genResRdfLine(Map profData) {
  String dateTimeStr = getDateTimeStr();
  String profRdfLine =
      'cvDataId:$dateTimeStr\n    cvData:title "${profData['title']}";\n    cvData:duration "${profData['duration']}";\n    cvData:company "${profData['company']}";\n    cvData:comments "${profData['comments']}".';

  return profRdfLine;
}

String genPubRdfLine(Map profData) {
  String dateTimeStr = getDateTimeStr();
  String profRdfLine =
      'cvDataId:$dateTimeStr\n    cvData:title "${profData['title']}";\n    cvData:duration "${profData['duration']}";\n    cvData:company "${profData['company']}";\n    cvData:comments "${profData['comments']}".';

  return profRdfLine;
}

String genPresRdfLine(Map profData) {
  String dateTimeStr = getDateTimeStr();
  String profRdfLine =
      'cvDataId:$dateTimeStr\n    cvData:title "${profData['title']}";\n    cvData:duration "${profData['duration']}";\n    cvData:company "${profData['company']}";\n    cvData:comments "${profData['comments']}".';

  return profRdfLine;
}

String genAwardRdfLine(Map profData) {
  String dateTimeStr = getDateTimeStr();
  String profRdfLine =
      'cvDataId:$dateTimeStr\n    cvData:title "${profData['title']}";\n    cvData:duration "${profData['duration']}";\n    cvData:company "${profData['company']}";\n    cvData:comments "${profData['comments']}".';

  return profRdfLine;
}

String genExtraRdfLine(Map profData) {
  String dateTimeStr = getDateTimeStr();
  String profRdfLine =
      'cvDataId:$dateTimeStr\n    cvData:title "${profData['title']}";\n    cvData:duration "${profData['duration']}";\n    cvData:company "${profData['company']}";\n    cvData:comments "${profData['comments']}".';

  return profRdfLine;
}

String genRefRdfLine(Map profData) {
  String dateTimeStr = getDateTimeStr();
  String profRdfLine =
      'cvDataId:$dateTimeStr\n    cvData:title "${profData['title']}";\n    cvData:duration "${profData['duration']}";\n    cvData:company "${profData['company']}";\n    cvData:comments "${profData['comments']}".';

  return profRdfLine;
}

String genRdfLine(String dataType, Map dataMap) {
  String rdfLine = '';
  switch (dataType) {
    case 'about':
      rdfLine = genAboutRdfLine(dataMap);
      break;

    case 'education':
      rdfLine = genEduRdfLine(dataMap);
      break;

    case 'professional':
      rdfLine = genProfRdfLine(dataMap);
      break;

    case 'research':
      rdfLine = genResRdfLine(dataMap);
      break;

    case 'publications':
      rdfLine = genPubRdfLine(dataMap);
      break;

    case 'presentations':
      rdfLine = genPresRdfLine(dataMap);
      break;

    case 'awards':
      rdfLine = genAwardRdfLine(dataMap);
      break;

    case 'extra':
      rdfLine = genExtraRdfLine(dataMap);
      break;

    case 'referees':
      rdfLine = genRefRdfLine(dataMap);
      break;

    default:
      {
        debugPrint('Cannot happen');
      }
      break;
  }
  return rdfLine;
}
