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

import 'package:flutter/material.dart';

import 'package:cvpod/apis/rest_api.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/screens/profile/profile_tabs.dart';
import 'package:cvpod/constants/app.dart';

void dataDeleteDialog(
    BuildContext context, DataType dataType, CvManager cvManager, String webId,
    [String? createdTime]) {
  showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Please Confirm'),
          content:
              const Text('Are you sure you want to remove this permission?'),
          actions: [
            // The "Yes" button
            TextButton(
                onPressed: () async {
                  Object dataInstance =
                      cvManager.getCvData(dataType)[createdTime];

                  await deleteProfileData(
                      context, cvManager, dataType, dataInstance, createdTime!);

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
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: const Text('No'))
          ],
        );
      });
}
