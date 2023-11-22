import 'package:flutter/material.dart';
import 'package:guarani/guarani.dart';
import 'package:ham_certificator/core/services/pdf/pdf/pdf_file_generator.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PDFPreviewWidget extends StatefulWidget {
  const PDFPreviewWidget({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  State<PDFPreviewWidget> createState() => _PDFPreviewWidgetState();
}

class _PDFPreviewWidgetState extends State<PDFPreviewWidget> {
  Map<String, dynamic> get _data => widget.data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GuaraniHeaderMenuWidget(
        showEvent: true,
        eventName: _data['title'],
      ),
      body: PdfPreview(
        initialPageFormat: PdfPageFormat.a4,
        canDebug: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
        allowPrinting: false,
        allowSharing: false,
        build: (context) => PdfFileGenerator().create(
          title: _data['title'],
          phrase: _data['phrase'],
          emphasis: _data['enphasis'],
          dateTime: _data['date'],
          backgroudImage: 'assets/certificado_grato.jpg',
        ),
        pdfFileName: 'ham_party_certificator.pdf',
        loadingWidget: const CircularProgressIndicator(),
      ),
      bottomNavigationBar: const GuaraniFooterWidget(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.download),
        onPressed: () async {
          Printing.layoutPdf(
            onLayout: (PdfPageFormat page) async =>
                await PdfFileGenerator().create(
              title: _data['title'],
              phrase: _data['phrase'],
              emphasis: _data['enphasis'],
              dateTime: _data['date'],
              backgroudImage: 'assets/certificado_grato.jpg',
            ),
          );
          // Printing.sharePdf(
          //   bytes: await PdfFileGenerator().create(
          //     title: _data['title'],
          //     phrase: _data['phrase'],
          //     emphasis: _data['enphasis'],
          //     dateTime: _data['date'],
          //     backgroudImage: 'assets/certificado_grato.jpg',
          //   ),
          //   filename: 'ham_certificator.pdf',
          // );
        },
      ),
    );
  }
}
