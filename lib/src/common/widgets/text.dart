import 'package:agent/src/common/extensions/context.dart';
import 'package:agent/src/config/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final double? size;
  final String text;
  final Color? color;
  final int? weight;
  final String? font;
  final TextAlign? align;
  final int? line;
  final double? letterSpacing;
  final double? height;
  final bool? underline;

  const AppText(
    this.text, {
    super.key,
    this.size,
    this.color,
    this.weight,
    this.font,
    this.align,
    this.letterSpacing,
    this.line,
    this.height,
    this.underline,
  });

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: align ?? TextAlign.left,
        maxLines: line,
        overflow: line != null ? TextOverflow.ellipsis : null,
        softWrap: line != null ? true : null,
        style: GoogleFonts.roboto(
          fontWeight: getWeight(weight),
          color: color ?? cl(context).tertiary,
          fontSize: size ?? 16,
          letterSpacing: letterSpacing ?? 0,
          height: height,
          decoration: underline == true ? TextDecoration.underline : null,
        ),
      );
}

class TextProperties {
  final String text;
  final Color? color;
  final double? size;
  final void Function()? onTap;
  final int weight;

  TextProperties({
    required this.text,
    this.color,
    this.onTap,
    this.size,
    this.weight = 400,
  });
}

class MultiText extends StatelessWidget {
  final List<TextProperties> textPropertiesList;
  final double? height;
  const MultiText({required this.textPropertiesList, super.key, this.height});

  @override
  Widget build(BuildContext context) => RichText(
        text: TextSpan(
          children: textPropertiesList
              .map((textProperties) => TextSpan(
                    text: textProperties.text,
                    style: GoogleFonts.darkerGrotesque(
                      color: textProperties.color ?? context.color.tertiary,
                      height: height ?? 1,
                      fontWeight: getWeight(textProperties.weight),
                      fontSize: textProperties.size ?? 15,
                    ),
                    recognizer: textProperties.onTap == null
                        ? null
                        : TapGestureRecognizer()
                      ?..onTap = textProperties.onTap,
                  ))
              .toList(),
        ),
      );
}
