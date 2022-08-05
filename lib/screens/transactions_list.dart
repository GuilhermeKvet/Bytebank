import 'package:flutter/material.dart';
import 'package:new_bytebank/components/centered_message.dart';
import 'package:new_bytebank/http/web_clients/transaction_webclient.dart';

import '../components/progress/circularProgress.dart';
import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final TransactionWebclient _webclient = TransactionWebclient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _webclient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return CircularProgress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transaction> transactions =
                    snapshot.data as List<Transaction>;
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.monetization_on),
                          title: Text(
                            transaction.value.toString(),
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transaction.contact.name,
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }
              return CenteredMessage(
                'No transactions found',
                icon: Icons.warning,
              );
          }
          return CenteredMessage('Unknown error');
        },
      ),
    );
  }
}
