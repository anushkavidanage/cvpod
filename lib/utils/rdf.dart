/// RDF related functions used in the app
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

import 'package:flutter/material.dart';
import 'package:rdflib/rdflib.dart';

Map<String, dynamic> parseTTL(String ttlContent) {
  final g = Graph();
  g.parseTurtle(ttlContent);
  final dataMap = <String, dynamic>{};
  String extract(String str) => str.contains('#') ? str.split('#')[1] : str;
  for (final t in g.triples) {
    final sub = extract(t.sub.value as String);
    final pre = extract(t.pre.value as String);
    final obj = extract(t.obj.value as String);
    if (dataMap.containsKey(sub)) {
      assert(!(dataMap[sub] as Map).containsKey(pre));
      dataMap[sub][pre] = obj;
    } else {
      dataMap[sub] = {pre: obj};
    }
  }
  return dataMap;
}

Map getRdfData(String fileContent, String fileType) {
  Map ttlMap = parseTTL(fileContent);
  Map rdfDataMap = {};

  switch (fileType) {
    case 'summary':
      rdfDataMap = parseSummary(ttlMap);
      break;

    case 'about':
      rdfDataMap = parseAbout(ttlMap);
      break;

    case 'education':
      rdfDataMap = parseEducation(ttlMap);
      break;

    case 'professional':
      rdfDataMap = parseProfessional(ttlMap);
      break;

    case 'research':
      rdfDataMap = parseResearch(ttlMap);
      break;

    case 'publications':
      rdfDataMap = parsePublications(ttlMap);
      break;

    case 'presentations':
      rdfDataMap = parsePresentations(ttlMap);
      break;

    case 'awards':
      rdfDataMap = parseAwards(ttlMap);
      break;

    case 'extra':
      rdfDataMap = parseExtra(ttlMap);
      break;

    case 'referees':
      rdfDataMap = parseReferees(ttlMap);
      break;

    default:
      {
        debugPrint('Cannot happen');
      }
      break;
  }

  return rdfDataMap;
}

Map parseSummary(Map ttlMap) {
  Map sumMap = {};
  for (String valueId in ttlMap.keys) {
    Map valueMap = ttlMap[valueId];
    if (valueMap.containsKey('summary')) {
      valueMap['datetime'] = valueId;
      sumMap = valueMap;
    }
  }
  return sumMap;
}

Map parseAbout(Map ttlMap) {
  Map aboutMap = {};
  for (String valueId in ttlMap.keys) {
    Map valueMap = ttlMap[valueId];
    if (valueMap.containsKey('address')) {
      valueMap['datetime'] = valueId;
      aboutMap = valueMap;
    }
  }
  return aboutMap;
}

Map parseEducation(Map ttlMap) {
  Map eduMap = {};
  for (String valueId in ttlMap.keys) {
    Map valueMap = ttlMap[valueId];
    if (valueMap.containsKey('degree')) {
      eduMap[valueId] = valueMap;
    }
  }
  return eduMap;
}

Map parseProfessional(Map ttlMap) {
  Map profMap = {};
  for (String valueId in ttlMap.keys) {
    Map valueMap = ttlMap[valueId];
    if (valueMap.containsKey('company')) {
      profMap[valueId] = valueMap;
    }
  }
  return profMap;
}

Map parseResearch(Map ttlMap) {
  Map resMap = {};
  for (String valueId in ttlMap.keys) {
    Map valueMap = ttlMap[valueId];
    if (valueMap.containsKey('institute')) {
      resMap[valueId] = valueMap;
    }
  }
  return resMap;
}

Map parsePublications(Map ttlMap) {
  Map pubMap = {};
  for (String valueId in ttlMap.keys) {
    Map valueMap = ttlMap[valueId];
    if (valueMap.containsKey('citation')) {
      pubMap[valueId] = valueMap;
    }
  }
  return pubMap;
}

Map parsePresentations(Map ttlMap) {
  Map presMap = {};
  for (String valueId in ttlMap.keys) {
    Map valueMap = ttlMap[valueId];
    if (valueMap.containsKey('url')) {
      presMap[valueId] = valueMap;
    }
  }
  return presMap;
}

Map parseAwards(Map ttlMap) {
  Map awdMap = {};
  for (String valueId in ttlMap.keys) {
    Map valueMap = ttlMap[valueId];
    if (valueMap.containsKey('description')) {
      awdMap[valueId] = valueMap;
    }
  }
  return awdMap;
}

Map parseExtra(Map ttlMap) {
  Map exMap = {};
  for (String valueId in ttlMap.keys) {
    Map valueMap = ttlMap[valueId];
    if (valueMap.containsKey('description')) {
      exMap[valueId] = valueMap;
    }
  }
  return exMap;
}

Map parseReferees(Map ttlMap) {
  Map refMap = {};
  for (String valueId in ttlMap.keys) {
    Map valueMap = ttlMap[valueId];
    if (valueMap.containsKey('position')) {
      refMap[valueId] = valueMap;
    }
  }
  return refMap;
}
