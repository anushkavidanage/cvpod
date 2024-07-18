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

import 'package:cvpod/constants/app.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/apis/rest_api.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/widgets/common_widgets.dart';
import 'package:cvpod/screens/profile/profile_tabs.dart';

final _formKey = GlobalKey<FormState>();

/// Summary edit popup
Form editPres(BuildContext context, CvManager cvManager, String webId,
    String createdTime) {
  TextEditingController formControllerPres1 = TextEditingController(
      text: cvManager.getPresentations[createdTime]['description']);
  TextEditingController formControllerPres2 = TextEditingController(
      text: cvManager.getPresentations[createdTime]['url']);
  TextEditingController formControllerPres3 = TextEditingController(
      text: cvManager.getPresentations[createdTime]['year']);
  return Form(
    key: _formKey,
    child: Column(
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
            decoration: const InputDecoration(
                hintText: 'Url (Eg: https://youtu.be/...)'),
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
                    DataType.presentation, newDataMap, prevDataMap);

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
