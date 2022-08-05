import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bytebank/components/container.dart';
import 'package:new_bytebank/components/localization/i18n_container.dart';
import 'package:new_bytebank/models/name.dart';
import 'package:new_bytebank/screens/dashboard/dashboard_view.dart';

class DashboardContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit("Guilherme"),
      child: I18NLoadingContainer(
        viewKey: "dashbord",
        creator: (messages) => DashboardView(messages),
      ),
    );
  }
}
