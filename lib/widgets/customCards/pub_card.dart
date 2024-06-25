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

import 'package:cvpod/utils/data_delete_popup.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/constants/app.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/utils/data_edit_popups.dart';

class PubCard extends StatelessWidget {
  final String citation;
  final String year;
  final String? url;
  final String createdTime;
  final String type;
  final CvManager cvManager;
  final String webId;

  const PubCard({
    super.key,
    required this.citation,
    required this.year,
    this.url,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    Text(year,
                        style:
                            const TextStyle(color: topCardIcon, fontSize: 13)),
                    const SizedBox(height: 7.0),
                    Text(citation, style: const TextStyle(fontSize: 14)),
                    if (url != null) ...[
                      const SizedBox(height: 5.0),
                      Text('URL: [${url!}]',
                          style:
                              const TextStyle(color: topCardIcon, fontSize: 12))
                    ]
                  ],
                ),
              )
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
                    dataDeleteDialog(
                        context, type, cvManager, webId, createdTime);
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
