//Metodo Lazy
import 'package:flutter/material.dart';
import 'package:new_bytebank/components/localization/eager.localization.dart';
import 'package:new_bytebank/components/localization/i18nMessages.dart';

class DashboardViewLazyI18N {
  final I18NMessages _messages;

  DashboardViewLazyI18N(this._messages);

  String? get transfer => _messages.get("Transfer");

  String? get transactioFeed => _messages.get("Transaction_feed");

  String? get changeName => _messages.get("Change_name");
}

//Metodo Eager
class DashboardViewI18N extends ViewI18N {
  DashboardViewI18N(BuildContext context) : super(context);

  String? get transfer => localize({"pt-br": "Transferir", "en": "Transfer"});

  String? get transactioFeed =>
      localize({"pt-br": "Transacoes", "en": "Transaction Feed"});

  String? get changeName =>
      localize({"pt-br": "Mudar nome", "en": "Change name"});
}
