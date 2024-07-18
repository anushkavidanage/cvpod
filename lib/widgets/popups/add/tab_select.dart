/// Selecting tabs for data add popups.
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
import 'package:cvpod/widgets/popups/add/award.dart';
import 'package:cvpod/widgets/popups/add/edu.dart';
import 'package:cvpod/widgets/popups/add/extra.dart';
import 'package:cvpod/widgets/popups/add/pres.dart';
import 'package:cvpod/widgets/popups/add/prof.dart';
import 'package:cvpod/widgets/popups/add/pub.dart';
import 'package:cvpod/widgets/popups/add/ref.dart';
import 'package:cvpod/widgets/popups/add/res.dart';

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
                if (tabIndex == 2) ...[
                  newEduEntry(context, cvManager, webId),
                ] else if (tabIndex == 3) ...[
                  newProfEntry(context, cvManager, webId),
                ] else if (tabIndex == 4) ...[
                  newResEntry(context, cvManager, webId),
                ] else if (tabIndex == 5) ...[
                  newPubEntry(context, cvManager, webId),
                ] else if (tabIndex == 6) ...[
                  newAwardEntry(context, cvManager, webId),
                ] else if (tabIndex == 7) ...[
                  newPresEntry(context, cvManager, webId),
                ] else if (tabIndex == 8) ...[
                  newExtraEntry(context, cvManager, webId),
                ] else if (tabIndex == 9) ...[
                  newRefEntry(context, cvManager, webId),
                ]
              ],
            ),
          ));
}
