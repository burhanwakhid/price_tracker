class BaseResponse {
  final dynamic message;
  final bool success;

  BaseResponse({
    required this.message,
    required this.success,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(success: json["success"], message: json["message"]);
  }
}

/// @JsonSerializable(genericArgumentFactories: true)
class ListResponse<T> extends BaseResponse {
  final List<T> data;

  ListResponse({
    required String message,
    required bool success,
    required this.data,
  }) : super(message: message, success: success);

  /// server response for list
  ///
  ///```dart
  /// {
  ///   "data": []
  ///   "message": 'asdf',
  ///   "success": true,
  /// }
  /// ```
  ///
  ///```dart
  ///  final s = ListResponse<YourModel>.fromJson(
  ///       jsonResponse2,
  ///       (p0) => YourModel.fromJson(p0),
  ///     );
  ///
  ///  print(s.data.length);
  /// ```
  ///
  ///
  factory ListResponse.fromJson(
    Map<String, dynamic> json,
    Function(Map<String, dynamic>) create,
  ) {
    var data = <T>[];
    json['data'].forEach((v) {
      data.add(create(v));
    });

    return ListResponse<T>(
        success: json["success"], message: json["message"], data: data);
  }
}

// server response for single object
// {
//   "data": {}
//   "message": null,
//   "success": true,
// }
// @JsonSerializable(genericArgumentFactories: true)
class SingleResponse<T> extends BaseResponse {
  final T data;

  SingleResponse({
    required String message,
    required bool success,
    required this.data,
  }) : super(message: message, success: success);

  /// server response for single object
  ///
  /// ```dart
  /// {
  ///   "data": {}
  ///   "message": 'sdf',
  ///   "success": true,
  /// }
  /// ```
  ///
  ///```dart
  /// final s = SingleResponse<YourModel>.fromJson(
  ///   jsonResponse,
  ///   (p0) => YourModel.fromJson(p0),
  /// );
  ///
  /// print(s.data.haha);
  /// ```
  factory SingleResponse.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return SingleResponse<T>(
        success: json["success"],
        message: json["message"],
        data: create(json["data"]));
  }
}

final jsonResponse = <String, dynamic>{
  "data": {'haha': 'gaga', 'dfs': 'fsddsa'},
  "message": 'sss',
  "success": true
};
final jsonResponse2 = <String, dynamic>{
  "data": [
    {'haha': 'gaga', 'dfs': 'fsddsa'},
    {'haha': 'gaga2', 'dfs': 'fsddsa2'}
  ],
  "message": 'sss',
  "success": true
};

class DataSingle {
  DataSingle({
    required this.haha,
    required this.dfs,
  });

  final String haha;
  final String dfs;

  factory DataSingle.fromJson(Map<String, dynamic> json) => DataSingle(
        haha: json["haha"],
        dfs: json["dfs"],
      );

  Map<String, dynamic> toJson() => {
        "haha": haha,
        "dfs": dfs,
      };
}

class Tests {
  final s = SingleResponse<DataSingle>.fromJson(
    jsonResponse,
    (p0) => DataSingle.fromJson(p0),
  );
}
