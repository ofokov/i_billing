import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_billing/features/ibilling/presentation/screens/create_contract_page.dart';
import 'package:i_billing/features/ibilling/presentation/screens/filter_page.dart';
import 'package:i_billing/features/ibilling/presentation/screens/history_page.dart';
import 'package:i_billing/features/ibilling/presentation/screens/profile_page.dart';
import 'package:i_billing/features/ibilling/presentation/screens/save_page.dart';
import 'package:i_billing/generated/locale_keys.g.dart';

import '../widgets/custom_bottom_navigation_items.dart';
import '../widgets/custom_logo.dart';
import '../constants/style/ibilling_icons.dart';
import 'contracts_page.dart';
import 'searching_page.dart';

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
    const FilterPage()
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          actions: (selectedIndex == 4)
              ? null
              : [
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
                        setState(() {
                          selectedIndex =
                              selectedIndex; // Ensure this is the correct index
                        });
                      }
                    },
                    icon: SvgPicture.asset(
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
                          pageBuilder: (context, _, __) =>
                              const SearchingPage(),
                        ),
                      );
                    },
                    icon: SvgPicture.asset(
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
          },
        ),
        body: pages[selectedIndex],
      ),
    );
  }

  String title() {
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
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
                        ),
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

/*
AppBar(
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
          actions: (selectedIndex == 4)
              ? null
              : [
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
                        setState(() {
                          selectedIndex = 0; // Ensure this is the correct index
                        });
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
                      ).then((_) => BlocProvider.of<IbillingBloc>(context).add(
                          (selectedIndex == 0)
                              ? GetListOfContractInDate(
                                  dateTime: DateTime.now())
                              : (selectedIndex == 1)
                                  ? GetListOfContractInDateRange(
                                      minDate: DateTime.now(),
                                      maxDate: DateTime.now())
                                  : GetSavedListOfContracts()));
                    },
                    icon: Image.asset(
                      IBillingIcons.zoom,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
        )
*/

/*class _IBillingHomePageState extends State<IBillingHomePage> {
  List<Widget> pages = [
    const ContractsPage(),
    const HistoryPage(),
    const CreateContractPage(),
    const SavePage(),
    const ProfilePage(),
    const FilterPage()
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          actions: (selectedIndex == 4)
              ? null
              : [
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
                  setState(() {
                    selectedIndex = 0; // Ensure this is the correct index
                  });
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
                ).then((_) => BlocProvider.of<IbillingBloc>(context).add(
                    (selectedIndex == 0)
                        ? GetListOfContractInDate(
                        dateTime: DateTime.now())
                        : (selectedIndex == 1)
                        ? GetListOfContractInDateRange(
                        minDate: DateTime.now(),
                        maxDate: DateTime.now())
                        : GetSavedListOfContracts()));
              },
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
          },
        ),
        body: pages[selectedIndex],
      ),
    );
  }

  Expanded(
              child: buildNavItem(
                Image.asset(IBillingIcons.documentOutlined),
                Image.asset(IBillingIcons.documentFilled),
                LocaleKeys.contracts.tr(),
                0,
              ),
            ),
            Expanded(
              child: buildNavItem(
                Image.asset(IBillingIcons.historyOutlined),
                Image.asset(IBillingIcons.historyFilled),
                LocaleKeys.history.tr(),
                1,
              ),
            ),
            Expanded(
              child: buildNavItem(
                Image.asset(IBillingIcons.createOutlined),
                Image.asset(IBillingIcons.createFilled),
                LocaleKeys.neww.tr(),
                2,
              ),
            ),
            Expanded(
              child: buildNavItem(
                Image.asset(IBillingIcons.bookmarkOutlined),
                Image.asset(IBillingIcons.bookmarkFilled),
                LocaleKeys.save.tr(),
                3,
              ),
            ),
            Expanded(
              child: buildNavItem(
                Image.asset(IBillingIcons.profileOutlined),
                Image.asset(IBillingIcons.profileFilled),
                LocaleKeys.profile.tr(),
                4,
              ),
            ),



  CustomBottomNavigationBar(
          selectedIndex: selectedIndex,
          onTap: (index) async {
            (index == 2)
                ? await _showDialogOfCreate()
                : setState(() => selectedIndex = index);
          },
        )



  String title() {
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
                              borderRadius:
                              BorderRadius.all(Radius.circular(4)),
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
                              borderRadius:
                              BorderRadius.all(Radius.circular(4)),
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
                        ),
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
}*/
