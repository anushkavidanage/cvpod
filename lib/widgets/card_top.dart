/// Top menu item.
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

import 'package:cvpod/constants/colors.dart';

class CardTop extends StatelessWidget {

  final bool isColor;
  final String text;
  final IconData icon;
  final Widget? page;

  const CardTop({
    super.key,  
    required this.isColor, 
    required this.text, 
    required this.icon, 
    this.page });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacement(context, 
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page!,
        transitionDuration: Duration(milliseconds: 300),
        transitionsBuilder: ( context, animation, _, child){
          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
            child: child,
          );
          }
        )
      ),
      child: 
      // Card(
      //               color: Colors.blue[5 * 100],
      //               child: new Container(
      //                 width: 50.0,
      //                 height: 50.0,
      //                 child: new Text("5"),
      //               ),)
      
      Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          color: isColor ? topCardSelect : topCardNotSelect,
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(this.icon, color: topCardIcon, size: 35),
            SizedBox(height: 6),
            Text(this.text, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}