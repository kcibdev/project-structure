import 'package:agent/src/common/extensions/context.dart';
import 'package:agent/src/common/widgets/text.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double? radius;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final double? iconLeftPosition;
  final double? height;
  final double? fontSize;
  final int? textWeight;
  final VoidCallback onTap;
  final Color? borderColor;
  const Button(
    this.text, {
    required this.onTap,
    super.key,
    this.radius,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.icon,
    this.height,
    this.fontSize,
    this.textWeight,
    this.iconColor,
    this.iconSize,
    this.iconLeftPosition,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        enableFeedback: true,
        onTap: () => onTap(),
        child: Container(
          width: width ?? double.infinity,
          height: height ?? 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 10),
            color: backgroundColor ?? context.color.secondary,
            border:
                borderColor != null ? Border.all(color: borderColor!) : null,
          ),
          child: Stack(
            children: [
              if (icon != null)
                Positioned(
                  left: 16,
                  top: 0,
                  bottom: 0,
                  child: Icon(
                    icon,
                    size: iconSize,
                    color: iconColor,
                  ),
                ),
              Center(
                child: AppText(
                  text,
                  color: textColor ?? Colors.white,
                  weight: textWeight ?? 500,
                  size: fontSize ?? 15,
                ),
              ),
            ],
          ),
        ),
      );
}

class LinkButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final int? textWeight;
  final VoidCallback onTap;

  const LinkButton(
    this.text, {
    required this.onTap,
    super.key,
    this.textColor,
    this.fontSize,
    this.textWeight,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => onTap(),
        child: AppText(
          text,
          color: textColor ?? textColor,
          weight: textWeight ?? 500,
          size: fontSize ?? 15,
        ),
      );
}
