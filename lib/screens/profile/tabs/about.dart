/// About page
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

import 'package:cvpod/utils/data_edit_popups.dart';
import 'package:flutter/material.dart';

import 'package:solidpod/solidpod.dart';

import 'package:cvpod/constants/app.dart';
import 'package:cvpod/constants/file_paths.dart';
import 'package:cvpod/screens/profile/profile_tabs.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/utils/gen_turtle_struc.dart';
import 'package:cvpod/utils/misc.dart';
import 'package:cvpod/widgets/common_widgets.dart';
import 'package:cvpod/widgets/custom_progress_bar.dart';
import 'package:cvpod/constants/colors.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({
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
    TextEditingController nameController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController linkedinController = TextEditingController();
    TextEditingController webController = TextEditingController();

    void addAboutDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 50),
              title: const Text("Your personal info"),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                    hintText: 'first name and last name',
                  ),
                ),
                standardHeight(),
                TextField(
                  controller: genderController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Gender',
                    hintText: 'Male/Female/Other',
                  ),
                ),
                standardHeight(),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                    hintText: 'Your personal/work address',
                  ),
                ),
                standardHeight(),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Your email address',
                  ),
                ),
                standardHeight(),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone',
                    hintText: 'Your phone number',
                  ),
                ),
                standardHeight(),
                TextField(
                  controller: linkedinController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'LinkedIn',
                    hintText: 'Your LinkedIn profile link',
                  ),
                ),
                standardHeight(),
                TextField(
                  controller: webController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Web',
                    hintText: 'Your website link',
                  ),
                ),
              ]),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    String nameStr = nameController.text;
                    String genderStr = genderController.text;
                    String addressStr = addressController.text;
                    String emailStr = emailController.text;
                    String phoneStr = phoneController.text;
                    String linkedinStr = linkedinController.text;
                    String webStr = webController.text;

                    if (checkVarValidity(nameStr) ||
                        checkVarValidity(genderStr) ||
                        checkVarValidity(addressStr) ||
                        checkVarValidity(emailStr) ||
                        checkVarValidity(phoneStr) ||
                        checkVarValidity(linkedinStr) ||
                        checkVarValidity(webStr)) {
                      showAnimationDialog(
                        context,
                        24,
                        'Saving data',
                        false,
                      );

                      // Get date time
                      String dateTimeStr = getDateTimeStr();

                      // Create value map
                      Map aboutData = {
                        'createdTime': dateTimeStr,
                        'lastUpdatedTime': dateTimeStr,
                        'name': nameStr,
                        'gender': genderStr,
                        'address': addressStr,
                        'email': emailStr,
                        'phone': phoneStr,
                        'linkedin': linkedinStr,
                        'web': webStr,
                      };

                      // Generate summary ttl file entry
                      String bioRdf = genRdfLine(
                          aboutStr, aboutData, dateTimeStr, dateTimeStr);

                      // Generate ttl file body
                      String bioTtlBody =
                          genTtlFileBody(capitalize(aboutStr), bioRdf);

                      // Write content to the file. In this case the function will
                      // create a new file with the content on the server
                      await writePod(
                          aboutFile,
                          bioTtlBody,
                          context,
                          ProfileTabs(
                            webId: webId,
                            cvManager: cvManager,
                          ),
                          encrypted: false);

                      // update the cv manager
                      cvManager.updateCvData({'about': aboutData});

                      // Reload the page
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
                              title: const Text("No data!"),
                              content: const Text(
                                  "Please enter at least one data point."),
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

    double profCompletePer = calcProfComplete(dataMap);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: dataMap.isNotEmpty
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
                            const Text('About Me',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 25.0),
                            const Text('NAME',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: appDarkBlue2)),
                            Text(dataMap['name'],
                                style: const TextStyle(fontSize: 15)),
                            const SizedBox(height: 25.0),
                            const Text('GENDER',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: appDarkBlue2)),
                            Text(dataMap['gender'],
                                style: const TextStyle(fontSize: 15)),
                            const SizedBox(height: 25.0),
                            const Text('ADDRESS',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: appDarkBlue2)),
                            Text(dataMap['address'],
                                style: const TextStyle(fontSize: 15)),
                            const SizedBox(height: 25.0),
                            const Text('EMAIL',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: appDarkBlue2)),
                            Text(dataMap['email'],
                                style: const TextStyle(fontSize: 15)),
                            const SizedBox(height: 25.0),
                            const Text('PHONE',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: appDarkBlue2)),
                            Text(dataMap['phone'],
                                style: const TextStyle(fontSize: 15)),
                            const SizedBox(height: 25.0),
                            const Text('LINKEDIN',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: appDarkBlue2)),
                            Text(dataMap['linkedin'],
                                style: const TextStyle(fontSize: 15)),
                            const SizedBox(height: 25.0),
                            const Text('WEB',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: appDarkBlue2)),
                            Text(dataMap['web'],
                                style: const TextStyle(fontSize: 15)),
                            const SizedBox(height: 25.0),
                            CustomProgressBar(
                                skill: 'Personal profile complete',
                                porcentaje: profCompletePer.toInt().toString(),
                                color: appMidBlue2,
                                barra: screenWidth(context) *
                                    (profCompletePer / 100)),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              dataEditDialog(context, 1, cvManager, webId);
                            },
                          ),
                        ),
                      ]),
                    ),
                    //SizedBox(height: 15.0),
                    // Text('Interests', style: TextStyle(fontSize: 18)),
                    // SizedBox(height: 15.0),
                    // Column(
                    //   children: [
                    //     Row(children: [
                    //       Container(
                    //         padding: EdgeInsets.all(15.0),
                    //         decoration: BoxDecoration(
                    //             color: bgCardLight,
                    //             borderRadius: BorderRadius.circular(20.0),
                    //             border: Border.all(color: cardBorder)),
                    //         child: Text('Solid PODs',
                    //             style: TextStyle(fontSize: 15)),
                    //       ),
                    //       SizedBox(width: 10.0),
                    //       Container(
                    //         padding: EdgeInsets.all(15.0),
                    //         decoration: BoxDecoration(
                    //             color: bgCardLight,
                    //             borderRadius: BorderRadius.circular(20.0),
                    //             border: Border.all(color: cardBorder)),
                    //         child: Text('Federated Learning',
                    //             style: TextStyle(fontSize: 15)),
                    //       )
                    //     ])
                    //   ],
                    // )
                  ],
                )
              : Column(
                  children: [
                    buildErrCard(
                      context,
                      Icons.clear,
                      appDarkBlue1,
                      'Warning!',
                      'You have not added any personal data yet. Please add.',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            addAboutDialog();
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
                                  'Add About',
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
