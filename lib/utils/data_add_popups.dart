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
                            ? newProfEntry()
                            : newEduEntry(context, cvManager, webId)),
              ],
            ),
          ));
}

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
              //final formData = _formKey.currentState?.save();

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

Column newProfEntry() {
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.s3ave();
              print(formControllerProf1.text);
            }
          },
        ),
      )
    ],
  );
}
