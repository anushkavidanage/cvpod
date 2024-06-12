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
      break;

    case 'professional':
      break;

    case 'research':
      break;

    case 'publications':
      break;

    case 'presentations':
      break;

    case 'awards':
      break;

    case 'extra':
      break;

    case 'referees':
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
  for (Map valueMap in ttlMap.values) {
    if (valueMap.containsKey('summary')) {
      sumMap = valueMap;
    }
  }
  return sumMap;
}

Map parseAbout(Map ttlMap) {
  Map aboutMap = {};
  for (Map valueMap in ttlMap.values) {
    if (valueMap.containsKey('address')) {
      aboutMap = valueMap;
    }
  }
  return aboutMap;
}
