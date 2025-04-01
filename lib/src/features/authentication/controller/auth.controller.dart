import 'package:agent/src/features/authentication/repository/auth.repo.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  AuthRepo repo = AuthRepo();
}
