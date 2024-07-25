/// Popups for editing new data.
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

import 'package:flutter/material.dart';

import 'package:cvpod/apis/rest_api.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/widgets/loading_animation.dart';
import 'package:cvpod/screens/profile/profile_tabs.dart';
import 'package:cvpod/constants/app.dart';
import 'package:cvpod/utils/cvData/researchItem.dart';
import 'package:cvpod/utils/misc.dart';

final _formKey = GlobalKey<FormState>();

/// Summary edit popup
Form editRes(BuildContext context, CvManager cvManager, String webId,
    String createdTime) {
  TextEditingController formControllerRes1 =
      TextEditingController(text: cvManager.getResearch[createdTime].title);
  TextEditingController formControllerRes2 =
      TextEditingController(text: cvManager.getResearch[createdTime].duration);
  TextEditingController formControllerRes3 =
      TextEditingController(text: cvManager.getResearch[createdTime].institute);
  TextEditingController formControllerRes4 =
      TextEditingController(text: cvManager.getResearch[createdTime].comments);
  return Form(
    key: _formKey,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            controller: formControllerRes1,
            decoration: const InputDecoration(
                hintText: 'Title (Eg: Federated Learning)'),
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

                // Previous data instance
                final prevDataInstance = cvManager.getResearch[createdTime];

                // Current date time
                String dateTimeStr = getDateTimeStr();

                // Create new instance
                final newDataInstance = ResearchItem(
                    createdTime,
                    dateTimeStr,
                    formControllerRes1.text,
                    formControllerRes2.text,
                    formControllerRes3.text,
                    formControllerRes4.text);

                cvManager = await editProfileData(
                    context,
                    cvManager,
                    DataType.research,
                    newDataInstance,
                    prevDataInstance,
                    createdTime);

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
    ),
  );
}
