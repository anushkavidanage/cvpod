/// Summary page
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

library;

import 'package:flutter/material.dart';

import 'package:solidpod/solidpod.dart';

import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/widgets/info_card.dart';
import 'package:cvpod/utils/gen_turtle_struc.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/screens/profile/profile_tabs.dart';
import 'package:cvpod/utils/misc.dart';
import 'package:cvpod/constants/app.dart';
import 'package:cvpod/utils/cvData/summaryItem.dart';
import 'package:cvpod/widgets/loading_animation.dart';
import 'package:cvpod/widgets/popups/edit/tab_select.dart';

class Summary extends StatelessWidget {
  const Summary({
    super.key,
    required this.dataMap,
    required this.webId,
    required this.cvManager,
  });

  /// Summary data
  final Map dataMap;

  /// webId of the user
  final String webId;

  /// CV manager
  final CvManager cvManager;

  @override
  Widget build(BuildContext context) {
    TextEditingController summaryController = TextEditingController();

    void addSummaryDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 50),
              title: const Text("Add a summary of yourself"),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                  controller: summaryController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Summary',
                    hintText: 'Description of yourself',
                  ),
                ),
              ]),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    String summaryValStr = summaryController.text;

                    if (summaryValStr.isNotEmpty && summaryValStr != ' ') {
                      showAnimationDialog(
                        context,
                        24,
                        'Saving data',
                        false,
                      );

                      String dateTimeStr = getDateTimeStr();

                      // Create new instance
                      final newDataInstance =
                          SummaryItem(dateTimeStr, dateTimeStr, summaryValStr);

                      // Generate summary ttl file entry
                      String summaryRdf = genSummaryRdfLine(newDataInstance);

                      // Generate ttl file body
                      String sumTtlBody = genTtlFileBody(
                          capitalize(DataType.summary.value), summaryRdf);

                      // Write content to the file. In this case the function will
                      // create a new file with the content on the server
                      await writePod(
                          DataType.summary.ttlFile,
                          sumTtlBody,
                          context,
                          ProfileTabs(
                            webId: webId,
                            cvManager: cvManager,
                          ),
                          encrypted: false);

                      /// update the cv manager
                      cvManager.updateCvData(
                          DataType.summary, dateTimeStr, newDataInstance);

                      /// Reload the page
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileTabs(
                                  webId: webId,
                                  cvManager: cvManager,
                                )),
                        (Route<dynamic> route) =>
                            false, // This predicate ensures all previous routes are removed
                      );
                    } else {
                      // Show an error message if the address is invalid.
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Empty field!"),
                              content: const Text("Please enter a summary."),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          });
                    }

                    // if (medicareNumValid &&
                    //     medicareRefValid &&
                    //     medicareExpireValid) {
                    // Show an error message if the address is invalid.
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return AlertDialog(
                    //       title: Text("Invalid medicare number format"),
                    //       content: Text("Please enter a valid format."),
                    //       actions: <Widget>[
                    //         TextButton(
                    //           onPressed: () {
                    //             Navigator.of(context).pop();
                    //           },
                    //           child: Text("OK"),
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // );
                    //}
                  },
                  child: const Text("Save"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
              ],
            );
          });
        },
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: dataMap.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (SummaryItem sumRec in dataMap.values) ...[
                      const SizedBox(height: 15.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: bgCardLight,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: cardBorder),
                        ),
                        child: Stack(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(capitalize(DataType.summary.value),
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 25.0),
                              Text(sumRec.summary,
                                  style: const TextStyle(fontSize: 15)),
                              const SizedBox(height: 25.0),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                dataEditDialog(context, DataType.summary.tab,
                                    cvManager, webId, sumRec.createdTime);
                              },
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ],
                )
              : Column(
                  children: [
                    buildErrCard(
                      context,
                      Icons.clear,
                      appDarkBlue1,
                      'Warning!',
                      'You do not have a summary yet. Please add one.',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            addSummaryDialog();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(appDarkBlue1)),
                          child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Add Summary',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
