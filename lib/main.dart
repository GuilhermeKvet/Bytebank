import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_bytebank/components/theme.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:new_bytebank/dao/contact_dao.dart';
import 'package:new_bytebank/http/web_clients/transaction_webclient.dart';
import 'package:new_bytebank/screens/dashboard/dashboard_container.dart';
import 'package:new_bytebank/widget/app_dependecies.dart';

import 'components/localization/locale.dart';

void main() async {
  //runZonedGuarded, mostra erros do proprio flutter.
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    //IF para habilitar/desabilitar mode debug do ChashLytics,
    //para nao reportar erros durante a fase de desenvolvimento
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      //Armazenando informacao do usuario na msg de erro. id, cpf, etc...
      FirebaseCrashlytics.instance.setUserIdentifier('Guilherme Kvet');
      // Pass all uncaught errors from the framework to Crashlytics.
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    }
    runApp(Bytebank(
      contactDao: ContactDao(),
      transactionWebclient: TransactionWebclient(),
    ));
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

@override
class Bytebank extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebclient transactionWebclient;

  Bytebank({required this.contactDao, required this.transactionWebclient});

  Widget build(BuildContext context) {
    return AppDependecies(
      contactDao: contactDao,
      transactionWebclient: transactionWebclient,
      child: MaterialApp(
        theme: byteBankTheme,
        home: LocalizationContainer(
          child: DashboardContainer(),
        ),
      ),
    );
  }
}
