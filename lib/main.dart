import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:async/async.dart';

import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?key=b8ff9e23";

void main() async {
  http.Response response = await http.get(Uri.parse(request));
  print(json.decode(response.body)["results"]["currencies"]["USD"]);

  runApp(MaterialApp(home: Container()));
}
