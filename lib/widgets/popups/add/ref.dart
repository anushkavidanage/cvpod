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
import 'package:cvpod/utils/cvData/refereeItem.dart';
import 'package:cvpod/utils/misc.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/apis/rest_api.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/widgets/loading_animation.dart';
import 'package:cvpod/screens/profile/profile_tabs.dart';

final _formKey = GlobalKey<FormState>();

/// New education entry popup
Form newRefEntry(BuildContext context, CvManager cvManager, String webId) {
  TextEditingController formControllerRef1 = TextEditingController();
  TextEditingController formControllerRef2 = TextEditingController();
  TextEditingController formControllerRef3 = TextEditingController();
  TextEditingController formControllerRef4 = TextEditingController();

  return Form(
    key: _formKey,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            controller: formControllerRef1,
            decoration:
                const InputDecoration(hintText: 'Name (Eg: Steven West)'),
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

                // Current date time
                String dateTimeStr = getDateTimeStr();

                // Create new instance
                final newDataInstance = RefereeItem(
                  dateTimeStr,
                  dateTimeStr,
                  formControllerRef1.text,
                  formControllerRef2.text,
                  formControllerRef4.text,
                  formControllerRef3.text,
                );

                cvManager = await writeProfileData(context, cvManager, webId,
                    DataType.referee, newDataInstance, dateTimeStr);

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
