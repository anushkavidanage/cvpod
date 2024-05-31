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

import 'package:cvpod/constants/colors.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/widgets/card_top.dart';
import 'package:cvpod/widgets/custom_progress_bar.dart';
import 'package:cvpod/screens/education.dart';
import 'package:cvpod/screens/professional.dart';

class AboutMe extends StatelessWidget
{
  const AboutMe({super.key});

 @override
 Widget build(BuildContext context)
 {
    return Scaffold(
      //backgroundColor: Color(0xff040305),
      appBar: AppBar(
        //backgroundColor: Color(0xff040305),
        elevation: 0,
        title: const Text('About Me', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardTop(icon: Icons.person_outline_rounded, text: 'About Me', isColor: true),
                    CardTop(icon: Icons.work_outline_outlined, text: 'Professional', isColor: false, page: Professional()),
                    CardTop(icon: Icons.stacked_line_chart_sharp, text: 'Education', isColor: false, page: Education()),
                  ],
                ),

                SizedBox(height: 15.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: bgCardLight,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: cardBorder), 
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Skills', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 30.0),
                      CustomProgressBar(skill: 'Backend Developer', porcentaje: '95',color: Color(0xffA36FF6)),
                      CustomProgressBar(skill: 'Web Developer', porcentaje: '80',color: Color(0xff83DBC5), barra: 250),
                      CustomProgressBar(skill: 'Flutter', porcentaje: '75',color: Color(0xff0385DC), barra: 210),
                      CustomProgressBar(skill: 'Laravel', porcentaje: '80',color: Color(0xffF7605D), barra: 250),
                    ],
                  ),
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
                          border: Border.all(
                            color: cardBorder
                          )
                        ),
                        child: Text('Solid PODs', style: TextStyle(fontSize: 15)),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: bgCardLight,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: cardBorder
                          )
                        ),
                        child: Text('Federated Learning', style: TextStyle(fontSize: 15)),
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