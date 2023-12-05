import 'package:flutter/material.dart';
import 'package:guarani/guarani.dart';

class GuaraniTextDescriptionWidget extends StatelessWidget {
  const GuaraniTextDescriptionWidget({
    super.key,
    this.textSize = 50,
    this.textAlign = TextAlign.center,
    required this.label,
  });

  final double textSize;
  final TextAlign textAlign;
  final String label;

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).extension<GuaraniStyles>();
    return Text(
      label,
      textAlign: textAlign,
      style: styles?.description,
    );
  }
}
