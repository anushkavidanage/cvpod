/// Publication item class.
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

/// [PublicationItem] is a class for Publication entries
class PublicationItem {
  /// Entry created time
  String createdTime;

  /// Entry last updated time
  String updatedTime;

  /// Citation value
  String citation;

  /// Year value
  String year;

  /// Publication entry constructor
  PublicationItem(
    this.createdTime,
    this.updatedTime,
    this.citation,
    this.year,
  );
}

/// Publication data literals for CV Pod
enum PublicationLiteral {
  citation('citation'),

  year('year');

  /// Generative enum constructor
  const PublicationLiteral(this.value);

  /// String label of data type
  final String value;

  /// Return the URIRef of literal predicate
  URIRef get uriRef => URIRef('$cvData$value');
}
