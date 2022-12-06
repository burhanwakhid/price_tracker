import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:price_api/src/models/base_model2.dart';

void main() {
  test('description', () {
    final s = SingleResponse<DataSingle>.fromJson(
      jsonResponse,
      (p0) => DataSingle.fromJson(p0),
    );

    if (kDebugMode) {
      print(s.data.haha);
    }
  });

  test('description2', () {
    final s = ListResponse<DataSingle>.fromJson(
      jsonResponse2,
      (p0) => DataSingle.fromJson(p0),
    );

    if (kDebugMode) {
      print(s.data.length);
    }
  });
}
