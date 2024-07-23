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

import 'package:cvpod/utils/cvData/aboutItem.dart';
import 'package:cvpod/utils/cvData/awardItem.dart';
import 'package:cvpod/utils/cvData/educationItem.dart';
import 'package:cvpod/utils/cvData/extraItem.dart';
import 'package:cvpod/utils/cvData/presentationItem.dart';
import 'package:cvpod/utils/cvData/professionalItem.dart';
import 'package:cvpod/utils/cvData/publicationItem.dart';
import 'package:cvpod/utils/cvData/refereeItem.dart';
import 'package:cvpod/utils/cvData/researchItem.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/constants/app.dart';
import 'package:cvpod/constants/schema.dart';
import 'package:cvpod/utils/cvData/summaryItem.dart';

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

String genSummaryRdfLine(SummaryItem summaryData) {
  String sumRdfLine =
      'cvDataId:${summaryData.createdTime}\n    cvData:createdTime "${summaryData.createdTime}"^^xsd:string;\n    cvData:updatedTime "${summaryData.updatedTime}"^^xsd:string;\n    cvData:summary "${summaryData.summary}"^^xsd:string.';

  return sumRdfLine;
}

String genAboutRdfLine(AboutItem aboutData) {
  String aboutRdfLine =
      'cvDataId:${aboutData.createdTime}\n    cvData:createdTime "${aboutData.createdTime}"^^xsd:string;\n    cvData:updatedTime "${aboutData.updatedTime}"^^xsd:string;\n    cvData:name "${aboutData.name}"^^xsd:string;\n    cvData:position "${aboutData.position}"^^xsd:string;\n    cvData:gender "${aboutData.gender}"^^xsd:string;\n    cvData:address "${aboutData.address}"^^xsd:string;\n    cvData:email "${aboutData.email}"^^xsd:string;\n    cvData:phone "${aboutData.phone}"^^xsd:string;\n    cvData:linkedin "<${aboutData.linkedin}>";\n    cvData:web "<${aboutData.web}>".';

  return aboutRdfLine;
}

String genEduRdfLine(EducationItem eduData) {
  String eduRdfLine =
      'cvDataId:${eduData.createdTime}\n    cvData:createdTime "${eduData.createdTime}"^^xsd:string;\n    cvData:updatedTime "${eduData.updatedTime}"^^xsd:string;\n    cvData:degree "${eduData.degree}"^^xsd:string;\n    cvData:duration "${eduData.duration}"^^xsd:string;\n    cvData:institute "${eduData.institute}"^^xsd:string;\n    cvData:comments "${eduData.comments}"^^xsd:string.';

  return eduRdfLine;
}

String genProfRdfLine(ProfessionalItem profData) {
  String profRdfLine =
      'cvDataId:${profData.createdTime}\n    cvData:createdTime "${profData.createdTime}"^^xsd:string;\n    cvData:updatedTime "${profData.updatedTime}"^^xsd:string;\n    cvData:title "${profData.title}"^^xsd:string;\n    cvData:duration "${profData.duration}"^^xsd:string;\n    cvData:company "${profData.company}"^^xsd:string;\n    cvData:comments "${profData.comments}"^^xsd:string.';

  return profRdfLine;
}

String genResRdfLine(ResearchItem resData) {
  String resRdfLine =
      'cvDataId:${resData.createdTime}\n    cvData:createdTime "${resData.createdTime}"^^xsd:string;\n    cvData:updatedTime "${resData.updatedTime}"^^xsd:string;\n    cvData:title "${resData.title}"^^xsd:string;\n    cvData:duration "${resData.duration}"^^xsd:string;\n    cvData:institute "${resData.institute}"^^xsd:string;\n    cvData:comments "${resData.comments}"^^xsd:string.';

  return resRdfLine;
}

String genPubRdfLine(PublicationItem pubData) {
  String pubRdfLine =
      'cvDataId:${pubData.createdTime}\n    cvData:createdTime "${pubData.createdTime}"^^xsd:string;\n    cvData:updatedTime "${pubData.updatedTime}"^^xsd:string;\n    cvData:citation "${pubData.citation}"^^xsd:string;\n    cvData:year "${pubData.year}"^^xsd:string.';

  return pubRdfLine;
}

String genPresRdfLine(PresentationItem presData) {
  String presRdfLine =
      'cvDataId:${presData.createdTime}\n    cvData:createdTime "${presData.createdTime}"^^xsd:string;\n    cvData:updatedTime "${presData.updatedTime}"^^xsd:string;\n    cvData:url "<${presData.url}>";\n    cvData:year "${presData.year}"^^xsd:string;\n    cvData:description "${presData.description}"^^xsd:string.';

  return presRdfLine;
}

String genAwardRdfLine(AwardItem awardData) {
  String awardRdfLine =
      'cvDataId:${awardData.createdTime}\n    cvData:createdTime "${awardData.createdTime}"^^xsd:string;\n    cvData:updatedTime "${awardData.updatedTime}"^^xsd:string;\n    cvData:title "${awardData.title}"^^xsd:string;\n    cvData:year "${awardData.year}"^^xsd:string;\n    cvData:description "${awardData.description}"^^xsd:string.';

  return awardRdfLine;
}

String genExtraRdfLine(ExtraItem exData) {
  String exRdfLine =
      'cvDataId:${exData.createdTime}\n    cvData:createdTime "${exData.createdTime}"^^xsd:string;\n    cvData:updatedTime "${exData.updatedTime}"^^xsd:string;\n    cvData:description "${exData.description}"^^xsd:string;\n    cvData:duration "${exData.duration}"^^xsd:string.';

  return exRdfLine;
}

String genRefRdfLine(RefereeItem refData) {
  String refRdfLine =
      'cvDataId:${refData.createdTime}\n    cvData:createdTime "${refData.createdTime}"^^xsd:string;\n    cvData:updatedTime "${refData.updatedTime}"^^xsd:string;\n    cvData:name "${refData.name}"^^xsd:string;\n    cvData:position "${refData.position}"^^xsd:string;\n    cvData:email "${refData.email}"^^xsd:string;\n    cvData:institute "${refData.institute}"^^xsd:string.';

  return refRdfLine;
}

String genRdfLine(DataType dataType, Object dataInstance) {
  String rdfLine = '';
  switch (dataType) {
    case DataType.summary:
      rdfLine = genSummaryRdfLine(dataInstance as SummaryItem);
      break;

    case DataType.about:
      rdfLine = genAboutRdfLine(dataInstance as AboutItem);
      break;

    case DataType.education:
      rdfLine = genEduRdfLine(dataInstance as EducationItem);
      break;

    case DataType.professional:
      rdfLine = genProfRdfLine(dataInstance as ProfessionalItem);
      break;

    case DataType.research:
      rdfLine = genResRdfLine(dataInstance as ResearchItem);
      break;

    case DataType.publication:
      rdfLine = genPubRdfLine(dataInstance as PublicationItem);
      break;

    case DataType.presentation:
      rdfLine = genPresRdfLine(dataInstance as PresentationItem);
      break;

    case DataType.award:
      rdfLine = genAwardRdfLine(dataInstance as AwardItem);
      break;

    case DataType.extra:
      rdfLine = genExtraRdfLine(dataInstance as ExtraItem);
      break;

    case DataType.referee:
      rdfLine = genRefRdfLine(dataInstance as RefereeItem);
      break;

    default:
      {
        debugPrint('Cannot happen');
      }
      break;
  }
  return rdfLine;
}
