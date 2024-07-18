/// Extra item class.
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

import 'package:rdflib/rdflib.dart';

import 'package:cvpod/constants/schema.dart';

/// [ExtraItem] is a class for extra/volunteering activity entries
class ExtraItem {
  /// Entry created time
  String createdTime;

  /// Entry last updated time
  String updatedTime;

  /// Description value
  String description;

  /// Duration value
  String duration;

  /// Extra entry constructor
  ExtraItem(
    this.createdTime,
    this.updatedTime,
    this.description,
    this.duration,
  );
}

/// Extra data literals for CV Pod
enum ExtraLiteral {
  createdTime('createdTime'),

  updatedTime('updatedTime'),

  description('description'),

  duration('duration');

  /// Generative enum constructor
  const ExtraLiteral(this._value);

  /// String label of data type
  final String _value;

  /// Return the string value of data type
  String get label => _value;

  /// Return the URIRef of literal predicate
  URIRef get uriRef => URIRef('$cvData$_value');
}
