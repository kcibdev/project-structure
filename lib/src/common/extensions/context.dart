import 'package:agent/src/common/utils/loader.dart';
import 'package:agent/src/common/utils/toast.dart';
import 'package:agent/src/config/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ContextExp on BuildContext {
  // Theme
  ColorScheme get color => cl(this);

  // Sizes
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

// Navigation
  Object? navigate(String name, {dynamic params}) =>
      GoRouter.of(this).pushNamed(name, extra: params);

  void back() => GoRouter.of(this).pop();
  void replaceRoute(String name, {Map<String, dynamic>? params}) =>
      GoRouter.of(this).go(name, extra: params);

  // Toast
  void alert(String message, [bool error = true]) =>
      showToast(this, message, error);
  void get loader => showLoader(this);

  void get dismissLoader => hideLoader(this);

  // Remove Keyboard Focus
  void get unfocus => FocusScope.of(this).unfocus();

  // Providers
  // CustomerController get customerController =>
  //     Provider.of<CustomerController>(this, listen: false);
}
