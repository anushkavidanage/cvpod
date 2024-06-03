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

import 'package:cvpod/screens/home.dart';
import 'package:cvpod/screens/profile/profile_tabs.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/nav/nav_drawer.dart';
import 'package:cvpod/screens/profile/tabs/about.dart';
import 'package:cvpod/screens/profile/tabs/education.dart';
import 'package:cvpod/screens/profile/tabs/professional.dart';

class NavigationScreen extends StatefulWidget {
  final String page;

  const NavigationScreen({
    super.key,
    required this.page,
  });

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<NavigationScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic loadingScreen;
    String page = widget.page;

    if (page == 'home') {
      loadingScreen = const Home();
    } else if (page == 'about') {
      loadingScreen = const AboutMe();
    } else if (page == 'profile') {
      loadingScreen = const ProfileTabs();
    } else if (page == 'pro') {
      loadingScreen = const Professional();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: appLightBlue1,
          centerTitle: true,
          title: const Text('CV generator',),
          actions: <Widget>[
            const SizedBox(width: 50),
            IconButton(
              tooltip: 'Build CV as a PDF',
              icon: const Icon(
                Icons.picture_as_pdf,
                color: Colors.black,
              ),
              onPressed: () {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => NavigationScreen(
                //             webId: webId,
                //             authData: authData,
                //             page: 'home',
                //           )),
                //   (Route<dynamic> route) =>
                //       false, // This predicate ensures all previous routes are removed
                // );
              },
            ),
            const SizedBox(width: 10),
            IconButton(
              tooltip: 'CV Sharing',
              icon: const Icon(
                // TODO 20231217 gjw view_list icon is not rendering on web. In
                // fact, any other icon I choose except the ones originally used
                // do not render. Must be an extra step required.
                Icons.share,
                color: Colors.black,
              ),
              onPressed: () {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => NavigationScreen(
                //             webId: webId,
                //             authData: authData,
                //             page: 'listNotes',
                //           )),
                //   (Route<dynamic> route) =>
                //       false, // This predicate ensures all previous routes are removed
                // );
              },
            ),
            const SizedBox(width: 10),
          ],
        ),
        drawer: const NavDrawer(
        ),
        body: loadingScreen,
      );
  }
}