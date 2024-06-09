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

import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/constants/sample_content.dart';
import 'package:cvpod/widgets/common_widgets.dart';

class Summary extends StatelessWidget {
  const Summary({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    TextEditingController summaryController = TextEditingController();

    void updateMedicareNumber() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 50),
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
                    // bool medicareNumValid =
                    //     isValidField(medicareNumController.text, 'medicareNum');
                    // bool medicareRefValid =
                    //     isValidField(medicareRefController.text, 'medicareRef');
                    // bool medicareExpireValid = isValidField(
                    //     medicareExpireController.text, 'medicareExpire');

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
                  child: Text("Save"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
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
          child: data != ''
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.0),
                    Container(
                      padding: EdgeInsets.symmetric(
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
                            const Text('Summary',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 25.0),
                            Text(summary, style: const TextStyle(fontSize: 15)),
                            const SizedBox(height: 25.0),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // ...
                            },
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 15.0),
                  ],
                )
              : Column(
                  children: [
                    buildErrCard(
                      context,
                      Icons.clear,
                      appDarkBlue1,
                      'Warning!',
                      'You do not have summary yet. Please add one.',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          updateMedicareNumber();
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
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}