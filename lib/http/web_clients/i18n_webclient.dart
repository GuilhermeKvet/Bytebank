import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';
import 'package:new_bytebank/http/webcliente.dart';
import 'package:new_bytebank/models/transaction.dart';

const String MESSAGES_URI =
    "https://gist.githubusercontent.com/GuilhermeKvet/cd64a58fa3d4b94a5991fa6436cf7b59/raw/6a471aaa5be5c0866f510a656303377aeddd707d/";

class I18NWebClient {
  final String _viewKey;

  I18NWebClient(this._viewKey);

  Future<Map<String, dynamic>> findAll() async {
    final Response response =
        await client.get(Uri.parse("$MESSAGES_URI/$_viewKey.json"));
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson;
  }
}
