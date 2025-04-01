import 'package:agent/src/common/extensions/context.dart';
import 'package:agent/src/config/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class InputField extends HookWidget {
  final TextEditingController? controller;
  final TextCapitalization? capitalization;
  final TextInputType? type;
  final String? placeholder;
  final String? label;
  final Color? placeholderColor;
  final Color? textColor;
  final double? size;
  final double? radius;
  final double? height;
  final int? maxLine;
  final int? minLine;
  final int? length;
  final EdgeInsets? padding;
  final InputBorder? border;
  final Color? borderColor;
  final bool? editable;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? prefixIcon;
  final String? font;
  final void Function()? onTap;
  final void Function(String value)? onChange;
  final void Function(String value)? onSubmit;
  final bool? isPassword;
  final Color? fillColor;
  final bool? focus;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  const InputField({
    super.key,
    this.controller,
    this.capitalization,
    this.type,
    this.placeholder,
    this.label,
    this.placeholderColor,
    this.textColor,
    this.size,
    this.maxLine,
    this.minLine,
    this.length,
    this.padding,
    this.border,
    this.editable,
    this.radius,
    this.height,
    this.suffixIcon,
    this.suffix,
    this.prefix,
    this.prefixIcon,
    this.font,
    this.onTap,
    this.onChange,
    this.onSubmit,
    this.isPassword,
    this.fillColor,
    this.focus,
    this.focusNode,
    this.borderColor,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = useState(isPassword ?? false);

    return SizedBox(
      height: height ?? (maxLine != null ? (maxLine! * 15) - 5 : 50),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: focus ?? false,
        // maxLength: length,
        minLines: minLine,
        maxLines: maxLine ?? 1,
        style: GoogleFonts.roboto(
          color: textColor ?? context.color.tertiary,
          fontSize: size ?? 15,
        ),
        enabled: editable ?? true,
        validator: validator,
        inputFormatters: [LengthLimitingTextInputFormatter(length)],
        decoration: InputDecoration(
          filled: editable == false || fillColor != null,
          fillColor: editable == false ? Colors.grey[100] : fillColor,
          labelText: label,
          contentPadding: padding ??
              const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          labelStyle: GoogleFonts.roboto(
            color: context.color.tertiary,
            fontSize: size ?? 15,
          ),
          constraints: const BoxConstraints(maxHeight: 60),
          border: border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 5),
                borderSide: BorderSide(
                  width: 0.5,
                  color: borderColor ?? lightTextColor,
                ),
              ),
          enabledBorder: border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 5),
                borderSide: BorderSide(
                  width: 0.5,
                  color: borderColor ?? lightTextColor,
                ),
              ),
          focusedBorder: border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 5),
                borderSide: BorderSide(
                  width: 0.5,
                  color: borderColor ?? lightTextColor,
                ),
              ),
          alignLabelWithHint: true,
          hintText: placeholder,
          hintStyle: GoogleFonts.roboto(
            color: placeholderColor ?? const Color(0xFF828282),
            fontSize: size ?? 14,
          ),
          prefixIcon: prefixIcon,
          prefix: prefix,
          suffix: suffix,
          suffixIcon: isPassword == true
              ? InkWell(
                  child: Icon(
                    isPasswordVisible.value
                        ? Iconsax.eye_outline
                        : Iconsax.eye_slash_outline,
                    color: context.color.onSurface,
                  ),
                  onTap: () {
                    isPasswordVisible.value = !isPasswordVisible.value;
                  },
                )
              : suffixIcon,
        ),
        keyboardType: type ?? TextInputType.text,
        onChanged: onChange,
        onFieldSubmitted: onSubmit,
        obscureText: isPasswordVisible.value,
      ),
    );
  }
}
