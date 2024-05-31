/// Custom progress bar
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

class CustomProgressBar extends StatelessWidget {

  final String skill;
  final String porcentaje;
  final Color color;
  final double barra;

  const CustomProgressBar({ 
    required this.skill, 
    required this.porcentaje, 
    required this.color, 
    this.barra = 300});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( skill, style: TextStyle(color: Colors.black, fontSize: 16)),
              Text('$porcentaje%', style: TextStyle(color: Colors.black, fontSize: 16)),
            ],
          ),
          SizedBox(height: 10.0),
          Stack(
            children: [
              Container(
              height: 9,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.white
                )
              ),
              Container(
                height: 9,
                width: barra,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: this.color
                ),
              ),

            ],
            ),
          
        ],
      ),
    );
  }
}