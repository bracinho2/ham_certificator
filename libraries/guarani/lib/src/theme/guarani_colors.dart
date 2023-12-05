import 'package:flutter/material.dart';

class GuaraniColors extends ThemeExtension<GuaraniColors> {
  GuaraniColors({
    this.brandColor,
    this.brandSecondaryColor,
  });

  final Color? brandColor;
  final Color? brandSecondaryColor;

  @override
  ThemeExtension<GuaraniColors> copyWith({
    Color? brandSecondaryColor,
    Color? mySecundaryColor,
  }) {
    return GuaraniColors(
      brandColor: brandColor ?? this.brandSecondaryColor,
      brandSecondaryColor: mySecundaryColor ?? this.brandSecondaryColor,
    );
  }

  @override
  ThemeExtension<GuaraniColors> lerp(
    covariant ThemeExtension<GuaraniColors>? other,
    double t,
  ) {
    if (other is! GuaraniColors) {
      return this;
    }

    return GuaraniColors(
      brandColor: Color.lerp(brandColor, other.brandColor, t)!,
      brandSecondaryColor:
          Color.lerp(brandSecondaryColor, other.brandSecondaryColor, t)!,
    );
  }
}
