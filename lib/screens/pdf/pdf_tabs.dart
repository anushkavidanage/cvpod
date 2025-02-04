/// Profile page with tabs screen.
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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:cvpod/apis/rest_api.dart';
import 'package:cvpod/constants/app.dart';
import 'package:cvpod/screens/profile/profile_screen.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/widgets/loading_screen.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/screens/pdf/template.dart';

/// Medical tab screen widget.
class PdfTabs extends StatefulWidget {
  /// Define SecureKey object
  //final SecureKey secureKeyObject;

  /// Constructs a medical tab screen widget.
  const PdfTabs(
      {super.key,
      required this.webId,
      required this.cvManager,
      required this.dataTypes
      //required this.secureKeyObject,
      });

  /// WebID of the user
  final String webId;

  /// CV manager
  final CvManager cvManager;

  /// A map of selected data types
  final Map dataTypes;

  @override
  State<PdfTabs> createState() => _PdfTabsState();
}

class _PdfTabsState extends State<PdfTabs> with TickerProviderStateMixin {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static Future? _asyncDataFetch;

  @override
  void initState() {
    super.initState();

    _asyncDataFetch = updateProfileData(
      context,
      PdfTabs(
        webId: widget.webId,
        cvManager: widget.cvManager,
        dataTypes: widget.dataTypes,
      ),
      widget.cvManager,
    );

    _tabController = TabController(
      // initialIndex: 0,
      length: 10,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late TabController _tabController;
  //int _selectedIndex = 0;

  // _onItemTapped(int index) {
  //   setState(() {
  //     // change _selectedIndex, fab will show or hide
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Use the provider to get the current tab index.
    //final currentTabIndex = ref.watch(lifestyleTabIndexProvider);

    String webId = widget.webId;

    int _tab = 0;

    Widget loadedScreen(CvManager cvManager) {
      List<Widget> subProfilePages = [
        ProfileScreen(
          tab: DataType.summary,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: DataType.about,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: DataType.education,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: DataType.professional,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: DataType.research,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: DataType.publication,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: DataType.award,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: DataType.presentation,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: DataType.extra,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: DataType.referee,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
      ];

      Future<void> saveAsFile(
        BuildContext context,
        LayoutCallback build,
        PdfPageFormat pageFormat,
      ) async {
        // final bytes = await build(pageFormat);

        // final appDocDir = await getApplicationDocumentsDirectory();
        // final appDocPath = appDocDir.path;
        // final file = File('$appDocPath/document.pdf');
        // print('Save as file ${file.path} ...');
        // await file.writeAsBytes(bytes);
        // await OpenFile.open(file.path);
      }

      final actions = <PdfPreviewAction>[
        if (!kIsWeb)
          PdfPreviewAction(
            icon: const Icon(Icons.save),
            onPressed: saveAsFile,
          )
      ];

      return PdfPreview(
        maxPageWidth: 700,
        build: (format) =>
            templates[_tab].builder(format, widget.cvManager, widget.dataTypes),
        actions: actions,
        allowSharing: false,
        canDebug: false,
        actionBarTheme: const PdfActionBarTheme(
          backgroundColor: appDarkBlue1,
        ),
        //onPrinted: _showPrintedToast,
        //onShared: _showSharedToast,
      );

      // return SafeArea(
      //     child: Container(
      //   color: Colors.white,
      //   child: Column(
      //     children: [
      //       Flexible(
      //         child: Column(
      //           children: <Widget>[
      //             TabBar(
      //                 controller: _tabController,
      //                 indicatorColor: appDarkBlue1,
      //                 labelColor: appDarkBlue1,
      //                 unselectedLabelColor: appMidBlue1,
      //                 isScrollable: true,
      //                 onTap: _onItemTapped,
      //                 //screenWidth(context) < tabScrollableThreshold,
      //                 indicatorWeight: 3,
      //                 labelStyle: const TextStyle(
      //                   color: Colors.white,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //                 tabs: const [
      //                   Tab(
      //                     text: 'Summary',
      //                     icon: Icon(Icons.summarize_outlined),
      //                     iconMargin: EdgeInsets.only(bottom: 5.0),
      //                   ),
      //                   Tab(
      //                     text: 'About Me',
      //                     icon: Icon(Icons.person_outlined),
      //                     iconMargin: EdgeInsets.only(bottom: 5.0),
      //                   ),
      //                   Tab(
      //                     text: 'Education',
      //                     icon: Icon(Icons.school_outlined),
      //                     iconMargin: EdgeInsets.only(bottom: 5.0),
      //                   ),
      //                   Tab(
      //                     text: 'Professional',
      //                     icon: Icon(Icons.work_outline),
      //                     iconMargin: EdgeInsets.only(bottom: 5.0),
      //                   ),
      //                   Tab(
      //                     text: 'Research',
      //                     icon: Icon(Icons.stacked_line_chart_sharp),
      //                     iconMargin: EdgeInsets.only(bottom: 5.0),
      //                   ),
      //                   Tab(
      //                     text: 'Publications',
      //                     icon: Icon(Icons.verified_outlined),
      //                     iconMargin: EdgeInsets.only(bottom: 5.0),
      //                   ),
      //                   Tab(
      //                     text: 'Awards',
      //                     icon: Icon(Icons.emoji_events_outlined),
      //                     iconMargin: EdgeInsets.only(bottom: 5.0),
      //                   ),
      //                   Tab(
      //                     text: 'Presentations',
      //                     icon: Icon(Icons.analytics_outlined),
      //                     iconMargin: EdgeInsets.only(bottom: 5.0),
      //                   ),
      //                   Tab(
      //                     text: 'Extra',
      //                     icon: Icon(Icons.front_hand_outlined),
      //                     iconMargin: EdgeInsets.only(bottom: 5.0),
      //                   ),
      //                   Tab(
      //                     text: 'Referees',
      //                     icon: Icon(Icons.person_search_outlined),
      //                     iconMargin: EdgeInsets.only(bottom: 5.0),
      //                   ),
      //                 ]),
      //             Expanded(
      //               child: TabBarView(controller: _tabController, children: [
      //                 for (int i = 0; i < subProfilePages.length; i++)
      //                   SingleChildScrollView(
      //                     child: Column(
      //                       children: [
      //                         SizedBox(
      //                           height: 700,
      //                           child: subProfilePages[i],
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //               ]),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ));
    }

    return Scaffold(
      body: FutureBuilder(
          future: _asyncDataFetch,
          builder: (context, snapshot) {
            Widget returnVal;
            if (snapshot.connectionState == ConnectionState.done) {
              returnVal = loadedScreen(snapshot.data);
            } else {
              returnVal = loadingScreen(normalLoadingScreenHeight);
            }
            return returnVal;
          }),
    );
  }
}
