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
      '@prefix : <#>.\n@prefix foaf: <$foaf>.\n@prefix terms: <$terms>.\n@prefix xsd: <$httpXMLSchema>.\n@prefix cvDataId: <$cvDataId>.\n@prefix cvData: <$cvData>.\n:me\n    a foaf:PersonalProfileDocument;\n    terms:title "$fileName".\n\n$initialContent';

  return ttlFileBody;
}

String genSummaryRdfLine(
    String summary, String createdDateTimeStr, String updatedDateTimeStr) {
  String sumRdfLine =
      'cvDataId:$createdDateTimeStr\n    cvData:createdTime "$createdDateTimeStr"^^xsd:string;\n    cvData:lastUpdatedTime "$updatedDateTimeStr"^^xsd:string;\n    cvData:summary "$summary"^^xsd:string.';

  return sumRdfLine;
}

String genAboutRdfLine(
    Map bioData, String createdDateTimeStr, String updatedDateTimeStr) {
  String bioRdfLine =
      'cvDataId:$createdDateTimeStr\n    cvData:createdTime "$createdDateTimeStr"^^xsd:string;\n    cvData:lastUpdatedTime "$updatedDateTimeStr"^^xsd:string;\n    cvData:name "${bioData['name']}"^^xsd:string;\n    cvData:gender "${bioData['gender']}"^^xsd:string;\n    cvData:address "${bioData['address']}"^^xsd:string;\n    cvData:email "${bioData['email']}"^^xsd:string;\n    cvData:phone "${bioData['phone']}"^^xsd:string;\n    cvData:linkedin "<${bioData['linkedin']}>";\n    cvData:web "<${bioData['web']}>".';

  return bioRdfLine;
}

String genEduRdfLine(
    Map eduData, String createdDateTimeStr, String updatedDateTimeStr) {
  String eduRdfLine =
      'cvDataId:$createdDateTimeStr\n    cvData:createdTime "$createdDateTimeStr"^^xsd:string;\n    cvData:lastUpdatedTime "$updatedDateTimeStr"^^xsd:string;\n    cvData:degree "${eduData['degree']}"^^xsd:string;\n    cvData:duration "${eduData['duration']}"^^xsd:string;\n    cvData:institute "${eduData['institute']}"^^xsd:string;\n    cvData:comments "${eduData['comments']}"^^xsd:string.';

  return eduRdfLine;
}

String genProfRdfLine(
    Map profData, String createdDateTimeStr, String updatedDateTimeStr) {
  String profRdfLine =
      'cvDataId:$createdDateTimeStr\n    cvData:createdTime "$createdDateTimeStr"^^xsd:string;\n    cvData:lastUpdatedTime "$updatedDateTimeStr"^^xsd:string;\n    cvData:title "${profData['title']}"^^xsd:string;\n    cvData:duration "${profData['duration']}"^^xsd:string;\n    cvData:company "${profData['company']}"^^xsd:string;\n    cvData:comments "${profData['comments']}"^^xsd:string.';

  return profRdfLine;
}

String genResRdfLine(
    Map resData, String createdDateTimeStr, String updatedDateTimeStr) {
  String resRdfLine =
      'cvDataId:$createdDateTimeStr\n    cvData:createdTime "$createdDateTimeStr"^^xsd:string;\n    cvData:lastUpdatedTime "$updatedDateTimeStr"^^xsd:string;\n    cvData:title "${resData['title']}"^^xsd:string;\n    cvData:duration "${resData['duration']}"^^xsd:string;\n    cvData:institute "${resData['institute']}"^^xsd:string;\n    cvData:comments "${resData['comments']}"^^xsd:string.';

  return resRdfLine;
}

String genPubRdfLine(
    Map pubData, String createdDateTimeStr, String updatedDateTimeStr) {
  String pubRdfLine =
      'cvDataId:$createdDateTimeStr\n    cvData:createdTime "$createdDateTimeStr"^^xsd:string;\n    cvData:lastUpdatedTime "$updatedDateTimeStr"^^xsd:string;\n    cvData:citation "${pubData['citation']}"^^xsd:string;\n    cvData:year "${pubData['year']}"^^xsd:string.';

  return pubRdfLine;
}

String genPresRdfLine(
    Map presData, String createdDateTimeStr, String updatedDateTimeStr) {
  String presRdfLine =
      'cvDataId:$createdDateTimeStr\n    cvData:createdTime "$createdDateTimeStr"^^xsd:string;\n    cvData:lastUpdatedTime "$updatedDateTimeStr"^^xsd:string;\n    cvData:url "<${presData['url']}>";\n    cvData:year "${presData['year']}"^^xsd:string;\n    cvData:description "${presData['description']}"^^xsd:string.';

  return presRdfLine;
}

String genAwardRdfLine(
    Map awardData, String createdDateTimeStr, String updatedDateTimeStr) {
  String awardRdfLine =
      'cvDataId:$createdDateTimeStr\n    cvData:createdTime "$createdDateTimeStr"^^xsd:string;\n    cvData:lastUpdatedTime "$updatedDateTimeStr"^^xsd:string;\n    cvData:title "${awardData['title']}"^^xsd:string;\n    cvData:year "${awardData['year']}"^^xsd:string;\n    cvData:description "${awardData['description']}"^^xsd:string.';

  return awardRdfLine;
}

String genExtraRdfLine(
    Map exData, String createdDateTimeStr, String updatedDateTimeStr) {
  String exRdfLine =
      'cvDataId:$createdDateTimeStr\n    cvData:createdTime "$createdDateTimeStr"^^xsd:string;\n    cvData:lastUpdatedTime "$updatedDateTimeStr"^^xsd:string;\n    cvData:description "${exData['description']}"^^xsd:string;\n    cvData:duration "${exData['duration']}"^^xsd:string.';

  return exRdfLine;
}

String genRefRdfLine(
    Map refData, String createdDateTimeStr, String updatedDateTimeStr) {
  String refRdfLine =
      'cvDataId:$createdDateTimeStr\n    cvData:createdTime "$createdDateTimeStr"^^xsd:string;\n    cvData:lastUpdatedTime "$updatedDateTimeStr"^^xsd:string;\n    cvData:name "${refData['name']}"^^xsd:string;\n    cvData:position "${refData['position']}"^^xsd:string;\n    cvData:email "${refData['email']}"^^xsd:string;\n    cvData:institute "${refData['institute']}"^^xsd:string.';

  return refRdfLine;
}

String genRdfLine(String dataType, Map dataMap, String createdDateTimeStr,
    String updatedDateTimeStr) {
  String rdfLine = '';
  switch (dataType) {
    case 'about':
      rdfLine =
          genAboutRdfLine(dataMap, createdDateTimeStr, updatedDateTimeStr);
      break;

    case 'education':
      rdfLine = genEduRdfLine(dataMap, createdDateTimeStr, updatedDateTimeStr);
      break;

    case 'professional':
      rdfLine = genProfRdfLine(dataMap, createdDateTimeStr, updatedDateTimeStr);
      break;

    case 'research':
      rdfLine = genResRdfLine(dataMap, createdDateTimeStr, updatedDateTimeStr);
      break;

    case 'publications':
      rdfLine = genPubRdfLine(dataMap, createdDateTimeStr, updatedDateTimeStr);
      break;

    case 'presentations':
      rdfLine = genPresRdfLine(dataMap, createdDateTimeStr, updatedDateTimeStr);
      break;

    case 'awards':
      rdfLine =
          genAwardRdfLine(dataMap, createdDateTimeStr, updatedDateTimeStr);
      break;

    case 'extra':
      rdfLine =
          genExtraRdfLine(dataMap, createdDateTimeStr, updatedDateTimeStr);
      break;

    case 'referees':
      rdfLine = genRefRdfLine(dataMap, createdDateTimeStr, updatedDateTimeStr);
      break;

    default:
      {
        debugPrint('Cannot happen');
      }
      break;
  }
  return rdfLine;
}
