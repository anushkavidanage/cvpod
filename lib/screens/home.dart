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

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cvpod/widgets/custom_progress_bar.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/constants/sample_content.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
              // Row(
              //   children: [
              //     Container(
              //       width: 750,
              //       //flex: 10,
              //       child: Image(
              //         image: AssetImage('assets/images/cv_sample.png'),
              //         width: 200,
              //       ),
              //     ),
              //   ],
              // ),
              // - - - - - - - - Bio section - - - - - - - -
              buildBioSection(bioData),
              // - - - - - - - - Summary section - - - - - - - -
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgCardLight,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.summarize, size: 25, color: appDarkBlue1),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                            "Summary",
                            style: TextStyle(
                                fontSize: 20,
                                color: appDarkBlue1,
                                fontWeight: FontWeight.w500),
                          )),
                        ]),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          '''I am a detail-oriented software engineer with a 5+ years of experience in the online services industry. Self mortivated individual with broad involvement in the software development and research projects as well as fieldwork. An excellent communicator with experince in working with wide range of clientele. I am now seeking a senior role where I can levarage my experience in project cordination and management.''',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              // - - - - - - - - Professional section - - - - - - - -
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgCardLight,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.work_rounded,
                              size: 25, color: appDarkBlue1),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                            "Professional",
                            style: TextStyle(
                                fontSize: 20,
                                color: appDarkBlue1,
                                fontWeight: FontWeight.w500),
                          )),
                        ]),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Senior Software Engineer",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                        Text(
                          "(Feb 2021 - Present)",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    //SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Microsoft Online Services Division, Sydney, Australia",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        )),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "\u2022 Responsible for designing algorithms for different online services. Used Java, Dart, Flutter and Python for programming.",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Junior Software Engineer",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                        Text(
                          "(Jun 2018 - Jan 2021)",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    //SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "CornerStone, Victoria, Australia",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        )),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          '''\u2022 Build RESTful APIs that feed data to the JavaScript front-based on dynamically chosen user inputs\n\u2022 Build internal tools using NodeJS to automate Q&A monitoring of web apps.''',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgCardLight,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.0),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.work_rounded,
                              size: 25, color: appDarkBlue1),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                            "Education",
                            style: TextStyle(
                                fontSize: 20,
                                color: appDarkBlue1,
                                fontWeight: FontWeight.w500),
                          )),
                        ]),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Bachelor of Computer Science (Hons)",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                        Text(
                          "(2014 - 2018)",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    //SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "The Australian National University",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        )),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "\u2022 1st class",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Diploma in Web Development",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                        Text(
                          "(2013 - 2014)",
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                    //SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Infortec International",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        )),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          '''\u2022 Subjects: Web development, Software engineering, Databases''',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgCardLight,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.0),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.work_rounded,
                              size: 25, color: appDarkBlue1),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                            "Research",
                            style: TextStyle(
                                fontSize: 20,
                                color: appDarkBlue1,
                                fontWeight: FontWeight.w500),
                          )),
                        ]),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Senior Software Engineer",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                        Text(
                          "(Feb 2021 - Present)",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    //SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Microsoft Online Services Division, Sydney, Australia",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        )),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "\u2022 Responsible for designing algorithms for different online services. Used Java, Dart, Flutter and Python for programming.",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Junior Software Engineer",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                        Text(
                          "(Jun 2018 - Jan 2021)",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    //SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "CornerStone, Victoria, Australia",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        )),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          '''\u2022 Build RESTful APIs that feed data to the JavaScript front-based on dynamically chosen user inputs\n\u2022 Build internal tools using NodeJS to automate Q&A monitoring of web apps.''',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgCardLight,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.0),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.work_rounded,
                              size: 25, color: appDarkBlue1),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                            "Publications",
                            style: TextStyle(
                                fontSize: 20,
                                color: appDarkBlue1,
                                fontWeight: FontWeight.w500),
                          )),
                        ]),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Senior Software Engineer",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                        Text(
                          "(Feb 2021 - Present)",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    //SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Microsoft Online Services Division, Sydney, Australia",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        )),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "\u2022 Responsible for designing algorithms for different online services. Used Java, Dart, Flutter and Python for programming.",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Junior Software Engineer",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                        Text(
                          "(Jun 2018 - Jan 2021)",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    //SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "CornerStone, Victoria, Australia",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        )),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          '''\u2022 Build RESTful APIs that feed data to the JavaScript front-based on dynamically chosen user inputs\n\u2022 Build internal tools using NodeJS to automate Q&A monitoring of web apps.''',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgCardLight,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.0),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.work_rounded,
                              size: 25, color: appDarkBlue1),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                            "Awards",
                            style: TextStyle(
                                fontSize: 20,
                                color: appDarkBlue1,
                                fontWeight: FontWeight.w500),
                          )),
                        ]),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Senior Software Engineer",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                        Text(
                          "(Feb 2021 - Present)",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    //SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Microsoft Online Services Division, Sydney, Australia",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        )),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "\u2022 Responsible for designing algorithms for different online services. Used Java, Dart, Flutter and Python for programming.",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Junior Software Engineer",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                        Text(
                          "(Jun 2018 - Jan 2021)",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    //SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "CornerStone, Victoria, Australia",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        )),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          '''\u2022 Build RESTful APIs that feed data to the JavaScript front-based on dynamically chosen user inputs\n\u2022 Build internal tools using NodeJS to automate Q&A monitoring of web apps.''',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgCardLight,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.0),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.work_rounded,
                              size: 25, color: appDarkBlue1),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                            "Volunteering/Involvements",
                            style: TextStyle(
                                fontSize: 20,
                                color: appDarkBlue1,
                                fontWeight: FontWeight.w500),
                          )),
                        ]),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Senior Software Engineer",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                        Text(
                          "(Feb 2021 - Present)",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    //SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Microsoft Online Services Division, Sydney, Australia",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        )),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "\u2022 Responsible for designing algorithms for different online services. Used Java, Dart, Flutter and Python for programming.",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Junior Software Engineer",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                        Text(
                          "(Jun 2018 - Jan 2021)",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    //SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "CornerStone, Victoria, Australia",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        )),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          '''\u2022 Build RESTful APIs that feed data to the JavaScript front-based on dynamically chosen user inputs\n\u2022 Build internal tools using NodeJS to automate Q&A monitoring of web apps.''',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgCardLight,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.0),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.work_rounded,
                              size: 25, color: appDarkBlue1),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                            "Referees",
                            style: TextStyle(
                                fontSize: 20,
                                color: appDarkBlue1,
                                fontWeight: FontWeight.w500),
                          )),
                        ]),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Senior Software Engineer",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                        Text(
                          "(Feb 2021 - Present)",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    //SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Microsoft Online Services Division, Sydney, Australia",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        )),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "\u2022 Responsible for designing algorithms for different online services. Used Java, Dart, Flutter and Python for programming.",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "Junior Software Engineer",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                        Text(
                          "(Jun 2018 - Jan 2021)",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    //SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "CornerStone, Victoria, Australia",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        )),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          '''\u2022 Build RESTful APIs that feed data to the JavaScript front-based on dynamically chosen user inputs\n\u2022 Build internal tools using NodeJS to automate Q&A monitoring of web apps.''',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: bgCardLight,
              //     borderRadius: BorderRadius.circular(20.0),
              //     border: Border.all(color: cardBorder),
              //   ),
              //   child: const Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text('Skills', style: TextStyle(fontSize: 18)),
              //       SizedBox(height: 30.0),
              //       CustomProgressBar(
              //           skill: 'Backend Developer',
              //           porcentaje: '95',
              //           color: Color(0xffA36FF6)),
              //       CustomProgressBar(
              //           skill: 'Web Developer',
              //           porcentaje: '80',
              //           color: Color(0xff83DBC5),
              //           barra: 250),
              //       CustomProgressBar(
              //           skill: 'Flutter',
              //           porcentaje: '75',
              //           color: Color(0xff0385DC),
              //           barra: 210),
              //       CustomProgressBar(
              //           skill: 'Laravel',
              //           porcentaje: '80',
              //           color: Color(0xffF7605D),
              //           barra: 250),
              //     ],
              //   ),
              // ),
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

  Container buildBioSection(Map bioData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: appDarkBlue2,
        // borderRadius: BorderRadius.circular(20.0),
        //border: Border.all(color: cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(bioData['name'].toUpperCase(),
              style: const TextStyle(fontSize: 35, color: backgroundWhite)),
          const SizedBox(height: 10.0),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(Icons.home, size: 20, color: backgroundWhite),
            const SizedBox(width: 10.0),
            Expanded(
                child: Text(
              bioData['address'],
              style: const TextStyle(fontSize: 12, color: backgroundWhite),
            )),
          ]),
          const SizedBox(height: 5.0),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(Icons.email, size: 18, color: backgroundWhite),
            const SizedBox(width: 10.0),
            Expanded(
                child: Text(
              bioData['email'],
              style: const TextStyle(fontSize: 12, color: backgroundWhite),
            )),
            const SizedBox(width: 20.0),
            const Icon(Icons.phone, size: 18, color: backgroundWhite),
            const SizedBox(width: 10.0),
            Expanded(
                child: Text(
              bioData['phone'],
              style: const TextStyle(fontSize: 12, color: backgroundWhite),
            )),
            const SizedBox(width: 20.0),
            const Icon(FontAwesomeIcons.linkedin,
                size: 18, color: backgroundWhite),
            const SizedBox(width: 10.0),
            Expanded(
                child: Text(
              bioData['linkedin'],
              style: const TextStyle(fontSize: 12, color: backgroundWhite),
            )),
          ]),
        ],
      ),
    );
  }
}
