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

import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/screens/nav/nav_drawer.dart';
import 'package:cvpod/widgets/app_bar.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({
    super.key,
    required this.webId,
    required this.cvManager,
    required this.childPage,
  });

  final Widget childPage;
  final String webId;
  final CvManager cvManager;

  @override
  NavScreenState createState() => NavScreenState();
}

class NavScreenState extends State<NavScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, widget.webId, widget.cvManager),
        drawer: NavDrawer(webId: widget.webId, cvManager: widget.cvManager),
        body: widget.childPage);
  }
}
