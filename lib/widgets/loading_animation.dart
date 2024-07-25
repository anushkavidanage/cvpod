/// Loading animation widget
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
import 'package:loading_indicator/loading_indicator.dart';

import 'package:cvpod/constants/colors.dart';

List<Color> _defaultColors = const [
  appLightBlue2,
  appMidBlue1,
  appMidBlue2,
  appDarkBlue1,
  appDarkBlue2
];

/// Show animation dialog.
showAnimationDialog(BuildContext context, int animationIndex, String alertMsg,
    bool showPathBackground,
    {VoidCallback? updateStateCallback}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(50),
        child: Center(
          child: SizedBox(
            width: 150,
            height: 250,
            child: Column(
              children: [
                LoadingIndicator(
                  indicatorType: Indicator.values[animationIndex],
                  colors: _defaultColors,
                  strokeWidth: 4.0,
                  pathBackgroundColor: showPathBackground
                      ? const Color.fromARGB(59, 0, 0, 0)
                      : null,
                ),
                DefaultTextStyle(
                  style: (const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  )),
                  child: Text(
                    alertMsg,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                updateStateCallback != null
                    ? ElevatedButton(
                        onPressed: () {
                          updateStateCallback();
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Cancel'),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      );
    },
  );
}
