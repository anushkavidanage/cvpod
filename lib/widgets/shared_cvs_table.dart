/// A table displaying permission data for a given file.
///
// Time-stamp: <Sunday 2024-07-11 12:55:00 +1000 Anushka Vidange>
///
/// Copyright (C) 2024, Software Innovation Institute, ANU.
///
/// Licensed under the GNU General Public License, Version 3 (the "License").
///
/// License: https://www.gnu.org/licenses/gpl-3.0.en.html.
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
///
/// Authors: Anushka Vidanage

library;

import 'package:cvpod/screens/home.dart';
import 'package:cvpod/screens/nav/nav_screen.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:printing/printing.dart';

import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/apis/rest_api.dart';
import 'package:cvpod/constants/app.dart';
import 'package:solidpod/solidpod.dart';

/// Build the permission table widget. Function call requires the
/// following inputs
/// [context] is the BuildContext from which this function is called.
/// [sharedResMap] is the map containing data of shared resources.
/// [parentWidget] is the widget to return to after an action Eg: deletion of a
/// permission
///
Widget buildSharedResourcesTable(
  BuildContext context,
  Map<dynamic, dynamic> sharedResMap,
  Function downloadFileFunc,
  String ownerWebId,
  CvManager cvManager,
  Widget parentWidget,
) {
  final cWidth = MediaQuery.of(context).size.width * 0.18;
  DataColumn buildDataColumn(
    String title,
    String tooltip,
  ) {
    return DataColumn(
      label: Expanded(
        child: Center(
          child: Text(
            title,
          ),
        ),
      ),
      tooltip: tooltip,
    );
  }

  DataCell buildDataCell(String content) {
    return DataCell(
      SizedBox(
        width: cWidth,
        child: Column(
          children: <Widget>[
            SelectableText(
              content,
            ),
          ],
        ),
      ),
    );
  }

  return Row(
    children: [
      Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            dataRowMaxHeight: double.infinity,
            horizontalMargin: 10,
            columnSpacing: 10,
            columns: [
              buildDataColumn(
                'CV Name',
                'File name of the CV pdf',
              ),
              buildDataColumn(
                  'Shared with', 'People who you shared the CV with'),
              //buildDataColumn('Shared on', 'Shared date and time'),
              buildDataColumn('Permissions', 'List of permissions given'),
              buildDataColumn('Actions', 'View CV/Edit permissions'),
            ],
            rows: sharedResMap.keys.map((cvName) {
              return DataRow(
                cells: [
                  DataCell(
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      width: cWidth,
                      child: SelectableText(
                        cvName as String,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // DataCell(
                  //   Row(
                  //     children: [
                  //       Expanded(
                  //         child: Text(
                  //           getDateTime(
                  //             sharedResMap[cvName][PermissionLogLiteral.logtime]
                  //                 as String,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  buildDataCell(
                    sharedResMap[cvName]['receiver'] as String,
                  ),
                  buildDataCell(
                    sharedResMap[cvName]['permissions'],
                  ),
                  DataCell(
                    Row(
                      children: [
                        Tooltip(
                          message: 'View PDF',
                          child: IconButton(
                            icon: const Icon(
                              Icons.visibility,
                              size: 24.0,
                              color: lightGreen,
                            ),
                            onPressed: () async {
                              final remotePdfData = await loadRemotePdf(
                                  sharedResMap[cvName]['url'], cvName);

                              if (!context.mounted) return;
                              await showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text(cvName),
                                  content: SizedBox(
                                    width: popupPdfWidth,
                                    child: PdfPreview(
                                      useActions: false,
                                      canChangeOrientation: false,
                                      canChangePageFormat: false,
                                      build: (format) => remotePdfData,
                                    ),
                                  ),
                                  actions: [
                                    downloadFileFunc(remotePdfData, cvName),
                                    TextButton(
                                      onPressed: () {
                                        // Close the dialog
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text('Ok'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Tooltip(
                          message: 'Edit permissions to this PDF',
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              size: 24.0,
                              color: appDarkBlue1,
                            ),
                            onPressed: () async {
                              String dataDirPath = await getDataDirPath();
                              String dataDirUrl = await getDirUrl(dataDirPath);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NavScreen(
                                        webId: ownerWebId,
                                        cvManager: cvManager,
                                        childPage: GrantPermissionUi(
                                          backgroundColor: bgCardLight,
                                          fileName: (sharedResMap[cvName]
                                                  ['url'])
                                              .replaceAll(dataDirUrl, ''),
                                          showAppBar: false,
                                          //sourceWebId:
                                          //    'https://pods.solidcommunity.au/Gerry-Tonga/profile/card#me',
                                          child: Home(
                                              webId: ownerWebId,
                                              cvManager: cvManager),
                                        ))),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    ],
  );
}
