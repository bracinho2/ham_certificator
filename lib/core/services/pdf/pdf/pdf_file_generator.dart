import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfFileGenerator {
  Future<Uint8List> create({
    required String title,
    required String phrase,
    required List<String> emphasis,
    required String dateTime,
    required String backgroudImage,
  }) async {
    final Document doc = Document();

    final image = MemoryImage(
      (await rootBundle.load(
        backgroudImage,
      ))
          .buffer
          .asUint8List(),
    );

    doc.addPage(
      Page(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: EdgeInsets.zero,
        build: (context) => _buildContent(
          context: context,
          title: title,
          image: image,
          phrase: phrase,
          emphasis: emphasis,
          dateTime: dateTime,
        ),
      ),
    );

    return doc.save();
  }

  Widget _buildContent({
    required Context context,
    required String title,
    required String phrase,
    required List<String> emphasis,
    required MemoryImage image,
    required String dateTime,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        children: [
          Stack(
            children: [
              SizedBox(
                height: constraints!.maxHeight,
                width: constraints.maxWidth,
                child: Image(image),
              ),
              Expanded(
                child: Container(
                  width: constraints.maxWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 60,
                          ),
                          child: createRichText(
                            phrase: phrase,
                            emphasizedText: emphasis,
                          ),
                        ),
                      ),
                      Text(
                        dateTime,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

RichText createRichText({
  required String phrase,
  required List<String> emphasizedText,
}) {
  List<TextSpan> textSpans = [];

  for (String part in phrase.split('#')) {
    if (emphasizedText.contains(part)) {
      textSpans.add(
        TextSpan(
          text: part,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    } else {
      textSpans.add(
        TextSpan(
          text: part,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      );
    }
  }

  return RichText(
    softWrap: true,
    textAlign: TextAlign.justify,
    text: TextSpan(
      children: textSpans,
    ),
  );
}
