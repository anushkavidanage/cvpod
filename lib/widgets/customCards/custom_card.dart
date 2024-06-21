/// Custom card.
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

import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/constants/app.dart';
import 'package:cvpod/utils/data_edit_popups.dart';
import 'package:cvpod/utils/cv_manager.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String duration;
  final String company;
  final String comments;
  final String createdTime;
  final String type;
  final CvManager cvManager;
  final String webId;

  const CustomCard({
    super.key,
    required this.title,
    required this.duration,
    required this.company,
    required this.comments,
    required this.createdTime,
    required this.type,
    required this.cvManager,
    required this.webId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: bgCardLight,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: cardBorder),
        ),
        child: Stack(children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Color((random.nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Icon(cardIcons[type], color: Colors.white),
              ),
              const SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(duration,
                        style:
                            const TextStyle(color: topCardIcon, fontSize: 13)),
                    const SizedBox(height: 10.0),
                    Text(title, style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 7.0),
                    Text(company,
                        style:
                            const TextStyle(color: topCardIcon, fontSize: 13)),

                    Text("\u2022 ${comments.replaceAll(';', '\n\u2022 ')}",
                        style:
                            const TextStyle(color: topCardIcon, fontSize: 13)),
                    // !isEducation
                    //     ? Text('2020 - New . Lima - PE',
                    //         style: TextStyle(color: topCardIcon, fontSize: 15))
                    //     : Text(education!,
                    // style: TextStyle(color: topCardIcon, fontSize: 15))
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Row(
              //  crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  onPressed: () {
                    dataEditDialog(context, tabNumbers[type], cvManager, webId,
                        createdTime);
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    size: 20,
                  ),
                  onPressed: () {
                    // ...
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
