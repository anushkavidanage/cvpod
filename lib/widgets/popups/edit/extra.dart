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
import 'package:cvpod/utils/cvData/extraItem.dart';
import 'package:cvpod/utils/misc.dart';

final _formKey = GlobalKey<FormState>();

/// Summary edit popup
Form editExtra(BuildContext context, CvManager cvManager, String webId,
    String createdTime) {
  TextEditingController formControllerEx1 =
      TextEditingController(text: cvManager.getExtra[createdTime].description);
  TextEditingController formControllerEx2 =
      TextEditingController(text: cvManager.getExtra[createdTime].duration);
  return Form(
    key: _formKey,
    child: Column(
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

                // Previous data instance
                final prevDataInstance = cvManager.getExtra[createdTime];

                // Current date time
                String dateTimeStr = getDateTimeStr();

                // Create new instance
                final newDataInstance = ExtraItem(createdTime, dateTimeStr,
                    formControllerEx1.text, formControllerEx2.text);

                cvManager = await editProfileData(
                    context,
                    cvManager,
                    DataType.extra,
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
