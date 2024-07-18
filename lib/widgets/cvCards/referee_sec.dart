/// Referee section widget
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

import 'package:cvpod/utils/cvData/refereeItem.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/constants/colors.dart';

Container buildRefereeSec(Map refereeData) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    width: double.infinity,
    decoration: const BoxDecoration(
      color: bgCardLight,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15.0),
        const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.verified, size: 25, color: appDarkBlue1),
          SizedBox(width: 10.0),
          Expanded(
              child: Text(
            "Referees",
            style: TextStyle(
                fontSize: 20, color: appDarkBlue1, fontWeight: FontWeight.w500),
          )),
        ]),
        const SizedBox(height: 5.0),
        Wrap(
          children: [
            for (RefereeItem refRec in refereeData.values) ...[
              Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.all(10.0),
                width: 400,
                decoration: BoxDecoration(
                  color: bgCardLight,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: cardBorder),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(refRec.name,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5.0),
                          Text(refRec.position,
                              style:
                                  TextStyle(color: topCardIcon, fontSize: 13)),
                          Text(
                            refRec.institute,
                            style: const TextStyle(
                              color: topCardIcon,
                              fontSize: 13,
                            ),
                            maxLines: 2,
                          ),
                          Text(refRec.email,
                              style: const TextStyle(
                                  color: topCardIcon,
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //const SizedBox(width: 10.0),
              //const SizedBox(height: 10.0),
            ]
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [

        //     // Create a grid with 2 columns. If you change the scrollDirection to
        //     // horizontal, t
        //     // GridView.count(
        //     //   primary: false,
        //     //   padding: const EdgeInsets.all(20),
        //     //   crossAxisSpacing: 10,
        //     //   mainAxisSpacing: 10,
        //     //   crossAxisCount: 2,
        //     //   children: <Widget>[
        //     //     Container(
        //     //       padding: const EdgeInsets.all(8),
        //     //       color: Colors.teal[100],
        //     //       child: const Text("He'd have you all unravel at the"),
        //     //     ),
        //     //     Container(
        //     //       padding: const EdgeInsets.all(8),
        //     //       color: Colors.teal[200],
        //     //       child: const Text('Heed not the rabble'),
        //     //     ),
        //     //     Container(
        //     //       padding: const EdgeInsets.all(8),
        //     //       color: Colors.teal[300],
        //     //       child: const Text('Sound of screams but the'),
        //     //     ),
        //     //     Container(
        //     //       padding: const EdgeInsets.all(8),
        //     //       color: Colors.teal[400],
        //     //       child: const Text('Who scream'),
        //     //     ),
        //     //     Container(
        //     //       padding: const EdgeInsets.all(8),
        //     //       color: Colors.teal[500],
        //     //       child: const Text('Revolution is coming...'),
        //     //     ),
        //     //     Container(
        //     //       padding: const EdgeInsets.all(8),
        //     //       color: Colors.teal[600],
        //     //       child: const Text('Revolution, they...'),
        //     //     ),
        //     //   ],
        //     // ),

        //     // Column(
        //     //   children: [
        //     //     Expanded(
        //     //         child: Text(
        //     //       "\u2022 ${refRec['citation']}",
        //     //       style: const TextStyle(
        //     //           fontSize: 12, fontWeight: FontWeight.w500),
        //     //     )),
        //     //     Text(
        //     //       "(${refRec['year']})",
        //     //       style: const TextStyle(fontSize: 12),
        //     //     ),
        //     //   ],
        //     // ),
        //     // Column(
        //     //   children: [
        //     //     Expanded(
        //     //         child: Text(
        //     //       "\u2022 ${refRec['citation']}",
        //     //       style: const TextStyle(
        //     //           fontSize: 12, fontWeight: FontWeight.w500),
        //     //     )),
        //     //     Text(
        //     //       "(${refRec['year']})",
        //     //       style: const TextStyle(fontSize: 12),
        //     //     ),
        //     //   ],
        //     // ),
        //   ],
        // ),
        const SizedBox(height: 10.0),
      ],
    ),
  );
}
