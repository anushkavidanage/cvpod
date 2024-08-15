// Custom icons
//
// Copyright (C) 2024 Software Innovation Institute, Australian National University
//
// License: GNU General Public License, Version 3 (the "License")
// https://www.gnu.org/licenses/gpl-3.0.en.html
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
//
// Authors: Anushka Vidanage

import 'package:flutter/widgets.dart';

class CustomIcons {
  CustomIcons._();

  static const _kFontFam = 'CustomIcons';
  static const String? _kFontPkg = null;

  static const IconData fileExport = IconData(0xf56e, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData fileImport = IconData(0xf56f, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}