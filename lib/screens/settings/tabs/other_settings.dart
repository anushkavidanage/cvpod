/// Change key screen.
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

library;

import 'package:flutter/material.dart';

//import 'package:solidpod/solidpod.dart';

import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/constants/app.dart';

class OtherSettings extends StatefulWidget {
  final String webId;
  final CvManager cvManager;

  const OtherSettings({
    super.key,
    required this.webId,
    required this.cvManager,
  });

  @override
  OtherSettingsState createState() => OtherSettingsState();
}

class OtherSettingsState extends State<OtherSettings>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //String webId = widget.webId;
    //CvManager cvManager = widget.cvManager;

    return const SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              largeHeightGap,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Other settings',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              smallHeightGap,
              // ElevatedButton(
              //     onPressed: () {
              //       changeKeyPopup(context, widget);
              //     },
              //     child: const Text('Click to Change Security Key')),
              smallHeightGap,
            ])));
  }
}
