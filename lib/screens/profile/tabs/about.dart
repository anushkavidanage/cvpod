/// About page
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

import 'package:cvpod/widgets/custom_progress_bar.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/constants/sample_content.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgCardLight,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: cardBorder),
                ),
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('About Me',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 25.0),
                      const Text('NAME',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: appDarkBlue2)),
                      Text(bioData['name'],
                          style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 25.0),
                      const Text('GENDER',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: appDarkBlue2)),
                      Text(bioData['gender'],
                          style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 25.0),
                      const Text('ADDRESS',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: appDarkBlue2)),
                      Text(bioData['address'],
                          style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 25.0),
                      const Text('EMAIL',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: appDarkBlue2)),
                      Text(bioData['email'],
                          style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 25.0),
                      const Text('PHONE',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: appDarkBlue2)),
                      Text(bioData['phone'],
                          style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 25.0),
                      const Text('LINKEDIN',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: appDarkBlue2)),
                      Text(bioData['linkedin'],
                          style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 25.0),
                      const Text('WEB',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: appDarkBlue2)),
                      Text(bioData['web'],
                          style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 25.0),
                      const CustomProgressBar(
                          skill: 'Profile complete',
                          porcentaje: '75',
                          color: Color(0xff0385DC),
                          barra: 210),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // ...
                      },
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 15.0),
              Text('Interests', style: TextStyle(fontSize: 18)),
              SizedBox(height: 15.0),
              Column(
                children: [
                  Row(children: [
                    Container(
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: bgCardLight,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: cardBorder)),
                      child: Text('Solid PODs', style: TextStyle(fontSize: 15)),
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: bgCardLight,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: cardBorder)),
                      child: Text('Federated Learning',
                          style: TextStyle(fontSize: 15)),
                    )
                  ])
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
