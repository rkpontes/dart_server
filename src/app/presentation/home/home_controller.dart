import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

class HomeController {
  FutureOr<Response> call(Request request) async {
    return Response.ok(
      jsonEncode({"message": "Server ON!"}),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );
  }
}
