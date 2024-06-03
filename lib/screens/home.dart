/// Home page
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

import 'package:cvpod/widgets/cvCards/pres_sec.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/widgets/custom_progress_bar.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/constants/sample_content.dart';
import 'package:cvpod/widgets/cvCards/bio_sec.dart';
import 'package:cvpod/widgets/cvCards/awards_sec.dart';
import 'package:cvpod/widgets/cvCards/edu_sec.dart';
import 'package:cvpod/widgets/cvCards/extra_sec.dart';
import 'package:cvpod/widgets/cvCards/prof_sec.dart';
import 'package:cvpod/widgets/cvCards/pub_sec.dart';
import 'package:cvpod/widgets/cvCards/referee_sec.dart';
import 'package:cvpod/widgets/cvCards/research_sec.dart';
import 'package:cvpod/widgets/cvCards/summary_sec.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.0),
              // Row(
              //   children: [
              //     Container(
              //       width: 750,
              //       //flex: 10,
              //       child: Image(
              //         image: AssetImage('assets/images/cv_sample.png'),
              //         width: 200,
              //       ),
              //     ),
              //   ],
              // ),

              // - - - - - - - - Bio section - - - - - - - -
              buildBioSec(bioData),

              // - - - - - - - - Summary section - - - - - -
              buildSummaySec(summary),

              // - - - - - - - - Professional section - - - -
              buildProfSec(professionalData),

              // - - - - - - - - Education section - - - - - - - -
              buildEduSec(educationData),

              // - - - - - - - - Research section - - - - - - - -
              buildResearchSec(researchData),

              // - - - - - - - - Publications section - - - - - - - -
              buildPubSec(publicationsData),

              // - - - - - - - - Awards section - - - - - - - -
              buildAwardSec(awardsData),

              // - - - - - - - - Presentations section - - - - - - - -
              buildPresSec(presentationsData),

              // - - - - - - - - Volunteering/Involvement section - - - - - - - -
              buildExtraSec(extraData),

              // - - - - - - - - Referee section - - - - - - - -
              buildRefereeSec(refereeData),

              SizedBox(height: 15.0),
              // Text('Interests', style: TextStyle(fontSize: 18)),
              // SizedBox(height: 15.0),
              // Column(
              //   children: [
              //     Row(children: [
              //       Container(
              //         padding: EdgeInsets.all(15.0),
              //         decoration: BoxDecoration(
              //             color: bgCardLight,
              //             borderRadius: BorderRadius.circular(20.0),
              //             border: Border.all(color: cardBorder)),
              //         child: Text('Solid PODs', style: TextStyle(fontSize: 15)),
              //       ),
              //       SizedBox(width: 10.0),
              //       Container(
              //         padding: EdgeInsets.all(15.0),
              //         decoration: BoxDecoration(
              //             color: bgCardLight,
              //             borderRadius: BorderRadius.circular(20.0),
              //             border: Border.all(color: cardBorder)),
              //         child: Text('Federated Learning',
              //             style: TextStyle(fontSize: 15)),
              //       )
              //     ])
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
