// Nav drawer of the CVPod app.
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

import 'package:cvpod/screens/home.dart';
import 'package:cvpod/screens/nav/nav_screen.dart';
import 'package:cvpod/screens/sharing/sharing_tabs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:solidpod/solidpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cvpod/constants/app.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/screens/profile/profile_tabs.dart';
import 'package:cvpod/screens/settings/settings_tabs.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/main.dart';
import 'package:cvpod/utils/misc.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key, required this.webId, required this.cvManager});

  final String webId;
  final CvManager cvManager;

  @override
  Widget build(BuildContext context) {
    String name = getNameFromWebId(webId);
    bool allEmpty = checkCvEmpty(cvManager);

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
      ),
      child: ListView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top,
              bottom: 24,
            ),
            decoration: const BoxDecoration(
              color: appDarkBlue2,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: cvManager.portraitBytes != null
                      ? MemoryImage(cvManager.portraitBytes as Uint8List)
                      : const AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  name,
                  style: const TextStyle(color: backgroundWhite, fontSize: 25),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    webId,
                    style:
                        const TextStyle(color: backgroundWhite, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Wrap(
              runSpacing: 10,
              children: [
                ListTile(
                  leading: const Icon(Icons.home_outlined),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavScreen(
                          webId: webId,
                          cvManager: cvManager,
                          childPage: Home(webId: webId, cvManager: cvManager),
                        ),
                      ),
                      (Route<dynamic> route) =>
                          false, // This predicate ensures all previous routes are removed
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.view_list),
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavScreen(
                          webId: webId,
                          cvManager: cvManager,
                          childPage:
                              ProfileTabs(webId: webId, cvManager: cvManager),
                        ),
                      ),
                      (Route<dynamic> route) =>
                          false, // This predicate ensures all previous routes are removed
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.file_open_outlined,
                    color: allEmpty ? Colors.grey : Colors.black,
                  ),
                  title: Text(
                    'CV Sharing',
                    style: TextStyle(
                      color: allEmpty ? Colors.grey : Colors.black,
                    ),
                  ),
                  onTap: allEmpty
                      ? null
                      : () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavScreen(
                                webId: webId,
                                cvManager: cvManager,
                                childPage: SharingTabs(
                                  webId: webId,
                                  cvManager: cvManager,
                                ),
                              ),
                            ),
                            (Route<dynamic> route) =>
                                false, // This predicate ensures all previous routes are removed
                          );
                        },
                ),
                const Divider(
                  color: darkAsh,
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavScreen(
                          webId: webId,
                          cvManager: cvManager,
                          childPage: SettingsTabs(
                            webId: webId,
                            cvManager: cvManager,
                          ),
                        ),
                      ),
                      (Route<dynamic> route) =>
                          false, // This predicate ensures all previous routes are removed
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Logout'),
                  onTap: () async {
                    // First erase all instances of CV
                    cvManager.deleteAllCvData();

                    // Then direct to logout popup
                    await logoutPopup(context, const CvPod());
                  },
                ),
                const Divider(
                  color: darkAsh,
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About'),
                  onTap: () => {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return _aboutDialog();
                      },
                    ),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Make About Dialog
Widget _aboutDialog() {
  return AboutDialog(
    applicationName: applicationName,
    applicationIcon: SizedBox(
      height: 65,
      width: 65,
      child: Image.asset('assets/images/cvpod_logo.png'),
    ),
    applicationVersion: applicationVersion,
    // applicationLegalese: "© Copyright Michelphoenix 2020",
    children: <Widget>[
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        RichText(
          text: TextSpan(
            text: 'An ',
            style: const TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: 'ANU Software Innovation Institute',
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrl(Uri.parse(siiUrl));
                  },
              ),
              const TextSpan(
                text: ' demo project for Solid PODs.',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'For more information see the ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: 'CVPod',
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrl(Uri.parse(applicationRepo));
                  },
              ),
              const TextSpan(
                text: ' github repository.',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(authors),
      ]),
    ],
  );
}
