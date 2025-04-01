import 'dart:convert';

String prettyJson(Object? jsonObject) {
  const encoder = JsonEncoder.withIndent('     ');
  return encoder.convert(jsonObject);
}
