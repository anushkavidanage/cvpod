/// Professional experience page
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

import 'package:cvpod/screens/about.dart';
import 'package:cvpod/screens/education.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/widgets/card_custom.dart';
import 'package:cvpod/widgets/card_top.dart';

class Professional extends StatelessWidget
{
  const Professional({super.key});


 @override
 Widget build(BuildContext context)
 {
    return Scaffold(
      //backgroundColor: Color(0xff040305),
      appBar: AppBar(
        //backgroundColor: Color(0xff040305),
        elevation: 0,
        title: const Text('Professional Qualifications', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardTop(icon: Icons.person_outline_rounded, text: 'About Me', isColor: false, page: AboutMe()),
                    CardTop(icon: Icons.work_outline_outlined, text: 'Professional', isColor: true),
                    CardTop(icon: Icons.stacked_line_chart_sharp, text: 'Education', isColor: false, page: Education()),
                  ],
                ),

                SizedBox(height: 15.0),
                CardCustom(text: 'Freelance Web Designer',colorIcon: Color(0xffA36FF6), isEducation: false),
                CardCustom(text: 'Senior Web Developer',colorIcon: Color(0xff83DBC5), isEducation: false),
                CardCustom(text: 'Semi Senior Web Developer',colorIcon: Color(0xff0385DC), isEducation: false),
                CardCustom(text: 'Junior Web Developer',colorIcon: Color(0xffE62755), isEducation: false),
                CardCustom(text: 'Freelance App Flutter',colorIcon: Color(0xffF7605D), isEducation: false),
            ],
          ),
        ),
      ),
     );
  }
}