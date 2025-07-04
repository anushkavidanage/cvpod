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

import 'package:flutter/material.dart';

import 'package:cvpod/apis/rest_api.dart';
import 'package:cvpod/constants/app.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/screens/profile/profile_screen.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/utils/misc.dart';
import 'package:cvpod/widgets/popups/add/tab_select.dart';
import 'package:cvpod/widgets/loading_screen.dart';

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
      List<Widget> subProfilePages = [
        for (DataType dataType in dataTypeList) ...{
          if (dataType != DataType.portrait) ...{
            ProfileScreen(
              tab: dataType,
              webId: webId,
              cvManager: widget.cvManager,
              //secureKeyObject: widget.secureKeyObject,
            ),
          }
        }
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
                      tabs: [
                        for (DataType dataType in dataTypeList) ...{
                          if (dataType != DataType.portrait) ...{
                            Tab(
                              text: capitalize(dataType.value),
                              icon: Icon(dataType.icon),
                              iconMargin: const EdgeInsets.only(bottom: 5.0),
                            ),
                          }
                        }
                      ]),
                  Expanded(
                    child: TabBarView(controller: _tabController, children: [
                      for (int i = 0; i < subProfilePages.length; i++)
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 700,
                                child: subProfilePages[i],
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
