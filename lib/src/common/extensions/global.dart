import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(),
);

extension GlobalExtension<T> on T {
  void iLog({String? message, StackTrace? stackTrace, Object? error}) =>
      logger.i('${message == null ? '' : '$message: '}$this',
          error: error, stackTrace: stackTrace);
  void eLog({String? message, StackTrace? stackTrace, Object? error}) =>
      logger.e('${message == null ? '' : '$message: '}$this',
          error: error, stackTrace: stackTrace);
}
