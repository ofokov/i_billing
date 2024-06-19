import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../generated/locale_keys.g.dart';
import '../constants/style/ibilling_icons.dart';
import '../widgets/custom_bottom_navigation_items.dart';
import '../widgets/custom_logo.dart';
import '../widgets/tab_bar_bottom.dart';
import 'contracts_page.dart';
import 'create_contract_page.dart';
import 'filter_page.dart';
import 'history_page.dart';
import 'profile_page.dart';
import 'save_page.dart';
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
  ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

  List<Widget> pages = [
    const ContractsPage(),
    const HistoryPage(),
    const CreateContractPage(),
    const SavePage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(() {
      selectedIndexNotifier.value = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        appBar: IBillingAppBar(
          title: widget.title,
          selectedIndexNotifier: selectedIndexNotifier,
          tabController: tabController,
        ),
        bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: selectedIndexNotifier,
          builder: (context, selectedIndex, child) {
            return CustomBottomNavigationBar(
              selectedIndex: selectedIndex,
              onTap: (index) async {
                if (index == 2) {
                  await _showDialogOfCreate();
                } else {
                  selectedIndexNotifier.value = index;
                  tabController.index = selectedIndexNotifier.value;
                }
              },
            );
          },
        ),
        body: ValueListenableBuilder<int>(
          valueListenable: selectedIndexNotifier,
          builder: (context, selectedIndex, child) {
            return TabBarBottom(
              pages: pages,
              tabController: tabController,
            );
          },
        ),
      ),
    );
  }

  Future<void> _showDialogOfCreate() async {
    await showDialog(
      context: context,
      builder: (context) {
        return CreateDialog(
          onSelectContract: () {
            Navigator.pop(context);
            selectedIndexNotifier.value = 2;
            tabController.index = selectedIndexNotifier.value;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    selectedIndexNotifier.dispose();
    super.dispose();
  }
}

class IBillingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final ValueNotifier<int> selectedIndexNotifier;
  final TabController tabController;

  const IBillingAppBar({
    super.key,
    required this.title,
    required this.selectedIndexNotifier,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 44,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      leading: const Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: SizedBox(child: CustomLogo()),
      ),
      title: ValueListenableBuilder<int>(
        valueListenable: selectedIndexNotifier,
        builder: (context, selectedIndex, child) {
          return Text(
            titleForIndex(selectedIndex),
            style: Theme.of(context).textTheme.titleMedium,
          );
        },
      ),
      actions: [
        ValueListenableBuilder<int>(
          valueListenable: selectedIndexNotifier,
          builder: (context, selectedIndex, child) {
            if (selectedIndex == 4 || selectedIndex == 2) {
              return Container();
            } else {
              return Row(
                children: [
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
                        // Handle filter applied case if necessary
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
              );
            }
          },
        ),
      ],
    );
  }

  String titleForIndex(int selectedIndex) {
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CreateDialog extends StatelessWidget {
  final VoidCallback onSelectContract;

  const CreateDialog({
    super.key,
    required this.onSelectContract,
  });

  @override
  Widget build(BuildContext context) {
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
                        onTap: onSelectContract,
                        child: Ink(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
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
                                  style: Theme.of(context).textTheme.bodyLarge,
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
                          // Handle invoice creation logic here
                        },
                        child: Ink(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
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
                                  style: Theme.of(context).textTheme.bodyLarge,
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
  }
}
