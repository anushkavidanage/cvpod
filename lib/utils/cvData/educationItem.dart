/// Education item class.
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

/// [EducationItem] is a class for education entries
class EducationItem {
  /// Entry created time
  String createdTime;

  /// Entry last updated time
  String updatedTime;

  /// Degree value
  String degree;

  /// Duration value
  String duration;

  /// Institute value
  String institute;

  /// Description value
  String comment;

  /// Education entry constructor
  EducationItem(
    this.createdTime,
    this.updatedTime,
    this.degree,
    this.duration,
    this.institute,
    this.comment,
  );
}
