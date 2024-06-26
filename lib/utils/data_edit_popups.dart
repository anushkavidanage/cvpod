/// Popups for adding new data.
///
/// Copyright (C) 2024, Software Innovation Institute
///
/// Licensed under the GNU General Public License, Version 3 (the "License");
///
/// License: https://www.gnu.org/licenses/gpl-3.0.en.html
//
// Time-stamp: <Wednesday 2023-11-01 08:26:39 +1100 Graham Williams>
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

import 'package:cvpod/constants/app.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/api/rest_api.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/widgets/common_widgets.dart';
import 'package:cvpod/screens/profile/profile_tabs.dart';
import 'package:flutter/services.dart';

final _formKey = GlobalKey<FormState>();

void dataEditDialog(
    BuildContext context, int tabIndex, CvManager cvManager, String webId,
    [String? createdTime]) {
  showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -40,
                  top: -40,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      backgroundColor: appMidBlue1,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: tabIndex == 0
                        ? editSum(context, cvManager, webId)
                        : tabIndex == 1
                            ? editAbout(context, cvManager, webId)
                            : tabIndex == 2
                                ? editEdu(
                                    context, cvManager, webId, createdTime!)
                                : tabIndex == 3
                                    ? editProf(
                                        context, cvManager, webId, createdTime!)
                                    : tabIndex == 4
                                        ? editRes(context, cvManager, webId,
                                            createdTime!)
                                        : tabIndex == 5
                                            ? editPub(context, cvManager, webId,
                                                createdTime!)
                                            : tabIndex == 6
                                                ? editAward(context, cvManager,
                                                    webId, createdTime!)
                                                : tabIndex == 7
                                                    ? editPres(
                                                        context,
                                                        cvManager,
                                                        webId,
                                                        createdTime!)
                                                    : tabIndex == 8
                                                        ? editExtra(
                                                            context,
                                                            cvManager,
                                                            webId,
                                                            createdTime!)
                                                        : editRef(
                                                            context,
                                                            cvManager,
                                                            webId,
                                                            createdTime!)),
              ],
            ),
          ));
}

/// Summary edit popup
Column editSum(BuildContext context, CvManager cvManager, String webId) {
  TextEditingController formControllerSum =
      TextEditingController(text: cvManager.getSummary[summaryStr]);
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerSum,
          maxLines: 3,
          //initialValue: cvManager.getSummary,
          decoration: const InputDecoration(hintText: 'Summary about yourself'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          child: const Text('Save Changes'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.save();

              showAnimationDialog(
                context,
                24,
                'Saving changes',
                false,
              );

              String summary = formControllerSum.text;

              Map newDataMap = {
                summaryStr: summary,
              };

              Map prevDataMap = cvManager.getSummary;

              cvManager = await editProfileData(
                  context, cvManager, summaryStr, newDataMap, prevDataMap);

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
            }
          },
        ),
      )
    ],
  );
}

/// About edit popup
Column editAbout(BuildContext context, CvManager cvManager, String webId) {
  TextEditingController nameController =
      TextEditingController(text: cvManager.getAbout['name']);
  TextEditingController positionController =
      TextEditingController(text: cvManager.getAbout['position']);
  TextEditingController genderController =
      TextEditingController(text: cvManager.getAbout['gender']);
  TextEditingController addressController =
      TextEditingController(text: cvManager.getAbout['address']);
  TextEditingController phoneController =
      TextEditingController(text: cvManager.getAbout['phone']);
  TextEditingController emailController =
      TextEditingController(text: cvManager.getAbout['email']);
  TextEditingController linkedinController =
      TextEditingController(text: cvManager.getAbout['linkedin']);
  TextEditingController webController =
      TextEditingController(text: cvManager.getAbout['web']);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: nameController,
          decoration: const InputDecoration(hintText: 'Full name'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: positionController,
          decoration: const InputDecoration(hintText: 'Current position'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: genderController,
          decoration:
              const InputDecoration(hintText: 'Gender (Male/Female/Other)'),
          keyboardType: TextInputType.text,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: addressController,
          decoration: const InputDecoration(hintText: 'Address'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: emailController,
          decoration: const InputDecoration(hintText: 'Email address'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: phoneController,
          decoration: const InputDecoration(hintText: 'Phone number'),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp("[+0-9]")),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: linkedinController,
          decoration: const InputDecoration(hintText: 'Linkedin profile link'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: webController,
          decoration: const InputDecoration(hintText: 'Website link'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          child: const Text('Save Changes'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.save();

              showAnimationDialog(
                context,
                24,
                'Saving changes',
                false,
              );

              String nameStr = nameController.text;
              String positionStr = positionController.text;
              String genderStr = genderController.text;
              String addressStr = addressController.text;
              String emailStr = emailController.text;
              String phoneStr = phoneController.text;
              String linkedinStr = linkedinController.text;
              String webStr = webController.text;

              Map newDataMap = {
                'name': nameStr,
                'position': positionStr,
                'gender': genderStr,
                'address': addressStr,
                'email': emailStr,
                'phone': phoneStr,
                'linkedin': linkedinStr,
                'web': webStr,
              };

              Map prevDataMap = cvManager.getAbout;

              cvManager = await editProfileData(
                  context, cvManager, aboutStr, newDataMap, prevDataMap);

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
            }
          },
        ),
      )
    ],
  );
}

/// Education edit popup
Column editEdu(BuildContext context, CvManager cvManager, String webId,
    String createdTime) {
  TextEditingController formControllerEdu1 = TextEditingController(
      text: cvManager.getEducation[createdTime]['degree']);
  TextEditingController formControllerEdu2 = TextEditingController(
      text: cvManager.getEducation[createdTime]['duration']);
  TextEditingController formControllerEdu3 = TextEditingController(
      text: cvManager.getEducation[createdTime]['institute']);
  TextEditingController formControllerEdu4 = TextEditingController(
      text: cvManager.getEducation[createdTime]['comments']);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerEdu1,
          decoration: const InputDecoration(
              hintText: 'Degree (Eg: Bachelor of Computing)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerEdu2,
          decoration:
              const InputDecoration(hintText: 'Duration (Eg: 2014-2018)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerEdu3,
          decoration: const InputDecoration(
              hintText: 'Institute (Eg: University of Melbourne)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerEdu4,
          maxLines: 2,
          decoration: const InputDecoration(
              hintText:
                  'Comments (Eg: 1st class [divide multiple comments by ;])'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          child: const Text('Save Changes'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.save();

              showAnimationDialog(
                context,
                24,
                'Saving changes',
                false,
              );

              String degree = formControllerEdu1.text;
              String duration = formControllerEdu2.text;
              String institute = formControllerEdu3.text;
              String comments = formControllerEdu4.text;

              Map newDataMap = {
                'degree': degree,
                'duration': duration,
                'institute': institute,
                'comments': comments,
              };

              Map prevDataMap = cvManager.getEducation[createdTime];

              cvManager = await editProfileData(
                  context, cvManager, educationStr, newDataMap, prevDataMap);

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
            }
          },
        ),
      )
    ],
  );
}

/// Professional edit popup
Column editProf(BuildContext context, CvManager cvManager, String webId,
    String createdTime) {
  TextEditingController formControllerProf1 = TextEditingController(
      text: cvManager.getProfessional[createdTime]['title']);
  TextEditingController formControllerProf2 = TextEditingController(
      text: cvManager.getProfessional[createdTime]['duration']);
  TextEditingController formControllerProf3 = TextEditingController(
      text: cvManager.getProfessional[createdTime]['company']);
  TextEditingController formControllerProf4 = TextEditingController(
      text: cvManager.getProfessional[createdTime]['comments']);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerProf1,
          decoration: const InputDecoration(
              hintText: 'Title (Eg: Junior Software Engineer)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerProf2,
          decoration:
              const InputDecoration(hintText: 'Duration (Eg: 2014-2018)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerProf3,
          decoration: const InputDecoration(
              hintText: 'Company (Eg: Cornerstone, Victoria, Australia)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerProf4,
          maxLines: 2,
          decoration: const InputDecoration(
              hintText:
                  'Comments (Eg: Build RESTful APIs [divide multiple comments by ;])'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          child: const Text('Save Changes'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.save();

              showAnimationDialog(
                context,
                24,
                'Saving changes',
                false,
              );

              String title = formControllerProf1.text;
              String duration = formControllerProf2.text;
              String company = formControllerProf3.text;
              String comments = formControllerProf4.text;

              Map newDataMap = {
                'title': title,
                'duration': duration,
                'company': company,
                'comments': comments,
              };

              Map prevDataMap = cvManager.getProfessional[createdTime];

              cvManager = await editProfileData(
                  context, cvManager, professionalStr, newDataMap, prevDataMap);

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
            }
          },
        ),
      )
    ],
  );
}

/// Research edit popup
Column editRes(BuildContext context, CvManager cvManager, String webId,
    String createdTime) {
  TextEditingController formControllerRes1 =
      TextEditingController(text: cvManager.getResearch[createdTime]['title']);
  TextEditingController formControllerRes2 = TextEditingController(
      text: cvManager.getResearch[createdTime]['duration']);
  TextEditingController formControllerRes3 = TextEditingController(
      text: cvManager.getResearch[createdTime]['institute']);
  TextEditingController formControllerRes4 = TextEditingController(
      text: cvManager.getResearch[createdTime]['comments']);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerRes1,
          decoration:
              const InputDecoration(hintText: 'Title (Eg: Federated Learning)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerRes2,
          decoration: const InputDecoration(
              hintText: 'Duration (Eg: Apr 2019-Present)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerRes3,
          decoration: const InputDecoration(
              hintText: 'Institute (Eg: University of Melbourne)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerRes4,
          maxLines: 2,
          decoration: const InputDecoration(
              hintText:
                  'Comments (Eg: Develop Federated Learning algorithms [divide multiple comments by ;])'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          child: const Text('Save Changes'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.save();

              showAnimationDialog(
                context,
                24,
                'Saving changes',
                false,
              );

              String title = formControllerRes1.text;
              String duration = formControllerRes2.text;
              String institute = formControllerRes3.text;
              String comments = formControllerRes4.text;

              Map newDataMap = {
                'title': title,
                'duration': duration,
                'institute': institute,
                'comments': comments,
              };

              Map prevDataMap = cvManager.getResearch[createdTime];

              cvManager = await editProfileData(
                  context, cvManager, researchStr, newDataMap, prevDataMap);

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
            }
          },
        ),
      )
    ],
  );
}

/// Publications edit popup
Column editPub(BuildContext context, CvManager cvManager, String webId,
    String createdTime) {
  TextEditingController formControllerPub1 = TextEditingController(
      text: cvManager.getPublications[createdTime]['citation']);
  TextEditingController formControllerPub2 = TextEditingController(
      text: cvManager.getPublications[createdTime]['year']);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerPub1,
          decoration: const InputDecoration(
              hintText:
                  'Citation (Eg: Anushka Vidanage. 2023. Access and Consent Management using Personal Online Datastores. In the 21st AusDM. Auckland, New Zealand. Tutorial.)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerPub2,
          decoration: const InputDecoration(hintText: 'Year (Eg: 2023)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          child: const Text('Save Changes'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.save();

              showAnimationDialog(
                context,
                24,
                'Saving changes',
                false,
              );

              String citation = formControllerPub1.text;
              String year = formControllerPub2.text;

              Map newDataMap = {
                'citation': citation,
                'year': year,
              };

              Map prevDataMap = cvManager.getPublications[createdTime];

              cvManager = await editProfileData(
                  context, cvManager, publicationsStr, newDataMap, prevDataMap);

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
            }
          },
        ),
      )
    ],
  );
}

/// Award edit popup
Column editAward(BuildContext context, CvManager cvManager, String webId,
    String createdTime) {
  TextEditingController formControllerAwd1 =
      TextEditingController(text: cvManager.getAwards[createdTime]['title']);
  TextEditingController formControllerAwd2 =
      TextEditingController(text: cvManager.getAwards[createdTime]['year']);
  TextEditingController formControllerAwd3 = TextEditingController(
      text: cvManager.getAwards[createdTime]['description']);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerAwd1,
          decoration: const InputDecoration(hintText: 'Title (Eg: DAAD Fund)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerAwd2,
          decoration: const InputDecoration(hintText: 'Year (Eg: 2019)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerAwd3,
          maxLines: 2,
          decoration: const InputDecoration(
              hintText:
                  'Description (Eg: For the research of secure binary encodings [divide multiple comments by ;])'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          child: const Text('Save Changes'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.save();

              showAnimationDialog(
                context,
                24,
                'Saving changes',
                false,
              );

              String title = formControllerAwd1.text;
              String year = formControllerAwd2.text;
              String description = formControllerAwd3.text;

              Map newDataMap = {
                'title': title,
                'year': year,
                'description': description,
              };

              Map prevDataMap = cvManager.getAwards[createdTime];

              cvManager = await editProfileData(
                  context, cvManager, awardsStr, newDataMap, prevDataMap);

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
            }
          },
        ),
      )
    ],
  );
}

/// Presentation edit popup
Column editPres(BuildContext context, CvManager cvManager, String webId,
    String createdTime) {
  TextEditingController formControllerPres1 = TextEditingController(
      text: cvManager.getPresentations[createdTime]['description']);
  TextEditingController formControllerPres2 = TextEditingController(
      text: cvManager.getPresentations[createdTime]['url']);
  TextEditingController formControllerPres3 = TextEditingController(
      text: cvManager.getPresentations[createdTime]['year']);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerPres1,
          maxLines: 2,
          decoration: const InputDecoration(
              hintText:
                  'Description (Eg: Presenter - Building Health Software)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerPres2,
          decoration:
              const InputDecoration(hintText: 'Url (Eg: https://youtu.be/...)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerPres3,
          decoration: const InputDecoration(hintText: 'Year (Eg: 2020)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          child: const Text('Save Changes'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.save();

              showAnimationDialog(
                context,
                24,
                'Saving changes',
                false,
              );

              String description = formControllerPres1.text;
              String url = formControllerPres2.text;
              String year = formControllerPres3.text;

              Map newDataMap = {
                'description': description,
                'url': url,
                'year': year,
              };

              Map prevDataMap = cvManager.getPresentations[createdTime];

              cvManager = await editProfileData(context, cvManager,
                  presentationsStr, newDataMap, prevDataMap);

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
            }
          },
        ),
      )
    ],
  );
}

/// Extra edit popup
Column editExtra(BuildContext context, CvManager cvManager, String webId,
    String createdTime) {
  TextEditingController formControllerEx1 = TextEditingController(
      text: cvManager.getExtra[createdTime]['description']);
  TextEditingController formControllerEx2 =
      TextEditingController(text: cvManager.getExtra[createdTime]['duration']);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerEx1,
          decoration: const InputDecoration(
              hintText: 'Description (Eg: Volunteer - ANU Open Day)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerEx2,
          decoration:
              const InputDecoration(hintText: 'Duration/Year (Eg: Jul 2019)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          child: const Text('Save Changes'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.save();

              showAnimationDialog(
                context,
                24,
                'Saving changes',
                false,
              );

              String description = formControllerEx1.text;
              String duration = formControllerEx2.text;

              Map newDataMap = {
                'description': description,
                'duration': duration,
              };

              Map prevDataMap = cvManager.getExtra[createdTime];

              cvManager = await editProfileData(
                  context, cvManager, extraStr, newDataMap, prevDataMap);

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
            }
          },
        ),
      )
    ],
  );
}

/// Extra edit popup
Column editRef(BuildContext context, CvManager cvManager, String webId,
    String createdTime) {
  TextEditingController formControllerRef1 =
      TextEditingController(text: cvManager.getReferees[createdTime]['name']);
  TextEditingController formControllerRef2 = TextEditingController(
      text: cvManager.getReferees[createdTime]['position']);
  TextEditingController formControllerRef3 =
      TextEditingController(text: cvManager.getReferees[createdTime]['email']);
  TextEditingController formControllerRef4 = TextEditingController(
      text: cvManager.getReferees[createdTime]['institute']);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerRef1,
          decoration: const InputDecoration(hintText: 'Name (Eg: Steven West)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerRef2,
          decoration: const InputDecoration(
              hintText: 'Position (Eg: Senior Architect)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerRef3,
          decoration: const InputDecoration(
              hintText: 'Email (Eg: steven.west@company.com.au)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerRef4,
          decoration: const InputDecoration(
              hintText:
                  'Institute (Eg: Microsoft Online Services Division, Sydney)'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Empty field';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          child: const Text('Save Changes'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.save();

              showAnimationDialog(
                context,
                24,
                'Saving changes',
                false,
              );

              String name = formControllerRef1.text;
              String position = formControllerRef2.text;
              String email = formControllerRef3.text;
              String institute = formControllerRef4.text;

              Map newDataMap = {
                'name': name,
                'position': position,
                'institute': institute,
                'email': email,
              };

              Map prevDataMap = cvManager.getReferees[createdTime];

              cvManager = await editProfileData(
                  context, cvManager, refereesStr, newDataMap, prevDataMap);

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
            }
          },
        ),
      )
    ],
  );
}
