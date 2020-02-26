import 'package:flutter/foundation.dart';

class DIOResponseBody {
  final bool success;
  final dynamic data;
  DIOResponseBody({this.data, @required this.success});
}
