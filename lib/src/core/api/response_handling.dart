import 'dart:convert';

import 'package:agent/src/common/extensions/context.dart';
import 'package:agent/src/common/extensions/global.dart';
import 'package:agent/src/common/utils/json.dart';
import 'package:agent/src/core/api/model/response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResponseHandler {
  ResponseModel handleResponse(
    http.Response response, {
    required DateTime startTime,
    Map<dynamic, dynamic>? requestBody,
    Map<String, String>? headers,
  }) {
    final dynamic decodedBody = jsonDecode(response.body);

    Map<String, dynamic> body;

    if (decodedBody is Map) {
      // Cast it properly to Map<String, dynamic>
      body = Map<String, dynamic>.from(decodedBody);
    } else if (decodedBody == null) {
      // If null, create an empty map
      body = {};

      // Or if you still want to try parsing response.body as a fallback:
      try {
        final dynamic fallbackDecode = jsonDecode(response.body);
        if (fallbackDecode is Map) {
          body = Map<String, dynamic>.from(fallbackDecode);
        }
      } catch (_) {
        // If parsing fails, create an empty map or handle as needed
        body = {'data': response.body};
      }
    } else {
      // Handle case where decodedBody is not a Map (might be a List or primitive)
      body = {'data': decodedBody};
    }

    final ResponseModel response0 = ResponseModel.fromJson(body).copyWith(
      statusCode: response.statusCode,
    );

    if (kDebugMode) {
      final requestDuration = DateTime.now().difference(startTime);

      'Duration: ${(requestDuration.inMilliseconds / 1500).toStringAsFixed(3)} s \n\nMethod: [${response.request?.method}] \n\nStatusCode: [${response0.statusCode}]\n\nURL: [${response.request!.url}]\n\nHeaders: ${jsonEncode(headers ?? {})}\n\nBODY: ${prettyJson(body).length > 1500 ? '${prettyJson(body).substring(0, 1500)}...' : prettyJson(body)}\n\nREQ BODY: ${prettyJson(requestBody).length > 1500 ? '${prettyJson(requestBody).substring(0, 1500)}...' : prettyJson(requestBody)}'
          .iLog();
    }

    if (body.containsKey('access_token') && response0.data == null) {
      response0.data = {
        'access_token': body['access_token'],
      };
    }

    return response0;
  }
}

void handleErrors(BuildContext context, Object? e, StackTrace stack) {
  if (kDebugMode) {
    ' ${e?.runtimeType}'.eLog(
        message: 'Error caught in handleErrors', error: e, stackTrace: stack);
  }

  // Report the error to Firebase Crashlytics
  // FirebaseCrashlytics.instance.recordError(
  //   e,
  //   stack,
  //   reason: 'Error caught in handleErrors',
  // );

  if (e is String) {
    context.alert(e);
  } else if (e is ResponseModel) {
    context.alert('${e.message}');
  }
  // else if (e is FirebaseAuthException) {
  //   context.alert(handleException(e.code, e.message));
  // } else if (e is SignInWithAppleAuthorizationException) {
  //   context.alert(handleAppleSignInException(e.code, e.message));
  // }
  else {
    final String error =
        handleException(e, 'Error occurred, please try again.');
    context.alert(error);
  }
}

// String handleAppleSignInException(AuthorizationErrorCode code,
//     [String? message]) {
//   switch (code) {
//     case AuthorizationErrorCode.canceled:
//       return 'Sign in was canceled by the user.';
//     case AuthorizationErrorCode.failed:
//       return 'Authentication failed, please try again.';
//     case AuthorizationErrorCode.invalidResponse:
//       return 'Invalid response received from Apple.';
//     case AuthorizationErrorCode.notHandled:
//       return 'The authorization request wasn't handled.';
//     case AuthorizationErrorCode.notInteractive:
//       return 'The authorization request requires user interaction.';
//     case AuthorizationErrorCode.unknown:
//       return 'An unknown error occurred with Apple sign in.';
//     default:
//       return message ?? 'Apple sign in error occurred, please try again.';
//   }
// }

String handleException(Object? e, [String? message]) {
  // Normalize the error input to a string for easier comparison
  final String errorCode = e.toString().toLowerCase();

  switch (errorCode) {
    // General Firebase Authentication Error Codes
    case 'invalid-email':
    case 'auth/invalid-email':
    case 'error_invalid_email':
      return 'Invalid email address.';

    case 'wrong-password':
    case 'auth/wrong-password':
    case 'error_wrong_password':
      return 'Incorrect password.';

    case 'user-not-found':
    case 'auth/user-not-found':
    case 'error_user_not_found':
      return "User with this email doesn't exist.";

    case 'user-disabled':
    case 'auth/user-disabled':
    case 'error_user_disabled':
      return 'User with this email has been disabled.';

    case 'too-many-requests':
    case 'auth/too-many-requests':
    case 'error_too_many_requests':
      return 'Too many requests. Try again later.';

    case 'operation-not-allowed':
    case 'auth/operation-not-allowed':
    case 'error_operation_not_allowed':
      return 'Unauthorized.';

    case 'email-already-in-use':
    case 'auth/email-already-in-use':
    case 'error_email_already_in_use':
      return 'The email address is already in use by another account.';

    case 'invalid-credential':
    case 'auth/invalid-credential':
    case 'invalid_login_credentials':
      return 'Incorrect email or password.';

    case 'weak-password':
    case 'auth/weak-password':
      return 'The password must be at least 8 characters.';

    case 'requires-recent-login':
    case 'auth/requires-recent-login':
    case 'firebase_auth/requires-recent-login':
      return 'Please login again.';

    case 'account-exists-with-different-credential':
    case 'auth/account-exists-with-different-credential':
      return 'An account already exists with a different credential.';

    case 'credential-already-in-use':
    case 'auth/credential-already-in-use':
      return 'This credential is already associated with another account.';

    case 'invalid-action-code':
    case 'auth/invalid-action-code':
      return 'The action code is invalid or expired.';

    case 'expired-action-code':
    case 'auth/expired-action-code':
      return 'The action code has expired.';

    case 'user-token-expired':
    case 'auth/user-token-expired':
      return 'Your session has expired. Please log in again.';

    case 'network-request-failed':
    case 'auth/network-request-failed':
      return 'Network error. Please check your connection.';

    case 'invalid-verification-code':
    case 'auth/invalid-verification-code':
      return 'The verification code is invalid.';

    case 'invalid-verification-id':
    case 'auth/invalid-verification-id':
      return 'The verification ID is invalid.';

    case 'missing-verification-code':
    case 'auth/missing-verification-code':
      return 'Verification code is missing.';

    case 'missing-verification-id':
    case 'auth/missing-verification-id':
      return 'Verification ID is missing.';

    case 'quota-exceeded':
    case 'auth/quota-exceeded':
      return 'Quota exceeded. Try again later.';

    case 'provider-already-linked':
    case 'auth/provider-already-linked':
      return 'This provider is already linked to your account.';

    case 'no-such-provider':
    case 'auth/no-such-provider':
      return 'No such provider exists for this account.';

    // Google-Specific Error Codes
    case 'auth/invalid-google-credential':
      return 'Invalid Google credential provided.';

    case 'auth/google-sign-in-failed':
      return 'Google sign-in failed. Please try again.';

    // Google-specific errors
    case 'auth/google-internal-error':
    case 'google-internal-error':
      return 'An internal error occurred with Google authentication.';

    case 'auth/google-play-services-not-available':
    case 'google-play-services-not-available':
      return 'Google Play services are not available on this device.';

    case 'auth/cancelled-popup-request':
    case 'cancelled-popup-request':
      return 'The authentication request was cancelled.';

    case 'auth/user-cancelled':
    case 'user-cancelled':
      return 'The authentication was cancelled by the user.';

    // Facebook-Specific Error Codes
    case 'auth/invalid-facebook-credential':
      return 'Invalid Facebook credential provided.';

    case 'auth/facebook-login-cancelled':
      return 'Facebook login was cancelled.';

    case 'auth/facebook-token-error':
      return 'Facebook token error. Please try again.';

    // Apple-Specific Error Codes
    case 'auth/invalid-apple-credential':
      return 'Invalid Apple credential provided.';

    case 'auth/missing-or-invalid-nonce':
      return 'Missing or invalid nonce for Apple Sign-In.';

    case 'auth/authorization-revoked':
      return 'Apple authorization has been revoked.';

    case 'auth/apple-sign-in-failed':
      return 'Apple Sign-In failed. Please try again.';

    // Additional Common Firebase Errors
    case 'auth/app-deleted':
      return 'This app has been deleted.';

    case 'auth/app-not-authorized':
      return 'This app is not authorized to use Firebase.';

    case 'auth/argument-error':
      return 'Invalid arguments provided.';

    case 'auth/captcha-check-failed':
      return 'reCAPTCHA verification failed.';

    case 'auth/code-expired':
      return 'The provided code has expired.';

    case 'auth/cors-unsupported':
      return 'CORS is not supported by your browser.';

    case 'auth/custom-token-mismatch':
      return 'The custom token and API key do not match.';

    case 'auth/email-change-needs-verification':
      return 'Please verify your new email address.';

    case 'auth/emulator-config-failed':
      return 'Emulator configuration failed.';

    case 'auth/internal-error':
      return 'An internal error occurred.';

    case 'auth/invalid-api-key':
      return 'The API key is invalid.';

    case 'auth/invalid-user-token':
      return 'The user token is invalid.';

    case 'auth/popup-blocked':
      return 'Popup was blocked by the browser.';

    case 'auth/popup-closed-by-user':
      return 'Popup was closed by the user.';

    case 'auth/unauthorized-domain':
      return 'This domain is not authorized.';

    case 'auth/unsupported-persistence-type':
      return 'Unsupported persistence type.';

    case 'auth/web-storage-unsupported':
      return 'Web storage is not supported by your browser.';

    // Firestore Permission Denied (if relevant)
    case 'cloud_firestore/permission-denied':
      return 'Permission denied.';

    default:
      if (e is String && e.startsWith('auth/')) {
        return 'Authentication error: ${e.substring(5).replaceAll('-', ' ')}.';
      } else if (e is String && e.startsWith('cloud_firestore/')) {
        return 'Database error: ${e.substring(16).replaceAll('-', ' ')}.';
      }
      return message ?? 'Connection error, please try again...';
  }
}
