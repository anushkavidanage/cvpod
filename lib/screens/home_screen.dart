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

import 'package:cvpod/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/screens/nav/nav_drawer.dart';
import 'package:cvpod/screens/home.dart';
import 'package:cvpod/utils/cv_manager.dart';

class HomeScreen extends StatefulWidget {
  final String webId;
  final CvManager cvManager;

  const HomeScreen({
    super.key,
    required this.webId,
    required this.cvManager,
  });

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String webId = widget.webId;
    CvManager cvManager = widget.cvManager;

    return Scaffold(
        appBar: buildAppBar(context, webId, cvManager),
        drawer: NavDrawer(webId: webId, cvManager: cvManager),
        body: Home(webId: webId, cvManager: cvManager));
  }
}
