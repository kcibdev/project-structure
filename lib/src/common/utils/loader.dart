import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AppLoader extends HookWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            color: Colors.black,
          ),
          width: 70,
          height: 70,
          padding: const EdgeInsets.all(13),
        ),
      );
}

void showLoader(BuildContext context) =>
    context.loaderOverlay.show(widgetBuilder: (_) => const AppLoader());
void hideLoader(BuildContext context) => context.loaderOverlay.hide();
