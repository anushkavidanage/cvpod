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

import 'dart:async';

import 'package:cvpod/constants/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:solidpod/solidpod.dart';

import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/constants/schema.dart';
import 'package:cvpod/screens/profile/profile_tabs.dart';
import 'package:cvpod/utils/gen_turtle_struc.dart';
import 'package:cvpod/utils/misc.dart';
import 'package:cvpod/utils/rdf.dart';

/// String variables for creating files and directories on solid server

const String fileTypeLink = '<http://www.w3.org/ns/ldp#Resource>; rel="type"';
const String dirTypeLink =
    '<http://www.w3.org/ns/ldp#BasicContainer>; rel="type"';

/// Update CV manager data from files on the server
Future<CvManager> updateProfileData(
    BuildContext context, Widget child, CvManager cvManager) async {
  if (cvManager.checkUpdatedDateExpired()) {
    Map cvDataMap = await fetchProfileData(context, child);

    cvManager.initialSetupCvData(cvDataMap);
    cvManager.updateDate();
  }
  return cvManager;
}

/// Fetch data from the server
Future<Map> fetchProfileData(
  BuildContext context,
  Widget child,
) async {
  Map cvDataMap = {};

  // Read cv content files
  for (DataType dataType in dataTypeList) {
    if (dataType == DataType.portrait) {
      if (await checkFileExists(dataType.portaitFile, context)) {
        final filePath = dataType.portaitFilePath;
        final fileUrl = await getFileUrl(filePath);
        Uint8List imageBytes =
            await httpRequestImg(fileUrl, ResourceContentType.image);

        if (imageBytes.isNotEmpty) {
          cvDataMap[dataType] = {dataType: imageBytes};
        }
      }
    } else {
      String filePath = dataType.ttlFilePath;

      String? fileContent = await readPod(filePath, context, child);

      if (fileContent != null && fileContent.isNotEmpty) {
        Map dataMap = getRdfData(fileContent, dataType);
        cvDataMap[dataType] = dataMap;
      } else {
        cvDataMap[dataType] = '';
      }
    }
  }
  return cvDataMap;
}

// Future<Unit8> fetchImageData (String imageurl) async {

//   await NetworkAssetBundle(
//                       Uri.parse(widget.cvManager.portraitPicPath))
//                   .load(widget.cvManager.portraitPicPath)
// }

Future<Map> checkProfileData(
    BuildContext context, Widget child, CvManager? cvManager) async {
  if (cvManager == null) {
    return await fetchProfileData(context, child);
  } else {
    return {};
  }
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
Future<CvManager> writeProfileData(
    BuildContext context,
    CvManager cvManager,
    String webId,
    DataType dataType,
    Object dataInstance,
    String instanceId) async {
  // Create new file body
  String dataRdf = genRdfLine(dataType, dataInstance);

  if (await checkFileExists(dataType.ttlFile, context)) {
    // Get file url
    final filePath = [await getDataDirPath(), dataType.ttlFile].join('/');
    final fileUrl = await getFileUrl(filePath);

    // Update profile data
    await addProfileData(dataRdf, fileUrl);
  } else {
    // Generate ttl file body
    String fileTtlBody = genTtlFileBody(capitalize(dataType.value), dataRdf);

    // Create a new file with content
    await writePod(
        dataType.ttlFile,
        fileTtlBody,
        context,
        ProfileTabs(
          webId: webId,
          cvManager: cvManager,
        ),
        encrypted: false);
  }

  /// update the cv manager
  //cvManager.
  cvManager.updateCvData(dataType, instanceId, dataInstance);

  return cvManager;
}

/// Add data to existing file
Future<void> addProfileData(String rdfLine, String fileUrl) async {
  /// Define query parameters
  String prefix1 = 'cvDataId: <$cvDataId>';
  String prefix2 = 'cvData: <$cvData>';
  String prefix3 = 'xsd: <$httpXMLSchema>';

  /// Generate update sparql query
  String query =
      'PREFIX $prefix1 PREFIX $prefix2 PREFIX $prefix3 INSERT DATA {$rdfLine};';

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

/// Edit profile data.
Future<CvManager> editProfileData(
    BuildContext context,
    CvManager cvManager,
    DataType dataType,
    Object newDataInstace,
    Object prevDataInstace,
    String instanceId) async {
  String prevDataRdf = genRdfLine(dataType, prevDataInstace);
  String newDataRdf = genRdfLine(dataType, newDataInstace);

  // Define SPARQL query
  String prefix1 = 'cvDataId: <$cvDataId>';
  String prefix2 = 'cvData: <$cvData>';
  String prefix3 = 'xsd: <$httpXMLSchema>';

  // Generate update sparql query
  String query =
      'PREFIX $prefix1 PREFIX $prefix2 PREFIX $prefix3 DELETE DATA {$prevDataRdf}; INSERT DATA {$newDataRdf};';

  // Get file url
  final filePath = [await getDataDirPath(), dataType.ttlFile].join('/');
  final fileUrl = await getFileUrl(filePath);

  await httpRequest(HttpRequest.patch, fileUrl, ResourceContentType.sparql,
      content: query);

  // update the cv manager
  cvManager.updateCvData(dataType, instanceId, newDataInstace);

  return cvManager;
}

/// Edit profile data.
Future<CvManager> deleteProfileData(BuildContext context, CvManager cvManager,
    DataType dataType, Object dataInstance, String instanceId) async {
  String dataRdf = genRdfLine(dataType, dataInstance);

  // Define SPARQL query
  String prefix1 = 'cvDataId: <$cvDataId>';
  String prefix2 = 'cvData: <$cvData>';
  String prefix3 = 'xsd: <$httpXMLSchema>';

  // Generate update sparql query
  String query =
      'PREFIX $prefix1 PREFIX $prefix2 PREFIX $prefix3 DELETE DATA {$dataRdf};';

  // Get file url
  final filePath = [await getDataDirPath(), dataType.ttlFile].join('/');
  final fileUrl = await getFileUrl(filePath);

  await httpRequest(HttpRequest.patch, fileUrl, ResourceContentType.sparql,
      content: query);

  cvManager.deleteCvData({
    dataType: {instanceId: dataInstance}
  });

  return cvManager;
}

/// Upload a file to the Solid server
Future<bool> uploadFile(String filePath, dynamic fileContent,
    ResourceContentType contentType) async {
  final fileUrl = await getFileUrl(filePath);

  await httpRequest(HttpRequest.put, fileUrl, ResourceContentType.image,
      content: fileContent);

  return true;
}

/// Run http request to the Solid server
Future<String> httpRequest(
    HttpRequest requestType, String url, ResourceContentType contentType,
    {dynamic content, bool fileFlag = true}) async {
  final (:accessToken, :dPopToken) =
      await getTokensForResource(url, requestType.value.toUpperCase());

  final headerMap = <String, String>{
    'Accept': '*/*',
    'Authorization': 'DPoP $accessToken',
    'Connection': 'keep-alive',
    'Link': fileFlag ? fileTypeLink : dirTypeLink,
    'Content-Type': contentType.value,
    'DPoP': dPopToken,
  };

  dynamic response;

  if (requestType == HttpRequest.get) {
    response = await http.get(
      Uri.parse(url),
      headers: headerMap,
    );
  } else {
    headerMap['Content-Length'] = content!.length.toString();
    if (requestType == HttpRequest.post) {
      response = await http.post(
        Uri.parse(url),
        headers: headerMap,
        body: content,
      );
    } else if (requestType == HttpRequest.put) {
      response = await http.put(
        Uri.parse(url),
        headers: headerMap,
        body: content,
      );
    } else {
      response = await http.patch(
        Uri.parse(url),
        headers: headerMap,
        body: content,
      );
    }
  }

  if ([200, 201, 205].contains(response.statusCode)) {
    debugPrint('Request was successful');
    return response.body;
  } else {
    throw Exception('Failed to run the request!'
        '\nURL: $url'
        '\nERROR: ${response.body}');
  }
}

/// Run http request to the Solid server
Future<Uint8List> httpRequestImg(
    String url, ResourceContentType contentType) async {
  final (:accessToken, :dPopToken) = await getTokensForResource(url, 'GET');

  final headerMap = <String, String>{
    'Accept': '*/*',
    'Authorization': 'DPoP $accessToken',
    'Connection': 'keep-alive',
    'Link': fileTypeLink,
    'Content-Type': contentType.value,
    'DPoP': dPopToken,
  };

  final response = await http.get(
    Uri.parse(url),
    headers: headerMap,
  );

  if ([200, 201, 205].contains(response.statusCode)) {
    debugPrint('Request was successful');
    return response.bodyBytes;
  } else {
    throw Exception('Failed to run the request!'
        '\nURL: $url'
        '\nERROR: ${response.body}');
  }
}

/// Get all the resources (pdf files) in the shared-cvs directory
/// and read the acl permissions for each pdf
Future<Map> readResourcesAcl(
    String webId, BuildContext context, Widget child) async {
  final containerUrl =
      webId.replaceAll('profile/card#me', 'cvpod/data/shared-cvs/');
  final res = await getResourcesInContainer(containerUrl);

  final resPermMap = {};
  // Loop through each file and get the permissions
  // store the permission to a map
  for (final fileName in res.files) {
    if (context.mounted) {
      final permMap =
          await readPermission('shared-cvs/$fileName', true, context, child);

      for (final permWebId in permMap.keys) {
        resPermMap[fileName] = {
          'url': '$containerUrl$fileName',
          'receiver': permWebId,
          'permissions': permMap[permWebId]['permissions'].join(', '),
          'agent': permMap[permWebId]['agent']
        };
      }

      //resPermMap['shared-cvs/$fileName'] = permMap;
    }
  }

  return resPermMap;
}

Future<dynamic> loadRemotePdf(String fileUrl, String fileName,
    {bool fileEncrypted = false}) async {
  final (:accessToken, :dPopToken) = await getTokensForResource(fileUrl, 'GET');

  final downloadResponse = await http.get(
    Uri.parse(fileUrl),
    headers: <String, String>{
      'Accept': '*/*',
      'Authorization': 'DPoP $accessToken',
      'Connection': 'keep-alive',
      'DPoP': dPopToken,
    },
  );
  if (downloadResponse.statusCode == 200 ||
      downloadResponse.statusCode == 201 ||
      downloadResponse.statusCode == 205) {
    if (fileEncrypted) {
    } else {
      Uint8List uintBytes = downloadResponse.bodyBytes;
      return uintBytes;
    }
  } else {
    throw Exception('Failed to update resource! Try again in a while.');
  }
}
