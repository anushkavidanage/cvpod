/// Bio section widget
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

import 'package:cvpod/utils/cvData/aboutItem.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cvpod/constants/colors.dart';

Container buildAboutSec(Map aboutData) {
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
        Text(aboutData[AboutLiteral.name.label].toUpperCase(),
            style: const TextStyle(fontSize: 35, color: backgroundWhite)),
        Text(aboutData[AboutLiteral.position.label],
            style: const TextStyle(fontSize: 24, color: backgroundWhite)),
        const SizedBox(height: 20.0),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.home, size: 20, color: backgroundWhite),
          const SizedBox(width: 10.0),
          aboutDataElement(aboutData[AboutLiteral.address.label], 12),
        ]),
        const SizedBox(height: 5.0),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.email, size: 18, color: backgroundWhite),
          const SizedBox(width: 10.0),
          aboutDataElement(aboutData[AboutLiteral.email.label], 12),
          const SizedBox(width: 20.0),
          const Icon(Icons.phone, size: 18, color: backgroundWhite),
          const SizedBox(width: 10.0),
          aboutDataElement(aboutData[AboutLiteral.phone.label], 12),
          const SizedBox(width: 20.0),
          const Icon(FontAwesomeIcons.linkedin,
              size: 18, color: backgroundWhite),
          const SizedBox(width: 10.0),
          aboutDataElement(aboutData[AboutLiteral.linkedin.label], 12),
        ]),
      ],
    ),
  );
}

Expanded aboutDataElement(
  String dataElement,
  int fontSize,
) {
  return Expanded(
      child: Text(
    dataElement,
    style: const TextStyle(fontSize: 12, color: backgroundWhite),
  ));
}
