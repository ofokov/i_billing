import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_billing/features/ibilling/presentation/screens/create_contract_page.dart';
import 'package:i_billing/features/ibilling/presentation/screens/history_page.dart';
import 'package:i_billing/features/ibilling/presentation/screens/profile_page.dart';
import 'package:i_billing/features/ibilling/presentation/screens/save_page.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/custom_bottom_navigation_items.dart';
import 'package:i_billing/generated/locale_keys.g.dart';

import '../widgets/custom_logo.dart';
import '../widgets/style/ibilling_icons.dart';
import 'contracts_page.dart';

class IBillingHomePage extends StatefulWidget {
  final String title;
  const IBillingHomePage({super.key, required this.title});

  @override
  State<IBillingHomePage> createState() => _IBillingHomePageState();
}

class _IBillingHomePageState extends State<IBillingHomePage> {
  List<Widget> pages = [
    const ContractsPage(),
    const HistoryPage(),
    const CreateContractPage(),
    const SavePage(),
    const ProfilePage(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      appBar: AppBar(
        leadingWidth: 44,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: SizedBox(child: CustomLogo()),
        ),
        title: Text(
          title(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {},
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
            onPressed: () {},
            icon: Image.asset(
              IBillingIcons.zoom,
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: selectedIndex,
          onTap: (index) async {
            (index == 2)
                ? await _showDialogOfCreate()
                : setState(() => selectedIndex = index);
          }),
      body: pages[selectedIndex],
    );
  }

  String title() {
    switch (selectedIndex) {
      case 0:
        {
          return LocaleKeys.contracts.tr();
        }
      case 1:
        {
          return LocaleKeys.history.tr();
        }
      case 2:
        {
          return LocaleKeys.neww.tr();
        }
      case 3:
        {
          return LocaleKeys.save.tr();
        }
      case 4:
        {
          return LocaleKeys.profile.tr();
        }
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
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              color: Theme.of(context).primaryColor,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Text(LocaleKeys.what_do_you_want_to_create.tr()),
                    const SizedBox(height: 24),
                    Column(
                      children: [
                        FilledButton(
                          onPressed: () {
                            setState(() {
                              selectedIndex = 2;
                            });
                            Navigator.pop(context);
                          },
                          style: FilledButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                            backgroundColor: const Color(0xff4E4E4E),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                IBillingIcons.paper,
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                LocaleKeys.contract.tr(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: FilledButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                            backgroundColor: const Color(0xff4E4E4E),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                IBillingIcons.vaucher,
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                LocaleKeys.invoice.tr(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        )
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
}
