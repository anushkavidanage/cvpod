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

import 'package:cvpod/screens/pdf/data.dart';
import 'package:cvpod/screens/pdf/template.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:cvpod/api/rest_api.dart';
import 'package:cvpod/constants/app.dart';
import 'package:cvpod/nav/nav_drawer.dart';
import 'package:cvpod/screens/profile/profile_screen.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/widgets/app_bar.dart';
import 'package:cvpod/widgets/loading_screen.dart';

/// Medical tab screen widget.
class PdfTabs extends StatefulWidget {
  /// Define SecureKey object
  //final SecureKey secureKeyObject;

  /// Constructs a medical tab screen widget.
  const PdfTabs({super.key, required this.webId, required this.cvManager
      //required this.secureKeyObject,
      });

  /// WebID of the user
  final String webId;

  /// CV manager
  final CvManager cvManager;

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
  int _selectedIndex = 0;

  _onItemTapped(int index) {
    setState(() {
      // change _selectedIndex, fab will show or hide
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use the provider to get the current tab index.
    //final currentTabIndex = ref.watch(lifestyleTabIndexProvider);

    String webId = widget.webId;

    int _tab = 0;
    var _data = const CustomData();

    Widget loadedScreen(CvManager cvManager) {
      List<Widget> subProfilePages = [
        ProfileScreen(
          tab: summaryStr,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: aboutStr,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: educationStr,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: professionalStr,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: researchStr,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: publicationsStr,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: awardsStr,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: presentationsStr,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: extraStr,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: refereesStr,
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
      ];

      Future<void> _saveAsFile(
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
            onPressed: _saveAsFile,
          )
      ];

      return PdfPreview(
        maxPageWidth: 700,
        build: (format) => templates[_tab].builder(format, _data),
        actions: actions,
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
      appBar: buildAppBar(context, widget.webId, widget.cvManager),
      drawer: NavDrawer(webId: widget.webId, cvManager: widget.cvManager),
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
