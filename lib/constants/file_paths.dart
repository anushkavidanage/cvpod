/// File path constants.
///
/// Copyright (C) 2024, Software Innovation Institute
///
/// Licensed under the GNU General Public License, Version 3 (the "License");
///
/// License: https://www.gnu.org/licenses/gpl-3.0.en.html
//
// Time-stamp: <Wednesday 2023-11-01 08:26:39 +1100 Graham Williams>
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

/// File name constants
const String summaryFile = 'cv-summary.ttl';
const String aboutFile = 'cv-about.ttl';
const String eduFile = 'cv-education.ttl';
const String profFile = 'cv-professional.ttl';
const String resFile = 'cv-research.ttl';
const String pubFile = 'cv-publications.ttl';
const String awardFile = 'cv-awards.ttl';
const String presFile = 'cv-presentations.ttl';
const String extraFile = 'cv-extra.ttl';
const String refFile = 'cv-referees.ttl';

/// File path constants
const String summaryPath = 'cvpod/data/$summaryFile';
const String aboutPath = 'cvpod/data/$aboutFile';
const String eduPath = 'cvpod/data/$eduFile';
const String profPath = 'cvpod/data/$profFile';
const String resPath = 'cvpod/data/$resFile';
const String pubPath = 'cvpod/data/$pubFile';
const String awardPath = 'cvpod/data/$awardFile';
const String presPath = 'cvpod/data/$presFile';
const String extraPath = 'cvpod/data/$extraFile';
const String refPath = 'cvpod/data/$refFile';

/// A map of file paths
final Map filePathMap = {
  'summary': summaryPath,
  'about': aboutPath,
  'education': eduPath,
  'professional': profPath,
  'research': resPath,
  'publications': pubPath,
  'awards': awardPath,
  'presentations': presPath,
  'extra': extraPath,
  'referees': refPath,
};
