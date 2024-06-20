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

import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/nav/nav_drawer.dart';
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
        appBar: AppBar(
          backgroundColor: appLightBlue1,
          centerTitle: true,
          title: const Text(
            'CV generator',
          ),
          actions: <Widget>[
            const SizedBox(width: 50),
            IconButton(
              tooltip: 'Build CV as a PDF',
              icon: const Icon(
                Icons.picture_as_pdf,
                color: Colors.black,
              ),
              onPressed: () {
//                 String fileContent = '''@prefix : <#>.
// @prefix foaf: <http://xmlns.com/foaf/0.1/>.
// @prefix terms: <http://purl.org/dc/terms/>.
// @prefix cvDataId: <https://solidcommunity.au/predicates/cv/data-id#>.
// @prefix cvData: <https://solidcommunity.au/predicates/cv/data#>.
// @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

// :me a foaf:PersonalProfileDocument;
//     terms:title "Education".
// cvDataId:20240612T154953
//     cvData:degree "Bachelor of Computer Science (Hons)"^^xsd:string;
//     cvData:duration "2014 - 2018"^^xsd:string;
//     cvData:institute "The Australian National University"^^xsd:string;
//     cvData:comments "1st class"^^xsd:string.
// cvDataId:20240612T213943
//     cvData:degree "Diploma in Web Development"^^xsd:string;
//     cvData:duration "2013 - 2014"^^xsd:string;
//     cvData:institute "Infortec International"^^xsd:string;
//     cvData:comments "Subjects: Web development, Software engineering, Databases@2nd class upper"^^xsd:string.
//  ''';
//                 Map ttlMap = parseTTL(fileContent);
//                 print(ttlMap);

//                 print(parseEducation(ttlMap));

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
        drawer: NavDrawer(webId: webId, cvManager: cvManager),
        body: Home(webId: webId, cvManager: cvManager));
  }
}
