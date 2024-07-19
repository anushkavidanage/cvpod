/// Research item class.
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

/// [ResearchItem] is a class for Research entries
class ResearchItem {
  /// Entry created time
  String createdTime;

  /// Entry last updated time
  String updatedTime;

  /// Title value
  String title;

  /// Duration value
  String duration;

  /// Institute value
  String institute;

  /// Description value
  String comments;

  /// Research entry constructor
  ResearchItem(
    this.createdTime,
    this.updatedTime,
    this.title,
    this.duration,
    this.institute,
    this.comments,
  );
}

/// Research data literals for CV Pod
enum ResearchLiteral {
  title('title'),

  duration('duration'),

  institute('institute'),

  comments('comments');

  /// Generative enum constructor
  const ResearchLiteral(this._value);

  /// String label of data type
  final String _value;

  /// Return the string value of data type
  String get label => _value;

  /// Return the URIRef of literal predicate
  URIRef get uriRef => URIRef('$cvData$_value');
}
