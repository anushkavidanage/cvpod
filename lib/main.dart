/// Main screen of CVPod app.
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

import 'package:solidpod/solidpod.dart';

import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/screens/initial_screen.dart';

void main() {
  runApp(const CvPod());
}

class CvPod extends StatelessWidget {
  const CvPod({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CVPod',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: appDarkBlue1),
        useMaterial3: true,
      ),
      home: const SolidLogin(
        title: 'CVPod',
        image: AssetImage(
            'assets/images/cvpod_login_bg.jpg'), // Image by https://www.pexels.com
        logo: AssetImage(
            'assets/images/cvpod_logo.png'), // Curriculum icons created by Freepik - Flaticon (https://www.flaticon.com)
        link: 'https://github.com/anushkavidanage/cvpod/blob/main/README.md',
        //required: false,
        infoButtonStyle: InfoButtonStyle(
          tooltip: 'Visit the CVPod documentation.',
        ),
        loginButtonStyle: LoginButtonStyle(
          background: appLightBlue2,
        ),
        child: InitialScreen(),
      ),
    );
  }
}
