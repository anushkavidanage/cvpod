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

class CardCustom extends StatelessWidget {
  final String text;
  final String? education;
  final Color colorIcon;
  final bool isEducation;

  const CardCustom(
      {super.key,
      required this.text,
      required this.colorIcon,
      required this.isEducation,
      this.education});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: bgCardLight,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: cardBorder),
        ),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: colorIcon,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child:
                  const Icon(Icons.work_outline_outlined, color: Colors.white),
            ),
            SizedBox(width: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: TextStyle(fontSize: 16)),
                SizedBox(height: 7.0),
                !isEducation
                    ? Text('2020 - New . Lima - PE',
                        style: TextStyle(color: topCardIcon, fontSize: 15))
                    : Text(education!,
                        style: TextStyle(color: topCardIcon, fontSize: 15))
              ],
            )
          ],
        ),
      ),
    );
  }
}
