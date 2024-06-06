import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/bloc/ibilling_bloc/ibilling_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/screens/create_contract_page.dart';
import 'package:i_billing/features/ibilling/presentation/screens/filter_page.dart';
import 'package:i_billing/features/ibilling/presentation/screens/history_page.dart';
import 'package:i_billing/features/ibilling/presentation/screens/profile_page.dart';
import 'package:i_billing/features/ibilling/presentation/screens/save_page.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/custom_bottom_navigation_items.dart';
import 'package:i_billing/generated/locale_keys.g.dart';

import '../widgets/custom_logo.dart';
import '../widgets/style/ibilling_icons.dart';
import 'contracts_page.dart';
import 'searching_page.dart';

class IBillingHomePage extends StatefulWidget {
  final String title;
  const IBillingHomePage({super.key, required this.title});

  @override
  State<IBillingHomePage> createState() => _IBillingHomePageState();
}

class _IBillingHomePageState extends State<IBillingHomePage> {
  final List<Widget> pages = const [
    ContractsPage(),
    HistoryPage(),
    CreateContractPage(),
    SavePage(),
    ProfilePage(),
    FilterPage()
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        appBar: _buildAppBar(context),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: selectedIndex,
          onTap: (index) => index == 2
              ? _showDialogOfCreate()
              : setState(() => selectedIndex = index),
        ),
        body: pages[selectedIndex],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 44,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      leading: const Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: CustomLogo(),
      ),
      title: Text(
        _getPageTitle(),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: selectedIndex == 4 ? null : _buildAppBarActions(context),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () async {
          bool? filtersApplied = await Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (context, _, __) => const FilterPage(),
            ),
          );
          if (filtersApplied == true) {
            setState(() => selectedIndex = 0);
          }
        },
        icon: Image.asset(
          IBillingIcons.filtre,
          width: 20,
          height: 20,
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: VerticalDivider(
          width: 18,
          color: Colors.white,
        ),
      ),
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (context, _, __) => SearchingPage(),
            ),
          ).then((_) => BlocProvider.of<IbillingBloc>(context)
              .add(const GetListOfContracts()));
        },
        icon: Image.asset(
          IBillingIcons.zoom,
          width: 20,
          height: 20,
        ),
      ),
    ];
  }

  String _getPageTitle() {
    switch (selectedIndex) {
      case 0:
        return LocaleKeys.contracts.tr();
      case 1:
        return LocaleKeys.history.tr();
      case 2:
        return LocaleKeys.neww.tr();
      case 3:
        return LocaleKeys.save.tr();
      case 4:
        return LocaleKeys.profile.tr();
      default:
        return 'iBilling';
    }
  }

  Future<void> _showDialogOfCreate() async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).primaryColor,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Column(
                  children: [
                    Text(LocaleKeys.what_do_you_want_to_create.tr()),
                    const SizedBox(height: 24),
                    Column(
                      children: [
                        _buildCreateButton(context, IBillingIcons.paper,
                            LocaleKeys.contract.tr(), 2),
                        _buildCreateButton(context, IBillingIcons.vaucher,
                            LocaleKeys.invoice.tr(), null),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  FilledButton _buildCreateButton(
      BuildContext context, String icon, String text, int? index) {
    return FilledButton(
      onPressed: () {
        if (index != null) setState(() => selectedIndex = index);
        Navigator.pop(context);
      },
      style: FilledButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        backgroundColor: const Color(0xff4E4E4E),
      ),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
