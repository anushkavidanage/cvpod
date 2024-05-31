/// Education page
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

import 'package:cvpod/screens/about.dart';
import 'package:cvpod/widgets/card_custom.dart';
import 'package:cvpod/widgets/card_top.dart';
import 'package:cvpod/screens/professional.dart';

class Education extends StatelessWidget
{
  const Education({super.key});


 @override
 Widget build(BuildContext context)
 {
    return Scaffold(
      //backgroundColor: Color(0xff040305),
      appBar: AppBar(
        //backgroundColor: Color(0xff040305),
        elevation: 0,
        title: const Text('Educational Qualifications', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardTop(icon: Icons.person_outline_rounded, text: 'About Me', isColor: false, page: AboutMe()),
                    CardTop(icon: Icons.work_outline_outlined, text: 'Professional', isColor: false, page: Professional()),
                    CardTop(icon: Icons.stacked_line_chart_sharp, text: 'Education', isColor: true ),
                  ],
                ),

                SizedBox(height: 15.0),
                CardCustom(text: 'Master in Backend Web',colorIcon: Color(0xffA36FF6), isEducation: true, education: '2014 - 2016 . University',),
                CardCustom(text: 'Master in Laravel',colorIcon: Color(0xffA36FF6), isEducation: true, education: '2016 - 2018 . University',),
                CardCustom(text: 'Bachiller in Sistemas',colorIcon: Color(0xffA36FF6), isEducation: true, education: '2019 - 2020 . University',),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                        color: bgCardLight,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: cardBorder),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star_border_outlined, color: Color(0xffA36FF6), size: 35),
                          SizedBox(height:5),
                          Text('Web Developer', style: TextStyle(fontSize: 16)),
                          SizedBox(height:5),
                          Text('2020', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                        color: bgCardLight,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: cardBorder),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star_border_outlined, color: Color(0xffA36FF6), size: 35),
                          SizedBox(height:5),
                          Text('App Developer', style: TextStyle(fontSize: 16)),
                          SizedBox(height:5),
                          Text('2021', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    )
                  ],
                )
            ],
          ),
        ),
      ),
     );
  }
}