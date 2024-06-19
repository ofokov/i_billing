import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_billing/features/ibilling/presentation/screens/create_contract_page.dart';
import 'package:i_billing/features/ibilling/presentation/screens/filter_page.dart';
import 'package:i_billing/features/ibilling/presentation/screens/history_page.dart';
import 'package:i_billing/features/ibilling/presentation/screens/profile_page.dart';
import 'package:i_billing/features/ibilling/presentation/screens/save_page.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/tab_bar_bottom.dart';
import 'package:i_billing/generated/locale_keys.g.dart';

import '../constants/style/ibilling_icons.dart';
import '../widgets/custom_bottom_navigation_items.dart';
import '../widgets/custom_logo.dart';
import 'contracts_page.dart';
import 'searching_page.dart';

class IBillingHomePage extends StatefulWidget {
  final String title;
  const IBillingHomePage({super.key, required this.title});

  @override
  State<IBillingHomePage> createState() => _IBillingHomePageState();
}

class _IBillingHomePageState extends State<IBillingHomePage>
    with TickerProviderStateMixin {
  late TabController tabController;
  List<Widget> pages = [
    const ContractsPage(),
    const HistoryPage(),
    const CreateContractPage(),
    const SavePage(),
    const ProfilePage(),
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(() {
      setState(() {
        selectedIndex = tabController.index;
      });
    });
  }

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
          actions: (selectedIndex == 4 || selectedIndex == 2)
              ? null
              : [
                  IconButton(
                    onPressed: () async {
                      bool? filtersApplied = await Navigator.push(
                        context,
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (context, _, __) => FilterPage(
                            pageIndex: selectedIndex,
                          ),
                        ),
                      );
                      if (filtersApplied == true) {
                        setState(() {
                          selectedIndex = selectedIndex;
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
            if (index == 2) {
              await _showDialogOfCreate();
            } else {
              setState(() {
                selectedIndex = index;
                tabController.index = selectedIndex;
              });
            }
          },
        ),
        body: TabBarBottom(
          pages: pages,
          tabController: tabController,
        ),
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
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                selectedIndex = 2;
                                tabController.index = selectedIndex;
                              });
                            },
                            child: Ink(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: Color(0xff4E4E4E),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
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
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Ink(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: Color(0xff4E4E4E),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
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
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
