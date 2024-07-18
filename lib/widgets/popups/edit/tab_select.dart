/// Selecting tabs for data edit popups.
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

import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/widgets/popups/edit/about.dart';
import 'package:cvpod/widgets/popups/edit/award.dart';
import 'package:cvpod/widgets/popups/edit/edu.dart';
import 'package:cvpod/widgets/popups/edit/extra.dart';
import 'package:cvpod/widgets/popups/edit/pres.dart';
import 'package:cvpod/widgets/popups/edit/prof.dart';
import 'package:cvpod/widgets/popups/edit/pub.dart';
import 'package:cvpod/widgets/popups/edit/ref.dart';
import 'package:cvpod/widgets/popups/edit/res.dart';
import 'package:cvpod/widgets/popups/edit/sum.dart';

void dataEditDialog(
    BuildContext context, int tabIndex, CvManager cvManager, String webId,
    [String? createdTime]) {
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
                if (tabIndex == 0) ...[
                  editSum(context, cvManager, webId),
                ] else if (tabIndex == 1) ...[
                  editAbout(context, cvManager, webId),
                ] else if (tabIndex == 2) ...[
                  editEdu(context, cvManager, webId, createdTime!),
                ] else if (tabIndex == 3) ...[
                  editProf(context, cvManager, webId, createdTime!),
                ] else if (tabIndex == 4) ...[
                  editRes(context, cvManager, webId, createdTime!),
                ] else if (tabIndex == 5) ...[
                  editPub(context, cvManager, webId, createdTime!),
                ] else if (tabIndex == 6) ...[
                  editAward(context, cvManager, webId, createdTime!),
                ] else if (tabIndex == 7) ...[
                  editPres(context, cvManager, webId, createdTime!),
                ] else if (tabIndex == 8) ...[
                  editExtra(context, cvManager, webId, createdTime!),
                ] else if (tabIndex == 9) ...[
                  editRef(context, cvManager, webId, createdTime!),
                ],
              ],
            ),
          ));
}
