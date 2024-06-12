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

import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/constants/sample_content.dart';
import 'package:cvpod/widgets/customCards/award_card.dart';

class Awards extends StatelessWidget {
  const Awards({
    super.key,
    required this.dataMap,
  });

  /// Awards data
  final Map dataMap;

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
                    const Text('Awards/Achievements',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15.0),
                    for (final awardRec in awardsData.values) ...[
                      AwardCard(
                          title: awardRec['title'],
                          description: awardRec['description'],
                          year: awardRec['year'].toString(),
                          type: 'award'),
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
                      'You have no awards data yet. Please add.',
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
