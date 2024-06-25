/// A screen showing the health diary data.
///
/// Copyright (C) 2023 Software Innovation Institute, Australian National University
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
/// Authors: Zheyuan Xu, Graham Williams

import 'package:flutter/material.dart';

import 'package:cvpod/screens/profile/tabs/about.dart';
import 'package:cvpod/screens/profile/tabs/education.dart';
import 'package:cvpod/screens/profile/tabs/professional.dart';
import 'package:cvpod/screens/profile/tabs/research.dart';
import 'package:cvpod/screens/profile/tabs/summary.dart';
import 'package:cvpod/screens/profile/tabs/awards.dart';
import 'package:cvpod/screens/profile/tabs/extra.dart';
import 'package:cvpod/screens/profile/tabs/presentations.dart';
import 'package:cvpod/screens/profile/tabs/publications.dart';
import 'package:cvpod/screens/profile/tabs/referees.dart';
import 'package:cvpod/constants/app.dart';
import 'package:cvpod/constants/sample_content.dart';
import 'package:cvpod/utils/cv_manager.dart';

/// A StatefulWidget that presents diary-related data.

class ProfileScreen extends StatefulWidget {
  /// Constructs a `DiaryDataScreen` widget.
  ///
  /// The `authData` parameter is the authentication data
  /// necessary for the diary operations.
  ///
  /// The `webId` parameter is the web identifier used for unique
  /// identification in web operations.
  const ProfileScreen({
    Key? key,
    // required this.authData,
    required this.tab,
    required this.webId,
    required this.cvManager,
    //required this.secureKeyObject,
  }) : super(key: key);

  /// Authentication data necessary for the diary operations.
  //final Map authData;

  /// Web identifier used for unique identification in web operations.
  //final String webId;

  /// The tab to be displayed on the medical screen.
  final String tab;

  /// webId of the user
  final String webId;

  /// CV manager
  final CvManager cvManager;

  /// Define SecureKey object
  //final SecureKey secureKeyObject;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Authentication data necessary for the diary operations.

    //Map authData = widget.authData;

    /// Web identifier used for unique identification in web operations.

    //String webId = widget.webId;

    // return Scaffold(
    //   key: _scaffoldKey,
    //   drawer: ConstrainedBox(
    //       constraints: BoxConstraints(maxWidth: sideMenuScreenSize),
    //       child: SideMenu(
    //         authData: authData,
    //         webId: webId,
    //         pageName: 'diary',
    //         secureKeyObject: widget.secureKeyObject,
    //       )),
    //   body: SafeArea(child: _loadedScreen(widget.tab)),
    // );

    return _loadedScreen(widget.tab, widget.webId, widget.cvManager);
  }

  Widget _loadedScreen(String tab, String webId, CvManager cvManager) {
    StatelessWidget targetScreen;
    if (tab == 'summary') {
      targetScreen = Summary(
        data: loadSampleData ? summary : cvManager.getSummary['summary'],
        webId: webId,
        cvManager: cvManager,
      );
    } else if (tab == 'about') {
      targetScreen = AboutMe(
        dataMap: loadSampleData ? aboutData : cvManager.getAbout,
        webId: webId,
        cvManager: cvManager,
      );
    } else if (tab == 'education') {
      targetScreen = Education(
        dataMap: loadSampleData ? educationData : cvManager.getEducation,
        webId: webId,
        cvManager: cvManager,
      );
    } else if (tab == 'professional') {
      targetScreen = Professional(
        dataMap: loadSampleData ? professionalData : cvManager.getProfessional,
        webId: webId,
        cvManager: cvManager,
      );
    } else if (tab == 'research') {
      targetScreen = Research(
        dataMap: loadSampleData ? researchData : cvManager.getResearch,
        webId: webId,
        cvManager: cvManager,
      );
    } else if (tab == 'publications') {
      targetScreen = Publications(
        dataMap: loadSampleData ? publicationsData : cvManager.getPublications,
        webId: webId,
        cvManager: cvManager,
      );
    } else if (tab == 'awards') {
      targetScreen = Awards(
        dataMap: loadSampleData ? awardsData : cvManager.getAwards,
        webId: webId,
        cvManager: cvManager,
      );
    } else if (tab == 'presentations') {
      targetScreen = Presentaions(
        dataMap:
            loadSampleData ? presentationsData : cvManager.getPresentations,
        webId: webId,
        cvManager: cvManager,
      );
    } else if (tab == 'extra') {
      targetScreen = Extra(
        dataMap: loadSampleData ? extraData : cvManager.getExtra,
        webId: webId,
        cvManager: cvManager,
      );
    } else if (tab == 'referees') {
      targetScreen = Referees(
        dataMap: loadSampleData ? refereeData : cvManager.getReferees,
        webId: webId,
        cvManager: cvManager,
      );
    } else {
      targetScreen = AboutMe(
        dataMap: cvManager.getAbout,
        webId: webId,
        cvManager: cvManager,
      );
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: [Expanded(child: targetScreen)],
      ),
    );
  }
}
