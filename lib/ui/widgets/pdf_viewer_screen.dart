import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatefulWidget {
  final String file;

  const PdfViewerScreen({Key? key, required this.file}) : super(key: key);

  static Future open(BuildContext context, String file) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(file: file),
      ),
    );
  }

  @override
  PdfViewerScreenState createState() => PdfViewerScreenState();
}

class PdfViewerScreenState extends State<PdfViewerScreen> {
  PdfViewerController? _pdfViewerController;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pdf Viewer'),
      ),
      body: SfPdfViewer.network(
        widget.file,
        controller: _pdfViewerController,
        enableDocumentLinkAnnotation: false,
        canShowPaginationDialog: false,
      ),
    );
  }
}
