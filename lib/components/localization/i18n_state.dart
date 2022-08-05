import 'package:flutter/material.dart';
import 'package:new_bytebank/components/localization/i18nMessages.dart';

@immutable
class I18NMessagesState {
  const I18NMessagesState();
}

@immutable
class LoadingI18NMessagesState extends I18NMessagesState {
  const LoadingI18NMessagesState();
}

@immutable
class InicialI18NMessagesState extends I18NMessagesState {
  const InicialI18NMessagesState();
}

@immutable
class LoadedI18NMessagesState extends I18NMessagesState {
  final I18NMessages messages;

  const LoadedI18NMessagesState(this.messages);
}

@immutable
class FatalErrorState extends I18NMessagesState {
  const FatalErrorState();
}
