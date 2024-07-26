/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:cvpod/utils/cvData/awardItem.dart';
import 'package:cvpod/utils/cvData/educationItem.dart';
import 'package:cvpod/utils/cvData/extraItem.dart';
import 'package:cvpod/utils/cvData/presentationItem.dart';
import 'package:cvpod/utils/cvData/professionalItem.dart';
import 'package:cvpod/utils/cvData/publicationItem.dart';
import 'package:cvpod/utils/cvData/researchItem.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:cvpod/constants/app.dart';
import 'package:cvpod/utils/cvData/aboutItem.dart';
import 'package:cvpod/utils/cv_manager.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const PdfColor titleColor = PdfColor.fromInt(0xFF132f3b);
const PdfColor subTitleColor = PdfColor.fromInt(0xFF265d77);
const PdfColor categoryTitleBg = PdfColor.fromInt(0xFFb7e4f8);
const PdfColor blockBorder = PdfColor.fromInt(0xFF388cb2);
const sep = 120.0;

Future<Uint8List> generateResume(
    PdfPageFormat format, CvManager cvManager, Map dataTypes) async {
  final doc =
      pw.Document(title: 'Curriculum Vitae', creator: 'Anushka Vidanage');

  final profileImage = cvManager.portraitBytes != null
      ? pw.MemoryImage((cvManager.portraitBytes as Uint8List))
      : pw.MemoryImage(
          (await rootBundle.load('assets/images/avatar.png'))
              .buffer
              .asUint8List(),
        );

  final pageTheme = await _myPageTheme(format);

  // Extract about from the cv manager
  // Since about data is a map get the first item in the map
  final aboutData = cvManager.getAbout;
  // If map is empty assign a default AboutItem with emptry values
  AboutItem aboutDataItem = aboutData.isNotEmpty
      ? aboutData[aboutData.keys.toList().first]
      : AboutItem('', '', '', '', '', '', '', '', '', '');

  // Extract other information from the cv manager
  final summaryData = cvManager.getSummary;
  final professionalData = cvManager.getProfessional;
  final educationData = cvManager.getEducation;
  final researchData = cvManager.getResearch;
  final publicationsData = cvManager.getPublications;
  final awardsData = cvManager.getAwards;
  final presentationsData = cvManager.getPresentations;
  final extraData = cvManager.getExtra;
  final refereesData = cvManager.getReferees;

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) => [
        pw.Partitions(
          children: [
            pw.Partition(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Container(
                    padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[
                        pw.Partitions(children: [
                          pw.Partition(
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: <pw.Widget>[
                                  pw.Text(aboutDataItem.name,
                                      textScaleFactor: 2.5,
                                      style: pw.Theme.of(context)
                                          .defaultTextStyle
                                          .copyWith(
                                              fontWeight: pw.FontWeight.bold,
                                              color: titleColor)),
                                  pw.Padding(
                                      padding:
                                          const pw.EdgeInsets.only(top: 10)),
                                  pw.Text(aboutDataItem.position,
                                      textScaleFactor: 1.4,
                                      style: pw.Theme.of(context)
                                          .defaultTextStyle
                                          .copyWith(
                                              fontWeight: pw.FontWeight.bold,
                                              color: subTitleColor)),
                                  pw.Padding(
                                      padding:
                                          const pw.EdgeInsets.only(top: 25)),
                                ]),
                          ),
                          if (dataTypes[DataType.portrait]) ...[
                            pw.Partition(
                              width: sep,
                              child: pw.Column(
                                children: [
                                  pw.Container(
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      children: <pw.Widget>[
                                        pw.ClipOval(
                                          child: pw.Container(
                                              width: 100,
                                              height: 100,
                                              //color: categoryTitleBg,
                                              child: pw.Image(profileImage),
                                              foregroundDecoration:
                                                  pw.BoxDecoration(
                                                border: pw.Border.all(
                                                  color: subTitleColor,
                                                  width: 5.0,
                                                ),
                                                borderRadius: const pw
                                                    .BorderRadius.all(
                                                    pw.Radius.circular(50.0)),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ]),
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: <pw.Widget>[
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                //pw.Icon(const pw.IconData(0xe926)),
                                pw.Text(aboutDataItem.address),
                                pw.Text(aboutDataItem.phone),
                                _UrlText(aboutDataItem.email,
                                    'mailto:${aboutDataItem.email}'),
                                pw.Padding(
                                    padding: const pw.EdgeInsets.only(top: 10)),
                                _UrlText(aboutDataItem.linkedin,
                                    aboutDataItem.linkedin),
                                _UrlText(aboutDataItem.web, aboutDataItem.web),
                              ],
                            ),
                            // pw.Column(
                            //   crossAxisAlignment: pw.CrossAxisAlignment.start,
                            //   children: <pw.Widget>[
                            //     pw.Text(''),
                            //     _UrlText(aboutData['email'],
                            //         'mailto:${aboutData['email']}'),
                            //     _UrlText(aboutData['web'], aboutData['web']),
                            //   ],
                            // ),
                            pw.Padding(padding: pw.EdgeInsets.zero)
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Summary block
                  if (dataTypes[DataType.summary]) ...[
                    _Category(title: 'Summary'),
                    _SummaryBlock(summary: summaryData),
                  ],

                  // Professional block
                  if (dataTypes[DataType.professional]) ...[
                    _Category(title: 'Professional'),
                    for (ProfessionalItem professionalItem
                        in professionalData.values) ...[
                      _CustomBlock(
                          title: professionalItem.title,
                          duration: professionalItem.duration,
                          place: professionalItem.company,
                          comments: professionalItem.comments)
                    ],
                  ],

                  // Education block
                  if (dataTypes[DataType.education]) ...[
                    _Category(title: 'Education'),
                    for (EducationItem educationItem
                        in educationData.values) ...[
                      _CustomBlock(
                          title: educationItem.degree,
                          duration: educationItem.duration,
                          place: educationItem.institute,
                          comments: educationItem.comments)
                    ],
                  ],

                  // Research block
                  if (dataTypes[DataType.research]) ...[
                    _Category(title: 'Research'),
                    for (ResearchItem researchItem in researchData.values) ...[
                      _CustomBlock(
                          title: researchItem.title,
                          duration: researchItem.duration,
                          place: researchItem.institute,
                          comments: researchItem.comments)
                    ],
                  ],

                  // Publications block
                  if (dataTypes[DataType.publication]) ...[
                    _Category(title: 'Publications'),
                    for (PublicationItem publicationItem
                        in publicationsData.values) ...[
                      _CustomBlock(
                        title: publicationItem.citation,
                        duration: publicationItem.year,
                      )
                    ],
                  ],

                  // Awards block
                  if (dataTypes[DataType.award]) ...[
                    _Category(title: 'Awards'),
                    for (AwardItem awardItem in awardsData.values) ...[
                      _CustomBlock(
                        title: awardItem.title,
                        duration: awardItem.year,
                        comments: awardItem.description,
                      )
                    ],
                  ],

                  // Preseantations block
                  if (dataTypes[DataType.presentation]) ...[
                    _Category(title: 'Presentations'),
                    for (PresentationItem presentationItem
                        in presentationsData.values) ...[
                      _CustomBlock(
                        title: presentationItem.description,
                        duration: presentationItem.year,
                        url: presentationItem.url,
                      )
                    ],
                  ],

                  // Extra block
                  if (dataTypes[DataType.extra]) ...[
                    _Category(title: 'Volunteering/Involvements'),
                    for (ExtraItem extraItem in extraData.values) ...[
                      _CustomBlock(
                        title: extraItem.description,
                        duration: extraItem.duration,
                      )
                    ],
                  ],

                  // Referees block
                  if (dataTypes[DataType.referee]) ...[
                    _Category(title: 'Referees'),
                    _RefereeBlock(refereeData: refereesData),
                  ],

                  // Other template
                  // _Category(title: 'Work Experience'),
                  // _Block(
                  //     title: 'Tour bus driver',
                  //     icon: const pw.IconData(0xe530)),
                  // _Block(
                  //     title: 'Logging equipment operator',
                  //     icon: const pw.IconData(0xe30d)),
                  // _Block(title: 'Foot doctor', icon: const pw.IconData(0xe3f3)),
                  // _Block(
                  //     title: 'Unicorn trainer',
                  //     icon: const pw.IconData(0xf0cf)),
                  // _Block(
                  //     title: 'Chief chatter', icon: const pw.IconData(0xe0ca)),
                  // pw.SizedBox(height: 20),
                  // _Category(title: 'Education'),
                  // _Block(title: 'Bachelor Of Commerce'),
                  // _Block(title: 'Bachelor Interior Design'),
                ],
              ),
            ),
            // pw.Partition(
            //   width: sep,
            //   child: pw.Column(
            //     children: [
            //       pw.Container(
            //         height: pageTheme.pageFormat.availableHeight,
            //         child: pw.Column(
            //           crossAxisAlignment: pw.CrossAxisAlignment.center,
            //           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            //           children: <pw.Widget>[
            //             pw.ClipOval(
            //               child: pw.Container(
            //                 width: 100,
            //                 height: 100,
            //                 color: categoryTitleBg,
            //                 child: pw.Image(profileImage),
            //               ),
            //             ),
            //             // pw.Column(children: <pw.Widget>[
            //             //   _Percent(size: 60, value: .7, title: pw.Text('Word')),
            //             //   _Percent(
            //             //       size: 60, value: .4, title: pw.Text('Excel')),
            //             // ]),
            //             // pw.BarcodeWidget(
            //             //   data: 'Parnella Charlesbois',
            //             //   width: 60,
            //             //   height: 60,
            //             //   barcode: pw.Barcode.qrCode(),
            //             //   drawText: false,
            //             // ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ],
    ),
  );
  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString('assets/images/temp1.svg');
  //final bgShape1 = await rootBundle.loadString('assets/images/temp2.svg');
  // final bgShape2 = pw.MemoryImage(
  //   (await rootBundle.load('assets/images/temp3.png')).buffer.asUint8List(),
  // );

  format = format.applyMargin(
      left: 2.0 * PdfPageFormat.cm,
      top: 4.0 * PdfPageFormat.cm,
      right: 2.0 * PdfPageFormat.cm,
      bottom: 2.0 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Positioned(
              child: pw.SvgImage(svg: bgShape),
              //child: pw.Image(bgShape2),
              left: 0,
              top: 0,
            ),
            pw.Positioned(
              child: pw.Transform.rotate(
                  angle: pi, child: pw.SvgImage(svg: bgShape)),
              right: 0,
              bottom: 0,
            ),
          ],
        ),
      );
    },
  );
}

class _SummaryBlock extends pw.StatelessWidget {
  _SummaryBlock({
    required this.summary,
  });

  final Map summary;

  @override
  pw.Widget build(pw.Context context) {
    final summaryItem = summary[summary.keys.toList().first];
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Container(
            padding: const pw.EdgeInsets.only(left: 0, top: 0, bottom: 5),
            margin: const pw.EdgeInsets.only(left: 5),
            child: pw.Text(summaryItem.summary),
          ),
        ]);
  }
}

class _RefereeBlock extends pw.StatelessWidget {
  _RefereeBlock({
    required this.refereeData,
  });

  final Map refereeData;

  @override
  pw.Widget build(pw.Context context) {
    int numRefRows = (refereeData.length / 2).ceil();

    List refereeList = [];
    refereeData.forEach((key, val) => refereeList.add(val));

    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Table(children: <pw.TableRow>[
            for (int i = 0; i < numRefRows; i += 1) ...[
              pw.TableRow(children: <pw.Widget>[
                pw.Container(
                  padding: const pw.EdgeInsets.fromLTRB(0, 10, 0, 0),
                  //width: cWidth,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text(refereeList[i * 2].name,
                          style: pw.Theme.of(context)
                              .defaultTextStyle
                              .copyWith(fontWeight: pw.FontWeight.bold)),
                      pw.Text(refereeList[i * 2].position),
                      pw.Text(refereeList[i * 2].institute),
                      pw.Text(refereeList[i * 2].email),
                    ],
                  ),
                ),
                pw.SizedBox(width: 15),
                if (refereeList.length > (i * 2) + 1)
                  pw.Container(
                    padding: const pw.EdgeInsets.fromLTRB(0, 10, 0, 0),
                    //width: cWidth,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[
                        pw.Text(refereeList[(i * 2) + 1].name,
                            style: pw.Theme.of(context)
                                .defaultTextStyle
                                .copyWith(fontWeight: pw.FontWeight.bold)),
                        pw.Text(refereeList[(i * 2) + 1].position),
                        pw.Text(refereeList[(i * 2) + 1].institute),
                        pw.Text(refereeList[(i * 2) + 1].email),
                      ],
                    ),
                  ),
              ])
            ],
          ])
        ]);

    // return pw.Column(
    //     crossAxisAlignment: pw.CrossAxisAlignment.start,
    //     children: <pw.Widget>[
    //       for (int i = 0; i < numRefRows; i += 1) ...[
    //         pw.Container(
    //           padding: const pw.EdgeInsets.only(left: 0, top: 0, bottom: 5),
    //           margin: const pw.EdgeInsets.only(left: 5),
    //           child: pw.Row(
    //             crossAxisAlignment: pw.CrossAxisAlignment.start,
    //             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    //             children: <pw.Widget>[
    //               pw.Column(
    //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
    //                 children: <pw.Widget>[
    //                   //pw.Icon(const pw.IconData(0xe926)),
    //                   pw.Text(refereeList[i]['name']),
    //                   pw.Text(refereeList[i]['position']),
    //                   pw.Text(refereeList[i]['institute']),
    //                   pw.Container(
    //                     child: pw.Expanded(
    //                       flex: 5,
    //                       child: pw.Container(
    //                         margin: const pw.EdgeInsets.only(left: 5),
    //                         child: pw.Column(
    //                             crossAxisAlignment: pw.CrossAxisAlignment.start,
    //                             children: <pw.Widget>[
    //                               pw.Text(
    //                                 refereeList[i]['institute'],
    //                               ),
    //                             ]),
    //                       ),
    //                     ),
    //                   ),
    //                   pw.Text(refereeList[i]['email']),
    //                 ],
    //               ),
    //               pw.Column(
    //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
    //                 children: <pw.Widget>[
    //                   pw.Text(refereeList[i + 1]['name']),
    //                   pw.Text(refereeList[i + 1]['position']),
    //                   pw.Container(
    //                     child: pw.Expanded(
    //                       flex: 3,
    //                       child: pw.Container(
    //                         margin: const pw.EdgeInsets.only(left: 5),
    //                         child: pw.Column(
    //                             crossAxisAlignment: pw.CrossAxisAlignment.start,
    //                             children: <pw.Widget>[
    //                               pw.Text(
    //                                 refereeList[i + 1]['institute'],
    //                               ),
    //                             ]),
    //                       ),
    //                     ),
    //                   ),
    //                   pw.Text(refereeList[i + 1]['email']),
    //                 ],
    //               ),
    //               pw.Padding(padding: pw.EdgeInsets.zero)
    //             ],
    //           ),
    //         ),
    //       ],
    //     ]);
    // return pw.Container(
    //     child: pw.Column(
    //   children: [
    // pw.GridView(
    //   // Create a grid with 2 columns. If you change the scrollDirection to
    //   // horizontal, this produces 2 rows.
    //   crossAxisCount: 2,
    //   childAspectRatio: 1,
    //   // Generate 100 widgets that display their index in the List.
    //   children: List.generate(3, (index) {
    //     return pw.Center(
    //       child: pw.Text(
    //         'Item $index',
    //         //style: pw.Theme.of(context).textTheme.headlineSmall,
    //       ),
    //     );
    //   }),
    // ),
    //   ],
    // ));
  }
}

pw.Widget myBox(int index) {
  return pw.Container(
    margin: const pw.EdgeInsets.all(8),
    color: titleColor,
    alignment: pw.Alignment.center,
    child: pw.Text('$index'),
  );
}

class _CustomBlock extends pw.StatelessWidget {
  _CustomBlock({
    required this.title,
    required this.duration,
    this.place,
    this.comments,
    this.url,
  });

  final String title;

  final String duration;

  final String? place;

  final String? comments;

  final String? url;

  @override
  pw.Widget build(pw.Context context) {
    if (url != null) {
      return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Container(
                    width: 6,
                    height: 6,
                    margin:
                        const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
                    decoration: const pw.BoxDecoration(
                      color: blockBorder,
                      shape: pw.BoxShape.circle,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      margin: const pw.EdgeInsets.only(left: 5),
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: <pw.Widget>[
                            pw.Text(
                              '$title $duration',
                            ),
                          ]),
                    ),
                  ),
                ]),
            if (url != null) ...[
              pw.Container(
                padding: const pw.EdgeInsets.only(left: 15, top: 5, bottom: 10),
                margin: const pw.EdgeInsets.only(left: 5),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: <pw.Widget>[
                      _UrlText(url!, url!),
                    ]),
              ),
            ]
          ]);
    } else {
      return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Container(
                    width: 6,
                    height: 6,
                    margin:
                        const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
                    decoration: const pw.BoxDecoration(
                      color: blockBorder,
                      shape: pw.BoxShape.circle,
                    ),
                  ),
                  if (place == null && comments == null && url == null) ...[
                    pw.Expanded(
                      flex: 10,
                      child: pw.Container(
                        margin: const pw.EdgeInsets.only(left: 5),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: <pw.Widget>[
                              pw.Text(
                                title,
                              ),
                            ]),
                      ),
                    ),
                  ] else ...[
                    pw.Expanded(
                      flex: 10,
                      child: pw.Container(
                        margin: const pw.EdgeInsets.only(left: 5),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: <pw.Widget>[
                              pw.Text(title,
                                  style: pw.Theme.of(context)
                                      .defaultTextStyle
                                      .copyWith(
                                          fontWeight: pw.FontWeight.bold)),
                            ]),
                      ),
                    ),
                  ],
                  pw.Spacer(),
                  pw.Text(duration),
                ]),
            if (place != null) ...[
              pw.Container(
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        left: pw.BorderSide(color: blockBorder, width: 2))),
                padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
                margin: const pw.EdgeInsets.only(left: 5),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text(
                        place!,
                        style: pw.Theme.of(context)
                            .defaultTextStyle
                            .copyWith(fontStyle: pw.FontStyle.italic),
                      ),
                    ]),
              ),
            ],
            if (comments != null) ...[
              pw.Container(
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        left: pw.BorderSide(color: blockBorder, width: 2))),
                padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
                margin: const pw.EdgeInsets.only(left: 5),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text(
                        comments!.replaceAll(';', '\n'),
                      ),
                    ]),
              ),
            ],
          ]);
    }
  }
}

class _Block extends pw.StatelessWidget {
  _Block({
    required this.title,
    this.icon,
  });

  final String title;

  final pw.IconData? icon;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  width: 6,
                  height: 6,
                  margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
                  decoration: const pw.BoxDecoration(
                    color: blockBorder,
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.Text(title,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontWeight: pw.FontWeight.bold)),
                pw.Spacer(),
                if (icon != null)
                  pw.Icon(icon!, color: subTitleColor, size: 18),
              ]),
          pw.Container(
            decoration: const pw.BoxDecoration(
                border: pw.Border(
                    left: pw.BorderSide(color: blockBorder, width: 2))),
            padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
            margin: const pw.EdgeInsets.only(left: 5),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Lorem(length: 20),
                ]),
          ),
        ]);
  }
}

class _Category extends pw.StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: categoryTitleBg,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(
        title,
        textScaleFactor: 1.5,
      ),
    );
  }
}

class _Percent extends pw.StatelessWidget {
  _Percent({
    required this.size,
    required this.value,
    required this.title,
  });

  final double size;

  final double value;

  final pw.Widget title;

  static const fontSize = 1.2;

  PdfColor get color => green;

  static const backgroundColor = PdfColors.grey300;

  static const strokeWidth = 5.0;

  @override
  pw.Widget build(pw.Context context) {
    final widgets = <pw.Widget>[
      pw.Container(
        width: size,
        height: size,
        child: pw.Stack(
          alignment: pw.Alignment.center,
          fit: pw.StackFit.expand,
          children: <pw.Widget>[
            pw.Center(
              child: pw.Text(
                '${(value * 100).round().toInt()}%',
                textScaleFactor: fontSize,
              ),
            ),
            pw.CircularProgressIndicator(
              value: value,
              backgroundColor: backgroundColor,
              color: color,
              strokeWidth: strokeWidth,
            ),
          ],
        ),
      )
    ];

    widgets.add(title);

    return pw.Column(children: widgets);
  }
}

class _UrlText extends pw.StatelessWidget {
  _UrlText(this.text, this.url);

  final String text;
  final String url;

  @override
  pw.Widget build(pw.Context context) {
    return pw.UrlLink(
      destination: url,
      child: pw.Text(text,
          style: const pw.TextStyle(
            decoration: pw.TextDecoration.underline,
            color: PdfColors.blue900,
          )),
    );
  }
}
