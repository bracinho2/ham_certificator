import 'package:flutter/material.dart';

class GuaraniFooterWidget extends StatelessWidget {
  const GuaraniFooterWidget({
    super.key,
    this.height,
    this.width,
    this.onLongPress,
  });

  final double? height;
  final double? width;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Row(
      children: [
        Container(
          height: mediaQueryData.size.height * .1,
          width: mediaQueryData.size.width,
          color: Colors.black87,
          child: Center(
            child: GestureDetector(
              onLongPress: onLongPress,
              child: const Text(
                'Dev PY5TH | Sulina - Paraná - Brasil | Versão 0.0.1',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
