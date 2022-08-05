import 'dart:async';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bytebank/components/container.dart';
import 'package:new_bytebank/components/progress/progress_view.dart';
import 'package:new_bytebank/components/response_dialog.dart';
import 'package:new_bytebank/components/transaction_auth_dialog.dart';
import 'package:uuid/uuid.dart';
import '../components/error.dart';
import '../http/web_clients/transaction_webclient.dart';
import '../models/Contact.dart';
import '../models/transaction.dart';

@immutable
abstract class TransactionFormState {
  const TransactionFormState();
}

@immutable
class ShowFormState extends TransactionFormState {
  const ShowFormState();
}

@immutable
class SendingState extends TransactionFormState {
  const SendingState();
}

@immutable
class SentState extends TransactionFormState {
  const SentState();
}

@immutable
class FatalErrorState extends TransactionFormState {
  final String? _message;

  const FatalErrorState(this._message);
}

class TransactionFormCubit extends Cubit<TransactionFormState> {
  TransactionFormCubit() : super(const ShowFormState());
  final TransactionWebclient _webclient = TransactionWebclient();

  void save(Transaction transactionCreated, String password,
      BuildContext context) async {
    emit(const SendingState());
    try {
      await _webclient.save(transactionCreated, password);
      emit(const SentState());
    } on HttpException catch (error) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance.setCustomKey('exeption', error.toString());
        FirebaseCrashlytics.instance
            .setCustomKey('hhtp_code', error.statusCode!);
        FirebaseCrashlytics.instance
            .setCustomKey('http_body', transactionCreated.toString());
        FirebaseCrashlytics.instance.recordError(error, null);
      }
      emit(FatalErrorState(error.message));
    } on TimeoutException catch (error) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance.setCustomKey('exeption', error.toString());
        FirebaseCrashlytics.instance
            .setCustomKey('http_body', transactionCreated.toString());
        FirebaseCrashlytics.instance.recordError(error, null);
      }
      emit(const FatalErrorState('timeout submitting the transaction'));
    } on SocketException catch (error) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance.setCustomKey('exeption', error.toString());
        FirebaseCrashlytics.instance
            .setCustomKey('http_body', transactionCreated.toString());
        FirebaseCrashlytics.instance.recordError(error, null);
      }
      emit(const FatalErrorState(
          'there was a problem accessing your transfers'));
    } catch (error) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance.setCustomKey('exeption', error.toString());
        FirebaseCrashlytics.instance
            .setCustomKey('http_body', transactionCreated.toString());
        FirebaseCrashlytics.instance.recordError(error.toString(), null);
      }
      emit(FatalErrorState(error.toString()));
    }
  }
}

class TransactionFormContainer extends BlocContainer {
  final Contact _contact;

  TransactionFormContainer(this._contact);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormCubit>(
      create: (BuildContext context) {
        return TransactionFormCubit();
      },
      child: BlocListener<TransactionFormCubit, TransactionFormState>(
        listener: (BuildContext context, state) {
          if (state is SentState) {
            Navigator.pop(context);
          }
        },
        child: TransactionForm(_contact),
      ),
    );
  }
}

class TransactionForm extends StatelessWidget {
  final String transactionId = const Uuid().v4();

  final Contact _contact;

  TransactionForm(this._contact);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
        builder: (context, state) {
      if (state is ShowFormState) {
        return BasicForm(_contact);
      }
      if (state is SendingState || state is SentState) {
        return ProgressView();
      }
      if (state is FatalErrorState) {
        return ErrorView(state._message);
      }
      return ErrorView("Unknown error");
    });
  }
}

class BasicForm extends StatelessWidget {
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = const Uuid().v4();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final Contact _contact;

  BasicForm(this._contact);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: const Text('Transfer'),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController.text);
                      try {
                        final transactionCreated =
                            Transaction(transactionId, value!, _contact);
                        showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (String password) {
                                BlocProvider.of<TransactionFormCubit>(context)
                                    .save(
                                        transactionCreated, password, context);
                              },
                            );
                          },
                        );
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return FailureDialog('Requires a minimum transfer');
                          },
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
