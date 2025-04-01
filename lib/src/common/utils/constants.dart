import 'package:agent/src/config/endpoints.dart';

class Constants {
  // Base URL example
  static const String baseUrl = 'https://api.github.com';

  // Group: Image paths
  static const image = _ImageConfig();
  static const icon = _IconConfig();
  static const endpoint = Endpoints();
}

// Image configuration group
class _ImageConfig {
  const _ImageConfig();

  String get logo => 'assets/images/logo.png';
  String get backgroundLines => 'assets/images/home_bg.svg';
  String get dummy =>
      'https://placehold.co/100/000000/FFFFFF/png?text=UtilityTorch';
}

class _IconConfig {
  const _IconConfig();

  String get mtn => 'assets/icons/mtn.svg';
  String get glo => 'assets/icons/glo.svg';
  String get mastercard => 'assets/icons/mastercard.svg';
  String get paypal => 'assets/icons/paypal.svg';
  String get visa => 'assets/icons/visa.svg';
  String get vfd => 'assets/icons/vfd.svg';
  String get flutterwave => 'assets/icons/flutterwave.svg';
}
