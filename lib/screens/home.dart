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

import 'package:flutter/material.dart';

import 'package:cvpod/constants/sample_content.dart';
import 'package:cvpod/widgets/cvCards/about_sec.dart';
import 'package:cvpod/widgets/cvCards/awards_sec.dart';
import 'package:cvpod/widgets/cvCards/edu_sec.dart';
import 'package:cvpod/widgets/cvCards/extra_sec.dart';
import 'package:cvpod/widgets/cvCards/prof_sec.dart';
import 'package:cvpod/widgets/cvCards/pub_sec.dart';
import 'package:cvpod/widgets/cvCards/referee_sec.dart';
import 'package:cvpod/widgets/cvCards/research_sec.dart';
import 'package:cvpod/widgets/cvCards/summary_sec.dart';
import 'package:cvpod/widgets/cvCards/pres_sec.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/screens/profile/profile_tabs.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/utils/misc.dart';
import 'package:cvpod/widgets/common_widgets.dart';
import 'package:cvpod/constants/app.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.webId, required this.cvManager});

  final String webId;
  final CvManager cvManager;

  @override
  Widget build(BuildContext context) {
    var aboutSecData = cvManager.getAbout;

    var sumSecData = cvManager.getSummary;
    var eduSecData = cvManager.getEducation;
    var profSecData = cvManager.getProfessional;
    var resSecData = cvManager.getResearch;
    var pubSecData = cvManager.getPublications;
    var awdSecData = cvManager.getAwards;
    var presSecData = cvManager.getPresentations;
    var exSecData = cvManager.getExtra;
    var refSecData = cvManager.getReferees;

    if (loadSampleData) {
      aboutSecData = aboutData;
      sumSecData = summary;
      eduSecData = educationData;
      profSecData = professionalData;
      resSecData = researchData;
      pubSecData = publicationsData;
      awdSecData = awardsData;
      presSecData = presentationsData;
      exSecData = extraData;
      refSecData = refereeData;
    }

    bool allEmpty = checkCvEmpty(cvManager);

    if (loadSampleData) {
      allEmpty = false;
    }

    // if()

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15.0),
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

              if (allEmpty) ...[
                buildErrCard(
                  context,
                  Icons.info,
                  appDarkBlue1,
                  'INFO!',
                  'You do not have any data in your profile yet!',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileTabs(
                                  webId: webId, cvManager: cvManager),
                            ),
                            (Route<dynamic> route) =>
                                false, // This predicate ensures all previous routes are removed
                          );
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(appDarkBlue1)),
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Add data',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                // - - - - - - - - Bio section - - - - - - - -
                if (aboutSecData.isNotEmpty) ...[buildAboutSec(aboutSecData)],

                // - - - - - - - - Summary section - - - - - -
                if (sumSecData.isNotEmpty) ...[buildSummaySec(sumSecData)],

                // - - - - - - - - Professional section - - - -
                if (profSecData.isNotEmpty) ...[buildProfSec(profSecData)],

                // - - - - - - - - Education section - - - - - - - -
                if (eduSecData.isNotEmpty) ...[buildEduSec(eduSecData)],

                // - - - - - - - - Research section - - - - - - - -
                if (resSecData.isNotEmpty) ...[buildResearchSec(resSecData)],

                // - - - - - - - - Publications section - - - - - - - -
                if (pubSecData.isNotEmpty) ...[buildPubSec(pubSecData)],

                // - - - - - - - - Awards section - - - - - - - -
                if (awdSecData.isNotEmpty) ...[buildAwardSec(awdSecData)],

                // - - - - - - - - Presentations section - - - - - - - -
                if (presSecData.isNotEmpty) ...[buildPresSec(presSecData)],

                // - - - - - - - - Volunteering/Involvement section - - - - - - - -
                if (exSecData.isNotEmpty) ...[buildExtraSec(exSecData)],

                // - - - - - - - - Referee section - - - - - - - -
                if (refSecData.isNotEmpty) ...[buildRefereeSec(refSecData)],
              ],

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
