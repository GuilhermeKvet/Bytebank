import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bytebank/components/error.dart';
import 'package:new_bytebank/components/localization/i18nMessages.dart';
import 'package:new_bytebank/components/localization/i18n_cubit.dart';
import 'package:new_bytebank/components/localization/i18n_state.dart';
import 'package:new_bytebank/components/progress/progress_view.dart';

typedef Widget I18NWidgetCreator(I18NMessages messages);

class I18NLoadingView extends StatelessWidget {
  final I18NWidgetCreator _creator;

  I18NLoadingView(this._creator);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(
        builder: (context, state) {
      if (state is InicialI18NMessagesState ||
          state is LoadingI18NMessagesState) {
        return ProgressView();
      }
      if (state is LoadedI18NMessagesState) {
        final messages = state.messages;
        return _creator.call(messages);
      }
      return ErrorView("Erro ao tentar localizar idioma");
    });
  }
}
