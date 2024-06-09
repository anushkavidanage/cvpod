/// RESTful API functions
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

import 'package:flutter/material.dart';

import 'package:solidpod/solidpod.dart';
import 'package:cvpod/constants/file_paths.dart';

Future<Map<dynamic, dynamic>> readProfileData(
    BuildContext context, Widget child) async {
  Map profDataMap = {};

  for (String fileType in filePathMap.keys) {
    String filePath = filePathMap[fileType];

    String? fileContent = await readPod(filePath, context, child);

    profDataMap[fileType] = fileContent ?? '';
  }

  return profDataMap;
}
