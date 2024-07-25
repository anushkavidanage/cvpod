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
import 'package:cvpod/utils/cvData/professionalItem.dart';
import 'package:cvpod/utils/misc.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/apis/rest_api.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/widgets/loading_animation.dart';
import 'package:cvpod/screens/profile/profile_tabs.dart';

final _formKey = GlobalKey<FormState>();

/// New education entry popup
Form newProfEntry(BuildContext context, CvManager cvManager, String webId) {
  TextEditingController formControllerProf1 = TextEditingController();
  TextEditingController formControllerProf2 = TextEditingController();
  TextEditingController formControllerProf3 = TextEditingController();
  TextEditingController formControllerProf4 = TextEditingController();

  return Form(
      key: _formKey,
      child: Column(
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
                  final newDataInstance = ProfessionalItem(
                      dateTimeStr,
                      dateTimeStr,
                      formControllerProf1.text,
                      formControllerProf2.text,
                      formControllerProf3.text,
                      formControllerProf4.text);

                  cvManager = await writeProfileData(context, cvManager, webId,
                      DataType.professional, newDataInstance, dateTimeStr);

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
      ));
}
