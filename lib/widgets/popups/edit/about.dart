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
import 'package:flutter/services.dart';

import 'package:cvpod/constants/app.dart';
import 'package:cvpod/apis/rest_api.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/widgets/loading_animation.dart';
import 'package:cvpod/screens/profile/profile_tabs.dart';
import 'package:cvpod/utils/cvData/aboutItem.dart';
import 'package:cvpod/utils/misc.dart';

final _formKey = GlobalKey<FormState>();

/// Summary edit popup
Form editAbout(BuildContext context, CvManager cvManager, String webId,
    String createdTime) {
  TextEditingController nameController =
      TextEditingController(text: cvManager.getAbout[createdTime].name);
  TextEditingController positionController =
      TextEditingController(text: cvManager.getAbout[createdTime].position);
  TextEditingController genderController =
      TextEditingController(text: cvManager.getAbout[createdTime].gender);
  TextEditingController addressController =
      TextEditingController(text: cvManager.getAbout[createdTime].address);
  TextEditingController phoneController =
      TextEditingController(text: cvManager.getAbout[createdTime].phone);
  TextEditingController emailController =
      TextEditingController(text: cvManager.getAbout[createdTime].email);
  TextEditingController linkedinController =
      TextEditingController(text: cvManager.getAbout[createdTime].linkedin);
  TextEditingController webController =
      TextEditingController(text: cvManager.getAbout[createdTime].web);

  return Form(
    key: _formKey,
    child: Column(
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
            decoration:
                const InputDecoration(hintText: 'Linkedin profile link'),
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

                // Previous data instance
                final prevDataInstance = cvManager.getAbout[createdTime];

                // Current date time
                String dateTimeStr = getDateTimeStr();

                // Create new instance
                final newDataInstance = AboutItem(
                    createdTime,
                    dateTimeStr,
                    nameController.text,
                    positionController.text,
                    genderController.text,
                    addressController.text,
                    emailController.text,
                    phoneController.text,
                    linkedinController.text,
                    webController.text);

                cvManager = await editProfileData(
                    context,
                    cvManager,
                    DataType.about,
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
