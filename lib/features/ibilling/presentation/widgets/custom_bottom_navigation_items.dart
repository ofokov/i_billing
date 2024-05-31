import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/style/ibilling_icons.dart';
import 'package:i_billing/generated/locale_keys.g.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
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
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(Image icon, Image activeIcon, String label, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => (onTap(index)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            isSelected ? activeIcon : icon,
            const SizedBox(height: 3),
            Text(
              label,
              style: (isSelected)
                  ? const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: "Ubuntu",
                    )
                  : const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF999999),
                      fontFamily: "Ubuntu",
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/*bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: index,
        onTap: (integer) {
          setState(() {
            index = integer;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Contracts",
            icon: Image.asset(IBillingIcons.documentOutlined),
            activeIcon: Image.asset(IBillingIcons.documentFilled),
          ),
          BottomNavigationBarItem(
            label: "History",
            icon: Image.asset(IBillingIcons.historyOutlined),
            activeIcon: Image.asset(IBillingIcons.historyFilled),
          ),
          BottomNavigationBarItem(
            label: "New",
            icon: Image.asset(IBillingIcons.createOutlined),
            activeIcon: Image.asset(IBillingIcons.createFilled),
          ),
          BottomNavigationBarItem(
            label: "Saved",
            icon: Image.asset(IBillingIcons.bookmarkOutlined),
            activeIcon: Image.asset(IBillingIcons.bookmarkFilled),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Image.asset(IBillingIcons.profileOutlined),
            activeIcon: Image.asset(IBillingIcons.profileFilled),
          ),
        ],
      ),*/
