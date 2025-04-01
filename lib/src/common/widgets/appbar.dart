import 'dart:io';

import 'package:agent/src/common/extensions/context.dart';
import 'package:agent/src/common/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customAppbar(
  BuildContext context, {
  required String title,
  Widget? child,
  double? elevation,
  bool isLeading = true,
  Color? backgroundColor,
  Color? textColor,
  Color? iconColor,
  List<Widget>? action,
  bool centerTitle = false,
  int textWeight = 600,
  double textSize = 19,
  double height = kToolbarHeight,
  Widget bottom = const SizedBox.shrink(),
}) {
  // For iOS, return CupertinoNavigationBar wrapped in a PreferredSize
  if (Platform.isIOS) {
    return _CupertinoNavBarWrapper(
      navigationBar: CupertinoNavigationBar(
        middle: child ??
            AppText(
              title,
              size: textSize,
              weight: textWeight,
              color: textColor,
            ),
        backgroundColor: backgroundColor ?? context.color.surface,
        leading: !isLeading
            ? null
            : CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.back,
                  color: iconColor ?? context.color.tertiary,
                  size: 30,
                ),
                onPressed: () => Navigator.maybePop(context),
              ),
        trailing: action != null && action.isNotEmpty
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: action,
              )
            : null,
        border: bottom is SizedBox
            ? null
            : Border(
                bottom: BorderSide(
                  color: context.color.outline,
                  width: 0.5,
                ),
              ),
      ),
      height: height,
    );
  }

  // For Android, return Material AppBar
  return AppBar(
    backgroundColor: backgroundColor ?? context.color.surface,
    centerTitle: centerTitle,
    toolbarHeight: height,
    title: child ??
        AppText(
          title,
          size: textSize,
          weight: textWeight,
          color: textColor,
        ),
    automaticallyImplyLeading: isLeading,
    leading: !isLeading
        ? null
        : IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              color: iconColor ?? context.color.tertiary,
              size: 30,
            ),
            onPressed: () => Navigator.maybePop(context),
          ),
    elevation: elevation ?? 1,
    actions: action,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(0.5),
      child: bottom,
    ),
  );
}

// Custom wrapper to make CupertinoNavigationBar compatible with PreferredSizeWidget
class _CupertinoNavBarWrapper extends PreferredSize {
  final CupertinoNavigationBar navigationBar;

  _CupertinoNavBarWrapper({
    required this.navigationBar,
    required double height,
  }) : super(
          preferredSize: Size.fromHeight(height),
          child: navigationBar,
        );

  @override
  Widget build(BuildContext context) => navigationBar;
}
