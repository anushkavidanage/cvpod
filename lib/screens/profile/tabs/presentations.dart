/// Professional page
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
import 'package:cvpod/utils/cvData/presentationItem.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/widgets/customCards/pub_card.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/widgets/info_card.dart';

class Presentaions extends StatelessWidget {
  const Presentaions({
    super.key,
    required this.dataMap,
    required this.webId,
    required this.cvManager,
  });

  /// Presentations data
  final Map dataMap;

  /// webId of the user
  final String webId;

  /// CV manager
  final CvManager cvManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: dataMap.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15.0),
                    const Text('Presentaions',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15.0),
                    for (PresentationItem presRec in dataMap.values) ...[
                      PubCard(
                        citation: presRec.description,
                        year: presRec.year,
                        url: presRec.url,
                        type: DataType.presentation,
                        createdTime: presRec.createdTime,
                        cvManager: cvManager,
                        webId: webId,
                      ),
                    ],
                  ],
                )
              : Column(
                  children: [
                    buildErrCard(
                      context,
                      Icons.clear,
                      appDarkBlue1,
                      'Warning!',
                      'You have no presentations data yet. Please add.',
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
