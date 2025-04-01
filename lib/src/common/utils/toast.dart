import 'package:agent/src/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

dynamic showToast(BuildContext context, String message, [bool error = true]) =>
    GFToast.showToast(
      message,
      context,
      toastPosition: GFToastPosition.TOP,
      textStyle: const TextStyle(
        fontSize: 13,
        color: GFColors.LIGHT,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor:
          error ? const Color.fromARGB(255, 205, 78, 78) : GFColors.DARK,
      toastDuration: 6,
      toastBorderRadius: 7.0,
      trailing: InkWell(
        onTap: () => ToastView.dismiss(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppText(
            'Close',
            size: 14,
            color: error ? Colors.white : GFColors.SUCCESS,
            weight: 600,
          ),
        ),
      ),
    );
