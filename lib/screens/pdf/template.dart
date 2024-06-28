import 'dart:async';
import 'dart:typed_data';

import 'package:cvpod/utils/cv_manager.dart';
import 'package:pdf/pdf.dart';

import 'package:cvpod/screens/pdf/templates/template1.dart';

const templates = <Template>[
  Template('RÉSUMÉ', 'resume.dart', generateResume),
  // Theme('DOCUMENT', 'document.dart', generateDocument),
  // Theme('INVOICE', 'invoice.dart', generateInvoice),
  // Theme('REPORT', 'report.dart', generateReport),
  // Theme('CALENDAR', 'calendar.dart', generateCalendar),
  // Theme('CERTIFICATE', 'certificate.dart', generateCertificate, true),
];

typedef LayoutCallbackWithData = Future<Uint8List> Function(
    PdfPageFormat pageFormat, CvManager cvManager, Map dataTypes);

class Template {
  const Template(this.name, this.file, this.builder, [this.needsData = false]);

  final String name;

  final String file;

  final LayoutCallbackWithData builder;

  final bool needsData;
}
