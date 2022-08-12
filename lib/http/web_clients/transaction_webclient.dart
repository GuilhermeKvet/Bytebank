import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';
import 'package:new_bytebank/http/webcliente.dart';
import 'package:new_bytebank/models/transaction.dart';

class TransactionWebclient {
  // A funcao FindAll, esta acessando os dados da api e armazenando em uma lista.
  //para poder reproduzir em Cards, na tela de transactions.
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(Uri.http('192.168.0.165:8080', 'transactions'));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  // A funcao save, serve para salvar uma nova transaction na api.
  Future<Transaction> save(Transaction transaction, String password) async {
    //Precisamos criar um map(objeto) com a estrutura da api, e transformar
    //em string com o jsonEncode.
    final String transectionJson = jsonEncode(transaction.toJson());

    // await Future.delayed(const Duration(seconds: 2));

    //com o metodo do post, enviamos o map para a api.
    final Response response = await client.post(
      Uri.parse('http://192.168.0.165:8080/transactions'),
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: transectionJson,
    );
    if (response.statusCode != 200) {
      throw HttpException(
          _getMessage(response.statusCode), response.statusCode);
    }
    return Transaction.fromJson(jsonDecode(response.body));
  }

  String? _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return 'Unknown error';
  }

  static final Map<int, String> _statusCodeResponses = {
    401: 'authentication failed',
    409: 'transaction always exists',
  };

  // List<Transaction> _toTransactions(Response response) {
  // final List<Transaction> transactions = [];
  // for (Map<String, dynamic> transactionJson in decodedJson) {
  //Forma mais performatica de convercao para JSON.
  // transactions.add(Transaction.fromJson(transactionJson));

  //Forma manual de convercao para JSON.
  // final Map<String, dynamic> contactJson = transactionJson["contact"];
  // final Transaction transaction = Transaction(
  //   transactionJson["value"],
  //   Contact(
  //     0,
  //     contactJson['name'],
  //     contactJson['accountNumber'],
  //   ),
  // );
  // transactions.add(transaction);
  // }
  // return transactions;
}

class HttpException implements Exception {
  final String? message;
  final int? statusCode;

  HttpException(this.message, this.statusCode);
}
