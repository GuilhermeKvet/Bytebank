import 'package:flutter/cupertino.dart';
import 'package:new_bytebank/dao/contact_dao.dart';
import 'package:new_bytebank/http/web_clients/transaction_webclient.dart';

class AppDependecies extends InheritedWidget {
  final ContactDao contactDao;
  final TransactionWebclient transactionWebclient;

  AppDependecies({
    required this.contactDao,
    required Widget child,
    required this.transactionWebclient,
  }) : super(child: child);

  static AppDependecies? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppDependecies>();
  }

  @override
  bool updateShouldNotify(covariant AppDependecies oldWidget) {
    return contactDao != oldWidget.contactDao ||
        transactionWebclient != oldWidget.transactionWebclient;
  }
}
