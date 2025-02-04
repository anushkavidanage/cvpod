// Settings page with tabs screen.
//
// Copyright (C) 2024 Software Innovation Institute, Australian National University
//
// License: GNU General Public License, Version 3 (the "License")
// https://www.gnu.org/licenses/gpl-3.0.en.html
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
//
// Authors: Anushka Vidanage

import 'package:flutter/material.dart';

import 'package:cvpod/apis/rest_api.dart';
import 'package:cvpod/constants/app.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/screens/settings/tabs/change_key.dart';
import 'package:cvpod/screens/settings/tabs/other_settings.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/widgets/loading_screen.dart';

/// Medical tab screen widget.
class SettingsTabs extends StatefulWidget {
  /// Define SecureKey object
  //final SecureKey secureKeyObject;

  /// Constructs a medical tab screen widget.
  const SettingsTabs({super.key, required this.webId, required this.cvManager
      //required this.secureKeyObject,
      });

  /// WebID of the user
  final String webId;

  /// CV manager
  final CvManager cvManager;

  @override
  State<SettingsTabs> createState() => _SettingsTabsState();
}

class _SettingsTabsState extends State<SettingsTabs>
    with TickerProviderStateMixin {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static Future? _asyncDataFetch;

  @override
  void initState() {
    super.initState();

    // TODO:av the following future function is not necessary for this.
    // Can be replaced by any other futures
    _asyncDataFetch = updateProfileData(
      context,
      SettingsTabs(
        webId: widget.webId,
        cvManager: widget.cvManager,
      ),
      widget.cvManager,
    );

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late TabController _tabController;
  // int _selectedIndex = 0;

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

    Widget loadedScreen(CvManager cvManager) {
      List<Widget> subSettingsPages = [
        ChangeKey(
          webId: webId,
          cvManager: cvManager,
        ),
        OtherSettings(
          webId: webId,
          cvManager: cvManager,
        )
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
                      //onTap: _onItemTapped,
                      //screenWidth(context) < tabScrollableThreshold,
                      indicatorWeight: 3,
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: const [
                        Tab(
                          text: 'Change Security Key',
                          icon: Icon(Icons.vpn_key_outlined),
                          iconMargin: EdgeInsets.only(bottom: 5.0),
                        ),
                        Tab(
                          text: 'Other Settings',
                          icon: Icon(Icons.settings),
                          iconMargin: EdgeInsets.only(bottom: 5.0),
                        ),
                      ]),
                  Expanded(
                    child: TabBarView(controller: _tabController, children: [
                      for (int i = 0; i < subSettingsPages.length; i++)
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 700,
                                child: subSettingsPages[i],
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
    );
  }
}
