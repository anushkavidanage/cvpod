import 'package:cvpod/screens/pdf/select_sec_popup.dart';
import 'package:flutter/material.dart';

import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/utils/cv_manager.dart';

buildAppBar(BuildContext context, String webId, CvManager cvManager) {
  return AppBar(
    backgroundColor: appLightBlue1,
    centerTitle: true,
    title: const Text(
      'CV generator',
    ),
    actions: <Widget>[
      const SizedBox(width: 50),
      IconButton(
        tooltip: 'Build CV as a PDF',
        icon: const Icon(
          Icons.picture_as_pdf,
          color: Colors.black,
        ),
        onPressed: () {
          dataSelectDialog(context, cvManager, webId);
        },
      ),
      const SizedBox(width: 10),
      IconButton(
        tooltip: 'CV Sharing',
        icon: const Icon(
          Icons.share,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      const SizedBox(width: 10),
    ],
  );
}
