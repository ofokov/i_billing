import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/bloc/ibilling_bloc/ibilling_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/bloc/interner_bloc/internet_bloc.dart';

import '../../../../injection_container.dart';
import '../constants/style/ibilling_theme.dart';
import 'ibilling_home_page.dart';

class IBillingApp extends StatefulWidget {
  const IBillingApp({super.key, required this.title});

  final String title;

  @override
  State<IBillingApp> createState() => _IBillingAppState();
}

class _IBillingAppState extends State<IBillingApp> {
  late IbillingBloc ibillingBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = IBillingTheme.theme();
    return MultiBlocProvider(
      providers: [
        BlocProvider<IbillingBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<InternetBloc>(
          create: (context) => sl(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'iBilling',
        theme: theme,
        home: const IBillingHomePage(title: 'iBilling home page'),
      ),
    );
  }
}
