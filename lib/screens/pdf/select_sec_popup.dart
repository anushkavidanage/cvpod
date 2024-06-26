import 'package:cvpod/constants/app.dart';
import 'package:cvpod/constants/colors.dart';
import 'package:cvpod/screens/pdf/pdf_tabs.dart';
import 'package:cvpod/utils/alert.dart';
import 'package:cvpod/utils/cv_manager.dart';
import 'package:cvpod/utils/misc.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

void dataSelectDialog(BuildContext context, CvManager cvManager, String webId) {
  Map dataTypeSelectFlagMap = {
    summaryStr: false,
    educationStr: false,
    professionalStr: false,
    researchStr: false,
    publicationsStr: false,
    awardsStr: false,
    presentationsStr: false,
    extraStr: false,
    refereesStr: false,
  };

  const title = Padding(
    padding: EdgeInsets.all(8),
    child: Text(
      'Select sections to include in your CV PDF',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -40,
                  top: -40,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      backgroundColor: appMidBlue1,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          title,
                          Column(
                            children: dataTypeSelectList
                                .map((dataType) => Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: StatefulBuilder(
                                        builder: (context, setState) =>
                                            CheckboxListTile(
                                          activeColor: appDarkBlue1,
                                          value:
                                              dataTypeSelectFlagMap[dataType],
                                          onChanged: (value) => setState(() =>
                                              dataTypeSelectFlagMap[dataType] =
                                                  value!),
                                          title: Text(capitalize(dataType)),
                                          controlAffinity: ListTileControlAffinity
                                              .leading, //  <-- leading Checkbox
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              child: const Text('Build PDF'),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (dataTypeSelectFlagMap.values
                                      .any((element) => element)) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PdfTabs(
                                            webId: webId,
                                            cvManager: cvManager,
                                            dataTypes: dataTypeSelectFlagMap),
                                      ),
                                      (Route<dynamic> route) =>
                                          false, // This predicate ensures all previous routes are removed
                                    );
                                  } else {
                                    alert(context,
                                        'Please select minimum one section!');
                                  }
                                  //_formKey.currentState!.s3ave();

                                  // showAnimationDialog(
                                  //   context,
                                  //   24,
                                  //   'Saving data',
                                  //   false,
                                  // );

                                  // String title = formControllerProf1.text;
                                  // String duration = formControllerProf2.text;
                                  // String company = formControllerProf3.text;
                                  // String comments = formControllerProf4.text;

                                  // Map newDataMap = {
                                  //   'title': title,
                                  //   'duration': duration,
                                  //   'company': company,
                                  //   'comments': comments,
                                  // };

                                  // cvManager = await writeProfileData(
                                  //     context,
                                  //     cvManager,
                                  //     webId,
                                  //     professionalStr,
                                  //     newDataMap);

                                  // // Reload the page
                                  // Navigator.pushAndRemoveUntil(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => ProfileTabs(
                                  //             webId: webId,
                                  //             cvManager: cvManager,
                                  //           )),
                                  //   (Route<dynamic> route) =>
                                  //       false, // This predicate ensures all previous routes are removed
                                  // );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ));
}
