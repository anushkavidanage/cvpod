/// Education page
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

import 'package:cvpod/constants/app.dart';
import 'package:cvpod/utils/cvData/educationItem.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/widgets/customCards/custom_card.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/widgets/info_card.dart';
import 'package:cvpod/utils/cv_manager.dart';

class Education extends StatelessWidget {
  const Education({
    super.key,
    required this.dataMap,
    required this.cvManager,
    required this.webId,
  });

  /// Education data
  final Map dataMap;

  /// CV manager
  final CvManager cvManager;

  /// webId of the user
  final String webId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: dataMap.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15.0),
                  const Text('Educational Qualifications',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15.0),
                  for (EducationItem eduRec in dataMap.values) ...[
                    CustomCard(
                      title: eduRec.degree,
                      duration: eduRec.duration,
                      company: eduRec.institute,
                      comments: eduRec.comments,
                      createdTime: eduRec.createdTime,
                      type: DataType.education,
                      cvManager: cvManager,
                      webId: webId,
                    ),
                  ],
                  // Container(
                  //   alignment: Alignment.bottomRight,
                  //   child: ElevatedButton(
                  //       onPressed: () {}, child: const Text('Click here')),
                  // )
                ],
              )
            : Column(
                children: [
                  buildErrCard(
                    context,
                    Icons.clear,
                    appDarkBlue1,
                    'Warning!',
                    'You have no educational data yet. Please add.',
                  ),
                ],
              ),
      ),
    );
  }
}
