import '../texts/certificate_texts.dart';

class PdfPrinterController {
  final title = 'Certificado';
  final phrase = CertificateTexts.radioamadorParticipante(
    callsign: 'PY5TH',
    operatorName: 'Alexandre Klock Ernzen',
    eventName: 'XII Encontro de Radioamadores',
    ownerName: 'Grupo de Radioamadores de Toledo',
    location: 'Clube de Caça e Pesca de Toledo',
  );

  final emphasis = <String>[
    'Alexandre Klock Ernzen',
    'PY5TH',
    'XII Encontro de Radioamadores',
    'Grupo de Radioamadores de Toledo',
  ];

  final backgroundImage = 'assets/certificate_border.jpg';
  final dateTime = 'Toledo - Paraná - Brasil, 12 de novembro de 2013';
}
