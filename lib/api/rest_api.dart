/// RESTful API functions
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
import 'package:cvpod/screens/profile/profile_tabs.dart';
import 'package:cvpod/utils/gen_turtle_struc.dart';
import 'package:cvpod/utils/misc.dart';
import 'package:cvpod/utils/rdf.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:solidpod/solidpod.dart';
import 'package:cvpod/constants/file_paths.dart';
import 'package:cvpod/utils/cv_managet.dart';

/// String variables for creating files and directories on solid server

const String fileTypeLink = '<http://www.w3.org/ns/ldp#Resource>; rel="type"';
const String dirTypeLink =
    '<http://www.w3.org/ns/ldp#BasicContainer>; rel="type"';

/// Read data from file on the server
Future<CvManager> readProfileData(
    BuildContext context, Widget child, CvManager cvManager) async {
  Map cvDataMap = {};

  if (cvManager.checkUpdatedDateExpired()) {
    for (String fileType in filePathMap.keys) {
      String filePath = filePathMap[fileType];

      String? fileContent = await readPod(filePath, context, child);

      if (fileContent != null && fileContent.isNotEmpty) {
        Map dataMap = getRdfData(fileContent, fileType);
        cvDataMap[fileType] = dataMap;
      } else {
        cvDataMap[fileType] = '';
      }
    }

    cvManager.updateCvData(cvDataMap);
    cvManager.updateDate();
  }
  return cvManager;
}

/// Check if file already exists on the server
Future<bool> checkFileExists(String fileName, BuildContext context) async {
  final filePath = [await getDataDirPath(), fileName].join('/');

  await loginIfRequired(context);

  // Check if the file already exists

  final fileUrl = await getFileUrl(filePath);
  final fileExists = await checkResourceStatus(fileUrl, true);

  return fileExists;
}

Future<bool> checkResourceStatus(String resUrl, bool fileFlag) async {
  final (:accessToken, :dPopToken) = await getTokensForResource(resUrl, 'GET');
  final response = await http.get(
    Uri.parse(resUrl),
    headers: <String, String>{
      'Content-Type': fileFlag ? '*/*' : 'application/octet-stream',
      'Authorization': 'DPoP $accessToken',
      'Link': fileFlag ? fileTypeLink : dirTypeLink,
      'DPoP': dPopToken,
    },
  );

  if (response.statusCode == 200 || response.statusCode == 204) {
    return true;
  } else if (response.statusCode == 404) {
    return false;
  } else {
    return false;
  }
}

/// Write new profile data either to an existing file or to a new file
/// If file exists, then the function will add the new data to that file
/// If file does not exist, then the function will create a new file and
/// add content to it.
Future<CvManager> writeProfileData(BuildContext context, CvManager cvManager,
    String webId, String dataType, Map dataMap) async {
  // Create new file body
  String dataRdf = genRdfLine(dataType, dataMap);

  if (await checkFileExists(fileNamesMap[dataType], context)) {
    // Get file url
    final filePath = [await getDataDirPath(), fileNamesMap[dataType]].join('/');
    final fileUrl = await getFileUrl(filePath);

    // Update profile data
    await addProfileData(dataRdf, fileUrl);
  } else {
    // Generate ttl file body
    String fileTtlBody = genTtlFileBody(capitalize(dataType), dataRdf);

    // Create a new file with content
    await writePod(
        fileNamesMap[dataType],
        fileTtlBody,
        context,
        ProfileTabs(
          webId: webId,
          cvManager: cvManager,
        ),
        encrypted: false);
  }

  /// update the cv manager
  cvManager.updateCvData({dataType: dataMap});

  return cvManager;
}

/// Add data to existing file
Future<void> addProfileData(String rdfLine, String fileUrl) async {
  /// Define query parameters
  String prefix1 = 'cvDataId: <$cvDataId>';
  String prefix2 = 'cvData: <$cvData>';

  /// Generate update sparql query
  String query = 'PREFIX $prefix1 PREFIX $prefix2 INSERT DATA {$rdfLine};';

  final (:accessToken, :dPopToken) =
      await getTokensForResource(fileUrl, 'PATCH');

  final response = await http.patch(
    Uri.parse(fileUrl),
    headers: <String, String>{
      'Accept': '*/*',
      'Authorization': 'DPoP $accessToken',
      'Connection': 'keep-alive',
      'Content-Type': 'application/sparql-update',
      'Content-Length': query.length.toString(),
      'DPoP': dPopToken,
    },
    body: query,
  );

  if ([200, 201, 205].contains(response.statusCode)) {
    return;
  } else {
    throw Exception('Failed to update resource!'
        '\nURL: $fileUrl'
        '\nERROR: ${response.body}');
  }
}
