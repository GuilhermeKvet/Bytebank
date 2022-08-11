import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_bytebank/components/localization/i18nMessages.dart';
import 'package:new_bytebank/components/localization/i18n_cubit.dart';
import 'package:new_bytebank/components/localization/locale.dart';
import 'package:new_bytebank/models/name.dart';
import 'package:new_bytebank/screens/dashboard/dashboard_view.dart';
import 'package:new_bytebank/screens/dashboard/dashbord_future_item.dart';

void main() {
  testWidgets('Should display the main image when the Dashboard is opended',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<CurrentLocaleCubit>(
              create: (BuildContext contextCL) => CurrentLocaleCubit(),
            ),
            BlocProvider<NameCubit>(
              create: (BuildContext contextNC) => NameCubit('Guilherme'),
            ),
            BlocProvider<I18NMessagesCubit>(
              create: (BuildContext contextI18N) =>
                  I18NMessagesCubit("dashboard"),
            ),
          ],
          child: DashboardView(
            I18NMessages(
              {
                "Transfer": "Transfer",
                "Transaction_feed": "Transaction Feed",
                "Change_name": "Change Name"
              },
            ),
          ),
        ),
      ),
    );
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });
  testWidgets('Should display the first feature when the Dashboard is opened',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<CurrentLocaleCubit>(
              create: (BuildContext contextCL) => CurrentLocaleCubit(),
            ),
            BlocProvider<NameCubit>(
              create: (BuildContext contextNC) => NameCubit('Guilherme'),
            ),
            BlocProvider<I18NMessagesCubit>(
              create: (BuildContext contextI18N) =>
                  I18NMessagesCubit("dashboard"),
            ),
          ],
          child: DashboardView(
            I18NMessages(
              {
                "Transfer": "Transfer",
                "Transaction_feed": "Transaction Feed",
                "Change_name": "Change Name"
              },
            ),
          ),
        ),
      ),
    );
    final firstFeature = find.byType(FeatureItem);
    expect(firstFeature, findsWidgets);
  });
}