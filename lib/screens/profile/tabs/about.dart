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

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:file_picker/file_picker.dart';

import 'package:cvpod/constants/app.dart';
import 'package:cvpod/screens/profile/profile_tabs.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/utils/gen_turtle_struc.dart';
import 'package:cvpod/utils/misc.dart';
import 'package:cvpod/widgets/common_widgets.dart';
import 'package:cvpod/widgets/custom_progress_bar.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/utils/cvData/aboutItem.dart';
import 'package:cvpod/widgets/popups/edit/tab_select.dart';
import 'package:cvpod/apis/rest_api.dart';
import 'package:cvpod/utils/alert.dart';
import 'package:solidpod/solidpod.dart';

class AboutMe extends StatefulWidget {
  /// Constructs a `DiaryDataScreen` widget.
  ///
  /// The `authData` parameter is the authentication data
  /// necessary for the diary operations.
  ///
  /// The `webId` parameter is the web identifier used for unique
  /// identification in web operations.
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
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  String? uploadFileSelect;

  Widget? profileImage;

  @override
  void initState() {
    super.initState();
    profileImage = widget.cvManager.portraitBytes != null
        ? Image.memory(widget.cvManager.portraitBytes as Uint8List)
        : Image.asset('assets/images/avatar.png');
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController positionController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController linkedinController = TextEditingController();
    TextEditingController webController = TextEditingController();

    final browseButton = ElevatedButton(
      onPressed: () async {
        final result = await FilePicker.platform.pickFiles();
        if (result != null) {
          if (['jpg', 'jpeg']
              .contains(result.files.single.path!.split('.').last)) {
            setState(() {
              uploadFileSelect = result.files.single.path!;
            });
          } else {
            if (!context.mounted) return;
            await alert(context, 'Image must be either jpeg or jpg.');
          }
        }
      },
      child: const Text('Browse'),
    );

    final readImageButton = ElevatedButton(
      onPressed: () async {
        final fileUrl = await getFileUrl('cvpod/data/pro-pic.jpeg');
        var imageData = await httpRequestImg(
          fileUrl,
          ResourceContentType.image,
        );
        setState(() {
          profileImage = Image.memory(imageData);
        });
      },
      child: const Text('Read'),
    );

    final uploadButton = ElevatedButton(
      onPressed: () async {
        setState(() {
          profileImage = const CircularProgressIndicator();
        });
        final fileBytes = await File(uploadFileSelect!).readAsBytes();
        var uploadRes =
            await uploadFile(profPicPath, fileBytes, ResourceContentType.image);
        if (uploadRes) {
          widget.cvManager.portraitBytes = fileBytes;
          setState(() {
            profileImage = Image.memory(fileBytes);
          });
        }
      },
      child: const Text('Upload'),
    );

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
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Current Position',
                    hintText: 'Eg: Creative Designer',
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

                      // Create new instance
                      final newDataInstance = AboutItem(
                          dateTimeStr,
                          dateTimeStr,
                          nameController.text,
                          positionController.text,
                          genderController.text,
                          addressController.text,
                          emailController.text,
                          phoneController.text,
                          linkedinController.text,
                          webController.text);

                      // Generate summary ttl file entry
                      String aboutRdf = genAboutRdfLine(newDataInstance);

                      // Generate ttl file body
                      String bioTtlBody = genTtlFileBody(
                          capitalize(DataType.about.label), aboutRdf);

                      // Write content to the file. In this case the function will
                      // create a new file with the content on the server
                      await writePod(
                          DataType.about.ttlFile,
                          bioTtlBody,
                          context,
                          ProfileTabs(
                            webId: widget.webId,
                            cvManager: widget.cvManager,
                          ),
                          encrypted: false);

                      // update the cv manager
                      widget.cvManager.updateCvData(
                          DataType.about, dateTimeStr, newDataInstance);

                      // Reload the page
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileTabs(
                                  webId: widget.webId,
                                  cvManager: widget.cvManager,
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

    //double profCompletePer = calcProfComplete(dataMap);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: widget.dataMap.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            children: [
                              const Text('Profile Picture',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 15.0),
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),

                                //add border radius here
                                child: Container(
                                  height: 200.0,
                                  width: 200.0,
                                  color: cardBorder,
                                  child: profileImage,
                                ), //add image location here
                              ),
                              const SizedBox(height: 15.0),
                              Text(
                                uploadFileSelect ??
                                    'Click the Browse button to choose a file (jpeg/jpg only). For a better performance select a file less than 300x300px.',
                                style: TextStyle(
                                  color: uploadFileSelect == null
                                      ? infoRed
                                      : appMidBlue2,
                                  // fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Row(
                                children: [
                                  browseButton,
                                  const SizedBox(width: 10.0),
                                  readImageButton,
                                  const SizedBox(width: 10.0),
                                  uploadFileSelect != null
                                      ? uploadButton
                                      : const SizedBox(height: 0.0),
                                ],
                              ),
                            ],
                          ),
                        ])),
                    for (AboutItem aboutRec in widget.dataMap.values) ...[
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
                              const Text('Personal Info',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 25.0),
                              Text(AboutLiteral.name.label.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: appDarkBlue2)),
                              Text(aboutRec.name,
                                  style: const TextStyle(fontSize: 15)),
                              const SizedBox(height: 25.0),
                              const Text('GENDER',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: appDarkBlue2)),
                              Text(aboutRec.gender,
                                  style: const TextStyle(fontSize: 15)),
                              const SizedBox(height: 25.0),
                              const Text('ADDRESS',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: appDarkBlue2)),
                              Text(aboutRec.address,
                                  style: const TextStyle(fontSize: 15)),
                              const SizedBox(height: 25.0),
                              const Text('EMAIL',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: appDarkBlue2)),
                              Text(aboutRec.email,
                                  style: const TextStyle(fontSize: 15)),
                              const SizedBox(height: 25.0),
                              const Text('PHONE',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: appDarkBlue2)),
                              Text(aboutRec.phone,
                                  style: const TextStyle(fontSize: 15)),
                              const SizedBox(height: 25.0),
                              const Text('LINKEDIN',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: appDarkBlue2)),
                              Text(aboutRec.linkedin,
                                  style: const TextStyle(fontSize: 15)),
                              const SizedBox(height: 25.0),
                              const Text('WEB',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: appDarkBlue2)),
                              Text(aboutRec.web,
                                  style: const TextStyle(fontSize: 15)),
                              const SizedBox(height: 25.0),
                              // CustomProgressBar(
                              //     skill: 'Personal profile complete',
                              //     porcentaje:
                              //         profCompletePer.toInt().toString(),
                              //     color: appMidBlue2,
                              //     barra: screenWidth(context) *
                              //         (profCompletePer / 100)),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                dataEditDialog(
                                    context,
                                    DataType.about.tab,
                                    widget.cvManager,
                                    widget.webId,
                                    aboutRec.createdTime);
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
                    ]
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
