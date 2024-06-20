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

import 'package:cvpod/api/rest_api.dart';
import 'package:cvpod/constants/app.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/nav/nav_drawer.dart';
import 'package:cvpod/screens/profile/profile_screen.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/utils/data_add_popups.dart';
import 'package:cvpod/widgets/loading_screen.dart';
import 'package:flutter/material.dart';

/// Medical tab screen widget.
class ProfileTabs extends StatefulWidget {
  /// Define SecureKey object
  //final SecureKey secureKeyObject;

  /// Constructs a medical tab screen widget.
  const ProfileTabs({super.key, required this.webId, required this.cvManager
      //required this.secureKeyObject,
      });

  /// WebID of the user
  final String webId;

  /// CV manager
  final CvManager cvManager;

  @override
  State<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs>
    with TickerProviderStateMixin {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static Future? _asyncDataFetch;

  @override
  void initState() {
    super.initState();

    _asyncDataFetch = updateProfileData(
      context,
      ProfileTabs(
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

  // List<Widget> subMedicalPages = [
  //   const ProfileScreen(
  //     tab: 'summary',
  //     //secureKeyObject: widget.secureKeyObject,
  //   ),
  //   const ProfileScreen(
  //     tab: 'about',
  //     //secureKeyObject: widget.secureKeyObject,
  //   ),
  //   const ProfileScreen(
  //     tab: 'education',
  //     //secureKeyObject: widget.secureKeyObject,
  //   ),
  //   const ProfileScreen(
  //     tab: 'professional',
  //     //secureKeyObject: widget.secureKeyObject,
  //   ),
  //   const ProfileScreen(
  //     tab: 'research',
  //     //secureKeyObject: widget.secureKeyObject,
  //   ),
  //   const ProfileScreen(
  //     tab: 'publications',
  //     //secureKeyObject: widget.secureKeyObject,
  //   ),
  //   const ProfileScreen(
  //     tab: 'awards',
  //     //secureKeyObject: widget.secureKeyObject,
  //   ),
  //   const ProfileScreen(
  //     tab: 'presentations',
  //     //secureKeyObject: widget.secureKeyObject,
  //   ),
  //   const ProfileScreen(
  //     tab: 'extra',
  //     //secureKeyObject: widget.secureKeyObject,
  //   ),
  //   const ProfileScreen(
  //     tab: 'referee',
  //     //secureKeyObject: widget.secureKeyObject,
  //   ),
  // ];

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

    Widget loadedScreen(CvManager cvManager) {
      List<Widget> subMedicalPages = [
        ProfileScreen(
          tab: 'summary',
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: 'about',
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: 'education',
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: 'professional',
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: 'research',
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: 'publications',
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: 'awards',
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: 'presentations',
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: 'extra',
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
        ProfileScreen(
          tab: 'referees',
          webId: webId,
          cvManager: widget.cvManager,
          //secureKeyObject: widget.secureKeyObject,
        ),
      ];

      return SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Flexible(
              child: Column(
                children: <Widget>[
                  TabBar(
                      controller: _tabController,
                      indicatorColor: appDarkBlue1,
                      labelColor: appDarkBlue1,
                      unselectedLabelColor: appMidBlue1,
                      isScrollable: true,
                      onTap: _onItemTapped,
                      //screenWidth(context) < tabScrollableThreshold,
                      indicatorWeight: 3,
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: const [
                        Tab(
                          text: 'Summary',
                          icon: Icon(Icons.summarize_outlined),
                          iconMargin: EdgeInsets.only(bottom: 5.0),
                        ),
                        Tab(
                          text: 'About Me',
                          icon: Icon(Icons.person_outlined),
                          iconMargin: EdgeInsets.only(bottom: 5.0),
                        ),
                        Tab(
                          text: 'Education',
                          icon: Icon(Icons.school_outlined),
                          iconMargin: EdgeInsets.only(bottom: 5.0),
                        ),
                        Tab(
                          text: 'Professional',
                          icon: Icon(Icons.work_outline),
                          iconMargin: EdgeInsets.only(bottom: 5.0),
                        ),
                        Tab(
                          text: 'Research',
                          icon: Icon(Icons.stacked_line_chart_sharp),
                          iconMargin: EdgeInsets.only(bottom: 5.0),
                        ),
                        Tab(
                          text: 'Publications',
                          icon: Icon(Icons.verified_outlined),
                          iconMargin: EdgeInsets.only(bottom: 5.0),
                        ),
                        Tab(
                          text: 'Awards',
                          icon: Icon(Icons.emoji_events_outlined),
                          iconMargin: EdgeInsets.only(bottom: 5.0),
                        ),
                        Tab(
                          text: 'Presentations',
                          icon: Icon(Icons.analytics_outlined),
                          iconMargin: EdgeInsets.only(bottom: 5.0),
                        ),
                        Tab(
                          text: 'Extra',
                          icon: Icon(Icons.front_hand_outlined),
                          iconMargin: EdgeInsets.only(bottom: 5.0),
                        ),
                        Tab(
                          text: 'Referees',
                          icon: Icon(Icons.person_search_outlined),
                          iconMargin: EdgeInsets.only(bottom: 5.0),
                        ),
                      ]),
                  Expanded(
                    child: TabBarView(controller: _tabController, children: [
                      for (int i = 0; i < subMedicalPages.length; i++)
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 700,
                                child: subMedicalPages[i],
                              ),
                            ],
                          ),
                        ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    }

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
            onPressed: () {},
          ),
          const SizedBox(width: 10),
          IconButton(
            tooltip: 'CV Sharing',
            icon: const Icon(
              Icons.share,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
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
      floatingActionButton: ![0, 1].contains(_selectedIndex)
          ? FloatingActionButton(
              onPressed: () {
                dataAddDialog(
                    context, _tabController.index, widget.cvManager, webId);
              },
              backgroundColor: appDarkBlue1,
              child: const Icon(
                Icons.add,
                color: backgroundWhite,
              ),
            )
          : null,
    );
  }
}
