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

import 'package:cvpod/api/rest_api.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/widgets/common_widgets.dart';
import 'package:cvpod/screens/profile/profile_tabs.dart';

final _formKey = GlobalKey<FormState>();

void dataEditDialog(
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
                    child: tabIndex == 0
                        ? editSum(context, cvManager, webId)
                        : editSum(context, cvManager, webId)
                    // : tabIndex == 3
                    //     ? newProfEntry(context, cvManager, webId)
                    //     : tabIndex == 4
                    //         ? newResEntry(context, cvManager, webId)
                    //         : tabIndex == 5
                    //             ? newPubEntry(context, cvManager, webId)
                    //             : tabIndex == 6
                    //                 ? newAwardEntry(
                    //                     context, cvManager, webId)
                    //                 : tabIndex == 7
                    //                     ? newPresEntry(
                    //                         context, cvManager, webId)
                    //                     : tabIndex == 8
                    //                         ? newExtraEntry(
                    //                             context, cvManager, webId)
                    //                         : newRefEntry(
                    //                             context, cvManager, webId)
                    ),
              ],
            ),
          ));
}

/// New professional entry popup
Column editSum(BuildContext context, CvManager cvManager, String webId) {
  TextEditingController formControllerSum =
      TextEditingController(text: cvManager.getSummary['summary']);
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
                'summary': summary,
              };

              Map prevDataMap = cvManager.getSummary;

              cvManager = await editProfileData(context, cvManager, webId,
                  'summary', newDataMap, prevDataMap);

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