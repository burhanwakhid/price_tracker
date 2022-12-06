///  [ApiResponse] apiResponse = [ApiResponse]<MyModel>();
///  var json = apiResponse.toJson();
///  var response =
///  [ApiResponse]<MyModel>.fromJson(json, (data) => MyModel.fromJson(data));
///
class ApiResponse<T extends Serializable> {
  bool? status;
  String? message;
  T? data;
  ApiResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    Function(Map<String, dynamic>) create,
  ) {
    return ApiResponse<T>(
      status: json["status"],
      message: json["message"],
      data: create(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}

class MyModel implements Serializable {
  String id;
  String title;
  MyModel({
    required this.id,
    required this.title,
  });

  factory MyModel.fromJson(Map<String, dynamic> json) {
    return MyModel(
      id: json["id"],
      title: json["title"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

// class Test {
//   test() {
//     ApiResponse apiResponse = ApiResponse<MyModel>();
//     var json = apiResponse.toJson();
//     var response =
//         ApiResponse<MyModel>.fromJson(json, (data) => MyModel.fromJson(data));
//   }
// }
