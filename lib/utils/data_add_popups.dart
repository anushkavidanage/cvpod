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

import 'package:cvpod/screens/profile/profile_tabs.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/api/rest_api.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/utils/cv_managet.dart';
import 'package:cvpod/widgets/common_widgets.dart';

final _formKey = GlobalKey<FormState>();

TextEditingController formControllerEdu1 = TextEditingController();
TextEditingController formControllerEdu2 = TextEditingController();
TextEditingController formControllerEdu3 = TextEditingController();
TextEditingController formControllerEdu4 = TextEditingController();

TextEditingController formControllerProf1 = TextEditingController();
TextEditingController formControllerProf2 = TextEditingController();
TextEditingController formControllerProf3 = TextEditingController();
TextEditingController formControllerProf4 = TextEditingController();

TextEditingController formControllerRes1 = TextEditingController();
TextEditingController formControllerRes2 = TextEditingController();
TextEditingController formControllerRes3 = TextEditingController();
TextEditingController formControllerRes4 = TextEditingController();

TextEditingController formControllerPub1 = TextEditingController();
TextEditingController formControllerPub2 = TextEditingController();

TextEditingController formControllerAwd1 = TextEditingController();
TextEditingController formControllerAwd2 = TextEditingController();
TextEditingController formControllerAwd3 = TextEditingController();

TextEditingController formControllerPres1 = TextEditingController();
TextEditingController formControllerPres2 = TextEditingController();
TextEditingController formControllerPres3 = TextEditingController();

TextEditingController formControllerEx1 = TextEditingController();
TextEditingController formControllerEx2 = TextEditingController();

TextEditingController formControllerRef1 = TextEditingController();
TextEditingController formControllerRef2 = TextEditingController();
TextEditingController formControllerRef3 = TextEditingController();
TextEditingController formControllerRef4 = TextEditingController();

void dataAddDialog(
    BuildContext context, int tabIndex, CvManager cvManager, String webId) {
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
                    child: tabIndex == 2
                        ? newEduEntry(context, cvManager, webId)
                        : tabIndex == 3
                            ? newProfEntry(context, cvManager, webId)
                            : tabIndex == 4
                                ? newResEntry(context, cvManager, webId)
                                : tabIndex == 5
                                    ? newPubEntry(context, cvManager, webId)
                                    : tabIndex == 6
                                        ? newAwardEntry(
                                            context, cvManager, webId)
                                        : tabIndex == 7
                                            ? newPresEntry(
                                                context, cvManager, webId)
                                            : tabIndex == 8
                                                ? newExtraEntry(
                                                    context, cvManager, webId)
                                                : newRefEntry(
                                                    context, cvManager, webId)),
              ],
            ),
          ));
}

/// New education entry popup
Column newEduEntry(BuildContext context, CvManager cvManager, String webId) {
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
                  'Comments (Eg: 1st class [divide multiple comments by #])'),
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
          child: const Text('Save Entry'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.save();

              showAnimationDialog(
                context,
                24,
                'Saving data',
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

              cvManager = await writeProfileData(
                  context, cvManager, webId, 'education', newDataMap);

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

/// New professional entry popup
Column newProfEntry(BuildContext context, CvManager cvManager, String webId) {
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
              const InputDecoration(hintText: 'Duration (Eg: 2019-2021)'),
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
                  'Comments (Eg: Build RESTful APIs [divide multiple comments by #])'),
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
          child: const Text('Save Entry'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.s3ave();

              showAnimationDialog(
                context,
                24,
                'Saving data',
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

              cvManager = await writeProfileData(
                  context, cvManager, webId, 'professional', newDataMap);

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

/// New professional entry popup
Column newResEntry(BuildContext context, CvManager cvManager, String webId) {
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
                  'Comments (Eg: Develop Federated Learning algorithms [divide multiple comments by #])'),
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
          child: const Text('Save Entry'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.s3ave();

              showAnimationDialog(
                context,
                24,
                'Saving data',
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

              cvManager = await writeProfileData(
                  context, cvManager, webId, 'research', newDataMap);

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

/// New professional entry popup
Column newPubEntry(BuildContext context, CvManager cvManager, String webId) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          controller: formControllerPub1,
          decoration: const InputDecoration(
              hintText:
                  'Citation (Eg: Anushka Vidanage, Jessica Moore, Graham Williams. 2023. “Data Privacy: Access and Consent Management using Personal Online Datastores - a Hand\'s on Primer”. In the 21st Australasian Data Mining Conference. Auckland, New Zealand. Tutorial.)'),
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
          child: const Text('Save Entry'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.s3ave();

              showAnimationDialog(
                context,
                24,
                'Saving data',
                false,
              );

              String citation = formControllerPub1.text;
              String year = formControllerPub2.text;

              Map newDataMap = {
                'citation': citation,
                'year': year,
              };

              cvManager = await writeProfileData(
                  context, cvManager, webId, 'publications', newDataMap);

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

/// New awards entry popup
Column newAwardEntry(BuildContext context, CvManager cvManager, String webId) {
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
                  'Description (Eg: For the research of secure binary encodings [divide multiple comments by #])'),
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
          child: const Text('Save Entry'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.s3ave();

              showAnimationDialog(
                context,
                24,
                'Saving data',
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

              cvManager = await writeProfileData(
                  context, cvManager, webId, 'awards', newDataMap);

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

/// New presentations entry popup
Column newPresEntry(BuildContext context, CvManager cvManager, String webId) {
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
          child: const Text('Save Entry'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.s3ave();

              showAnimationDialog(
                context,
                24,
                'Saving data',
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

              cvManager = await writeProfileData(
                  context, cvManager, webId, 'presentations', newDataMap);

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

/// New extra entry popup
Column newExtraEntry(BuildContext context, CvManager cvManager, String webId) {
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
          child: const Text('Save Entry'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.s3ave();

              showAnimationDialog(
                context,
                24,
                'Saving data',
                false,
              );

              String description = formControllerEx1.text;
              String duration = formControllerEx2.text;

              Map newDataMap = {
                'description': description,
                'duration': duration,
              };

              cvManager = await writeProfileData(
                  context, cvManager, webId, 'extra', newDataMap);

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

/// New referees entry popup
Column newRefEntry(BuildContext context, CvManager cvManager, String webId) {
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
          child: const Text('Save Entry'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.s3ave();

              showAnimationDialog(
                context,
                24,
                'Saving data',
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

              cvManager = await writeProfileData(
                  context, cvManager, webId, 'referees', newDataMap);

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
