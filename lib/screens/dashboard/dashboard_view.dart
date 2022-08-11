import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bytebank/components/container.dart';
import 'package:new_bytebank/components/localization/i18nMessages.dart';
import 'package:new_bytebank/models/name.dart';
import 'package:new_bytebank/screens/contacts_list.dart';
import 'package:new_bytebank/screens/dashboard/dashboard_i18n.dart';
import 'package:new_bytebank/screens/dashboard/dashbord_future_item.dart';
import 'package:new_bytebank/screens/name.dart';
import 'package:new_bytebank/screens/transactions_list.dart';

import '../../models/name.dart';

class DashboardView extends StatelessWidget {
  final I18NMessages _messages;

  DashboardView(this._messages);

  @override
  Widget build(BuildContext context) {
    //Metodo Eager
    // final i18n = DashboardViewI18N(context);

    //Metodo Lazy
    final i18n = DashboardViewLazyI18N(_messages);
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text('Welcome $state'),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset('images/bytebank_logo.png'),
                ),

                //Container adicionado para poder encapsular o listView que permite
                //acrescentar mais features quando precisar, assim podemos ter acesso
                // a rolagem de tela.
                Container(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      FeatureItem(
                        name: i18n.transfer!,
                        icon: Icons.monetization_on,
                        onClick: () => _showContactsPage(context),
                      ),
                      FeatureItem(
                        name: i18n.transactioFeed!,
                        icon: Icons.description,
                        onClick: () => _showTransectionsPage(context),
                      ),
                      FeatureItem(
                        name: i18n.changeName!,
                        icon: Icons.person_outline,
                        onClick: () => _showChangeName(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showChangeName(BuildContext blocContext) {
  Navigator.push(
    blocContext,
    MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: BlocProvider.of<NameCubit>(blocContext),
        child: NameContext(),
      ),
    ),
  );
}

void _showContactsPage(BuildContext blocContext) {
  push(blocContext, ContactsListContainer());
}

_showTransectionsPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TransactionsList(),
    ),
  );
}
