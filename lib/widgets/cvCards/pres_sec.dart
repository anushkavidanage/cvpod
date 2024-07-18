/// Presentations section widget
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

import 'package:cvpod/utils/cvData/presentationItem.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/constants/colors.dart';

Container buildPresSec(Map presentationsData) {
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
          Icon(Icons.analytics, size: 25, color: appDarkBlue1),
          SizedBox(width: 10.0),
          Expanded(
              child: Text(
            "Presentations",
            style: TextStyle(
                fontSize: 20, color: appDarkBlue1, fontWeight: FontWeight.w500),
          )),
        ]),
        const SizedBox(height: 5.0),
        for (PresentationItem presRec in presentationsData.values) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                presRec.description,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              )),
              Text(
                "(${presRec.year})",
                style: const TextStyle(fontSize: 13),
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
                "url: [${presRec.url}]",
                style:
                    const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              )),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
        const SizedBox(height: 5.0),
      ],
    ),
  );
}
