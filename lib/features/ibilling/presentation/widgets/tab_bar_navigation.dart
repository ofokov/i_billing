import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../generated/locale_keys.g.dart';
import '../constants/style/ibilling_icons.dart';

class TabBarNavigation extends StatelessWidget {
  final TabController tabController;

  const TabBarNavigation({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff141416),
      child: TabBar(
        automaticIndicatorColorAdjustment: true,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        controller: tabController,
        tabs: [
          CustomTab(
            imagePath: (tabController.index != 0)
                ? IBillingIcons.documentOutlined
                : IBillingIcons.documentFilled,
            text: LocaleKeys.contracts.tr(),
          ),
          CustomTab(
            imagePath: (tabController.index != 1)
                ? IBillingIcons.historyOutlined
                : IBillingIcons.historyFilled,
            text: LocaleKeys.history.tr(),
          ),
          CustomTab(
            imagePath: (tabController.index != 2)
                ? IBillingIcons.createOutlined
                : IBillingIcons.createFilled,
            text: LocaleKeys.neww.tr(),
          ),
          CustomTab(
            imagePath: (tabController.index != 3)
                ? IBillingIcons.documentOutlined
                : IBillingIcons.bookmarkFilled,
            text: LocaleKeys.save.tr(),
          ),
          CustomTab(
            imagePath: (tabController.index != 4)
                ? IBillingIcons.profileOutlined
                : IBillingIcons.profileFilled,
            text: LocaleKeys.profile.tr(),
          ),
        ],
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final String imagePath;
  final String text;

  const CustomTab({
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: SvgPicture.asset(
        imagePath,
        width: 18,
        height: 20,
      ),
      text: text,
    );
  }
}
