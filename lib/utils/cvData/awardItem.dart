/// Award item class.
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

/// [AwardItem] is a class for Award entries
class AwardItem {
  /// Entry created time
  String createdTime;

  /// Entry last updated time
  String updatedTime;

  /// Degree value
  String title;

  /// Duration value
  String year;

  /// Institute value
  String description;

  /// Award entry constructor
  AwardItem(
    this.createdTime,
    this.updatedTime,
    this.title,
    this.year,
    this.description,
  );
}

/// Award data literals for CV Pod
enum AwardLiteral {
  title('title'),

  year('year'),

  description('description');

  /// Generative enum constructor
  const AwardLiteral(this.value);

  /// String label of data type
  final String value;

  /// Return the URIRef of literal predicate
  URIRef get uriRef => URIRef('$cvData$value');
}
