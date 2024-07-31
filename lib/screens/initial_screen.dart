/// Home screen of the CVPod app.
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

import 'package:solidpod/solidpod.dart';

import 'package:cvpod/apis/rest_api.dart';
import 'package:cvpod/constants/app.dart';
import 'package:cvpod/screens/home_screen.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/widgets/loading_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({
    super.key,
  });

  @override
  InitialScreenState createState() => InitialScreenState();
}

class InitialScreenState extends State<InitialScreen>
    with SingleTickerProviderStateMixin {
  late Future<List<dynamic>> _asyncDataFetch;

  Future<List<dynamic>> loadAsyncData() async {
    // Simulate loading data asynchronously.
    return Future.wait([
      getWebId(),
      fetchProfileData(context, const InitialScreen()),
    ]);
  }

  @override
  void initState() {
    _asyncDataFetch = loadAsyncData();
    super.initState();
  }

  Widget loadedScreen(List profileData) {
    // Get webId
    String webId = profileData.first;

    // Get cv data
    Map cvDataMap = profileData[1];

    // Insitialise CV data manager isntance
    // and load data
    CvManager cvManager = CvManager();

    cvManager.initialSetupCvData(cvDataMap);
    cvManager.updateDate();

    return HomeScreen(webId: webId, cvManager: cvManager);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _asyncDataFetch,
        builder: (context, snapshot) {
          Widget returnVal;
          if (snapshot.connectionState == ConnectionState.done) {
            returnVal = loadedScreen(snapshot.data as List);
          } else {
            returnVal =
                Scaffold(body: loadingScreen(normalLoadingScreenHeight));
          }
          return returnVal;
        });
  }
}
