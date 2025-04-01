import 'package:agent/src/common/extensions/context.dart';
import 'package:agent/src/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

Future<void> showModal(BuildContext context,
        {required String title, required Widget child, Widget? actionButton}) =>
    WoltModalSheet.show<void>(
      pageIndexNotifier: ValueNotifier<int>(0),
      context: context,
      pageListBuilder: (modalSheetContext) {
        final textTheme = Theme.of(context).textTheme;
        return [
          page(modalSheetContext, textTheme, title, child, actionButton),
        ];
      },
      modalTypeBuilder: (context) => WoltModalType.bottomSheet(),
      onModalDismissedWithBarrierTap: () {
        Navigator.of(context).pop();
      },
      useSafeArea: true,
      enableDrag: true,
      showDragHandle: true,
    );

WoltModalSheetPage page(BuildContext modalSheetContext, TextTheme textTheme,
        String title, Widget child, Widget? actionButton) =>
    WoltModalSheetPage(
      hasSabGradient: false,
      stickyActionBar: Padding(
        padding: const EdgeInsets.all(10),
        child: actionButton,
      ),
      topBarTitle: AppText(
        title,
        size: 20,
        weight: 600,
      ),
      backgroundColor: modalSheetContext.color.surface,
      isTopBarLayerAlwaysVisible: true,
      trailingNavBarWidget: IconButton(
        padding: const EdgeInsets.all(10),
        icon: const Icon(Icons.close),
        onPressed: Navigator.of(modalSheetContext).pop,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20,
          bottom: 60,
          top: 10,
        ),
        child: child,
      ),
    );

Future<void> bottomAction(BuildContext context, Widget child,
        {double radius = 0, double padding = 1}) =>
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: context.color.surfaceContainer,
        context: context,
        elevation: 0,
        useSafeArea: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius)),
        ),
        builder: (context) => ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
            ),
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height - 200),
              padding: EdgeInsets.only(
                top: padding,
              ),
              child: child,
            )));
