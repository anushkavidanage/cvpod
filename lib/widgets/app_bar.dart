/// App bar on top of the page
///
/// Copyright (C) 2024 Software Innovation Institute, Australian National University
///
/// License: GNU General Public License, Version 3 (the "License")
/// https://www.gnu.org/licenses/gpl-3.0.en.html
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
import 'package:cvpod/screens/pdf/select_sec_popup.dart';
import 'package:cvpod/utils/misc.dart';

buildAppBar(BuildContext context, String webId, CvManager cvManager) {
  bool allEmpty = checkCvEmpty(cvManager);

  return AppBar(
    backgroundColor: appLightBlue1,
    centerTitle: true,
    title: const Text(
      'CV generator',
    ),
    actions: <Widget>[
      const SizedBox(width: 50),
      IconButton(
        tooltip: 'Build CV as a PDF',
        icon: Icon(
          Icons.picture_as_pdf,
          color: allEmpty ? Colors.grey : Colors.black,
        ),
        onPressed: allEmpty
            ? null
            : () {
                dataSelectDialog(context, cvManager, webId);
              },
      ),
      const SizedBox(width: 10),
      IconButton(
        tooltip: 'CV Sharing',
        icon: Icon(
          Icons.share,
          color: allEmpty ? Colors.grey : Colors.black,
        ),
        onPressed: allEmpty ? null : () {},
      ),
      const SizedBox(width: 10),
    ],
  );
}
