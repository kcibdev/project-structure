class ResponseModel {
  ResponseModel({
    this.status,
    this.message,
    this.statusCode,
    this.data,
  });

  bool? status;
  String? message;
  int? statusCode;
  dynamic data;

  ResponseModel copyWith({
    bool? status,
    String? message,
    int? statusCode,
    dynamic data,
  }) =>
      ResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        statusCode: statusCode ?? this.statusCode,
        data: data ?? this.data,
      );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        status: _parseStatus(json),
        message: json['message'].toString(),
        statusCode: json['statusCode'] as int?,
        data: json['data'],
      );

  static bool _parseStatus(Map<String, dynamic> json) {
    if (json['success'] is String && json['success'] == 'success') {
      return true;
    } else {
      if (json['status'] is bool) {
        return json['status'] as bool;
      } else if (json['status'] == 'success') {
        return true;
      }
    }
    return false;
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'statusCode': statusCode,
        'data': data,
      };
}
