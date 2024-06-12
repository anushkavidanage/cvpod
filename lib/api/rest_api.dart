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

import 'package:cvpod/screens/profile/profile_tabs.dart';
import 'package:cvpod/utils/gen_turtle_struc.dart';
import 'package:cvpod/utils/misc.dart';
import 'package:cvpod/utils/rdf.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:solidpod/solidpod.dart';
import 'package:cvpod/constants/file_paths.dart';
import 'package:cvpod/utils/cv_managet.dart';

/// String variables for creating files and directories on solid server

const String fileTypeLink = '<http://www.w3.org/ns/ldp#Resource>; rel="type"';
const String dirTypeLink =
    '<http://www.w3.org/ns/ldp#BasicContainer>; rel="type"';

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
  final response = await get(
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

Future<CvManager> writeProfileData(BuildContext context, CvManager cvManager,
    String webId, String dataType, Map dataMap) async {
  if (await checkFileExists(fileNamesMap[dataType], context)) {
  } else {
    // Create new file body
    String dataRdf = genRdfLine(dataType, dataMap);

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
