import 'package:flutter/material.dart';

final guaraniStyles = GuaraniStyles(
  title: const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 40,
    fontWeight: FontWeight.w700,
  ),
  description: const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w500,
  ),
);

class GuaraniStyles extends ThemeExtension<GuaraniStyles> {
  GuaraniStyles({
    this.title,
    this.description,
  });

  final TextStyle? title;
  final TextStyle? description;

  @override
  ThemeExtension<GuaraniStyles> copyWith({
    TextStyle? title,
    TextStyle? description,
  }) {
    return GuaraniStyles(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  ThemeExtension<GuaraniStyles> lerp(
    covariant ThemeExtension<GuaraniStyles>? other,
    double t,
  ) {
    if (other is! GuaraniStyles) {
      return this;
    }

    return GuaraniStyles(
      title: TextStyle.lerp(title, other.title, t)!,
      description: TextStyle.lerp(description, other.description, t)!,
    );
  }
}
