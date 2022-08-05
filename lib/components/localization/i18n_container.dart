import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bytebank/components/container.dart';
import 'package:new_bytebank/components/localization/i18n_cubit.dart';
import 'package:new_bytebank/components/localization/i18n_loadingview.dart';

import '../../http/web_clients/i18n_webclient.dart';

class I18NLoadingContainer extends BlocContainer {
  final I18NWidgetCreator creator;
  final String viewKey;

  I18NLoadingContainer({
    required this.creator,
    required this.viewKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<I18NMessagesCubit>(
      create: (BuildContext) {
        final cubit = I18NMessagesCubit(viewKey);
        cubit.reload(I18NWebClient(viewKey));
        return cubit;
      },
      child: I18NLoadingView(creator),
    );
  }
}
