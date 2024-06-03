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

import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

/// Medical tab screen widget.
class ProfileTabs extends StatefulWidget {

  /// Define SecureKey object
  //final SecureKey secureKeyObject;

  /// Constructs a medical tab screen widget.
  const ProfileTabs({
    super.key,
    //required this.secureKeyObject,
  });

  @override
  State<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    // Use the provider to get the current tab index.
    //final currentTabIndex = ref.watch(lifestyleTabIndexProvider);

    List<Widget> subMedicalPages = [
      const ProfileScreen(
        tab: 'summary',
        //secureKeyObject: widget.secureKeyObject,
      ),
      const ProfileScreen(
        tab: 'about',
        //secureKeyObject: widget.secureKeyObject,
      ),
      const ProfileScreen(
        tab: 'education',
        //secureKeyObject: widget.secureKeyObject,
      ),
      const ProfileScreen(
        tab: 'professional',
        //secureKeyObject: widget.secureKeyObject,
      ),
      const ProfileScreen(
        tab: 'research',
        //secureKeyObject: widget.secureKeyObject,
      ),
      const ProfileScreen(
        tab: 'puublications',
        //secureKeyObject: widget.secureKeyObject,
      ),
      const ProfileScreen(
        tab: 'awards',
        //secureKeyObject: widget.secureKeyObject,
      ),
      const ProfileScreen(
        tab: 'presentations',
        //secureKeyObject: widget.secureKeyObject,
      ),
      const ProfileScreen(
        tab: 'extra',
        //secureKeyObject: widget.secureKeyObject,
      ),
      const ProfileScreen(
        tab: 'referee',
        //secureKeyObject: widget.secureKeyObject,
      ),
    ];

    // return Scaffold(
    //   key: _scaffoldKey,
    //   drawer: ConstrainedBox(
    //       constraints: BoxConstraints(maxWidth: sideMenuScreenSize),
    //       child: SideMenu(
    //         authData: authData,
    //         webId: webId,
    //         pageName: 'lifestyle',
    //         secureKeyObject: widget.secureKeyObject,
    //       )),
    //   body: SafeArea(
    //       child: Container(
    //     color: Colors.white,
    //     child: Column(
    //       children: [
    //         Flexible(
    //           child: DefaultTabController(
    //             initialIndex: currentTabIndex,
    //             length: subMedicalPages.length,
    //             child: Column(
    //               children: <Widget>[
    //                 TabBar(
    //                     controller: _tabController,
    //                     indicatorColor: appDarkBlue2,
    //                     labelColor: appDarkBlue2,
    //                     unselectedLabelColor: appLightBlue2,
    //                     isScrollable: true,
    //                         //screenWidth(context) < tabScrollableThreshold,
    //                     indicatorWeight: 3,
    //                     labelStyle: TextStyle(
    //                       color: Colors.white,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                     tabs: const [
    //                       Tab(
    //                         text: 'Summary',
    //                         icon: Icon(Icons.info),
    //                         iconMargin: EdgeInsets.only(bottom: 5.0),
    //                       ),
    //                       Tab(
    //                         text: 'About Me',
    //                         icon: Icon(Icons.edit_calendar),
    //                         iconMargin: EdgeInsets.only(bottom: 5.0),
    //                       ),
    //                       Tab(
    //                         text: 'Education',
    //                         icon: Icon(Icons.people_outlined),
    //                         iconMargin: EdgeInsets.only(bottom: 5.0),
    //                       ),
    //                       Tab(
    //                         text: 'Professional',
    //                         icon: Icon(Icons.people_outlined),
    //                         iconMargin: EdgeInsets.only(bottom: 5.0),
    //                       ),
    //                       Tab(
    //                         text: 'Research',
    //                         icon: Icon(Icons.people_outlined),
    //                         iconMargin: EdgeInsets.only(bottom: 5.0),
    //                       ),
    //                       Tab(
    //                         text: 'Publications',
    //                         icon: Icon(Icons.people_outlined),
    //                         iconMargin: EdgeInsets.only(bottom: 5.0),
    //                       ),
    //                       Tab(
    //                         text: 'Awards',
    //                         icon: Icon(Icons.people_outlined),
    //                         iconMargin: EdgeInsets.only(bottom: 5.0),
    //                       ),
    //                       Tab(
    //                         text: 'Presentations',
    //                         icon: Icon(Icons.people_outlined),
    //                         iconMargin: EdgeInsets.only(bottom: 5.0),
    //                       ),
    //                       Tab(
    //                         text: 'Extra',
    //                         icon: Icon(Icons.people_outlined),
    //                         iconMargin: EdgeInsets.only(bottom: 5.0),
    //                       ),
    //                       Tab(
    //                         text: 'Referees',
    //                         icon: Icon(Icons.people_outlined),
    //                         iconMargin: EdgeInsets.only(bottom: 5.0),
    //                       ),
    //                     ]),
    //                 Expanded(
    //                   child: TabBarView(controller: _tabController, children: [
    //                     for (int i = 0; i < subMedicalPages.length; i++)
    //                       SingleChildScrollView(
    //                         child: Column(
    //                           children: [
    //                             SizedBox(
    //                               height: screenHeight(context) * 0.95,
    //                               child: subMedicalPages[i],
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                   ]),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   )),
    // );

    return SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Flexible(
              child: DefaultTabController(
                initialIndex: 0,
                length: subMedicalPages.length,
                child: Column(
                  children: <Widget>[
                    const TabBar(
                        //controller: _tabController,
                        indicatorColor: appDarkBlue1,
                        labelColor: appDarkBlue1,
                        unselectedLabelColor: appMidBlue1,
                        isScrollable: true,
                            //screenWidth(context) < tabScrollableThreshold,
                        indicatorWeight: 3,
                        labelStyle: TextStyle(
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
                      child: TabBarView(children: [
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
            ),
          ],
        ),
      ));
  }

  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();

    // Use 'ref.read' for one-time actions that don't need rebuild.
    //final currentTabIndex = 0;

    // _tabController = TabController(
    //   initialIndex: 0,
    //   length: 10,
    //   vsync: this,
    // );

    // _tabController.addListener(() {
    //   if (_tabController.indexIsChanging) {
    //     ref.read(lifestyleTabIndexProvider.notifier).state =
    //         _tabController.index;
    //   }
    // });
  }
}
