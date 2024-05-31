import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/bloc/ibilling_bloc/ibilling_bloc.dart';

import '../../../../injection_container.dart';
import '../widgets/style/ibilling_theme.dart';
import 'ibilling_home_page.dart';

class IBillingApp extends StatelessWidget {
  const IBillingApp({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = IBillingTheme.theme();
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'iBilling',
      theme: theme,
      home: BlocProvider<IbillingBloc>(
        create: (_) => sl(),
        child: const IBillingHomePage(title: 'iBilling home page'),
      ),
    );
  }
}
