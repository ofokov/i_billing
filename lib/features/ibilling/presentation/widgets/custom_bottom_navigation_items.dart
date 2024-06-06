import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
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
            buildNavItem(
              SvgPicture.asset(
                IBillingIcons.documentOutlined,
                width: 18,
                height: 20,
              ),
              SvgPicture.asset(
                IBillingIcons.documentFilled,
                width: 18,
                height: 20,
              ),
              LocaleKeys.contracts.tr(),
              0,
            ),
            buildNavItem(
              SvgPicture.asset(
                IBillingIcons.historyOutlined,
                width: 18,
                height: 20,
              ),
              SvgPicture.asset(
                IBillingIcons.historyFilled,
                width: 18,
                height: 20,
              ),
              LocaleKeys.history.tr(),
              1,
            ),
            buildNavItem(
              SvgPicture.asset(
                IBillingIcons.createOutlined,
                width: 18,
                height: 20,
              ),
              SvgPicture.asset(
                IBillingIcons.createFilled,
                width: 18,
                height: 20,
              ),
              LocaleKeys.neww.tr(),
              2,
            ),
            buildNavItem(
              SvgPicture.asset(
                IBillingIcons.bookmarkOutlined,
                width: 18,
                height: 20,
              ),
              SvgPicture.asset(
                IBillingIcons.bookmarkFilled,
                width: 18,
                height: 20,
              ),
              LocaleKeys.save.tr(),
              3,
            ),
            buildNavItem(
              SvgPicture.asset(
                IBillingIcons.profileOutlined,
                width: 18,
                height: 20,
              ),
              SvgPicture.asset(
                IBillingIcons.profileFilled,
                width: 18,
                height: 20,
              ),
              LocaleKeys.profile.tr(),
              4,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(
      SvgPicture icon, SvgPicture activeIcon, String label, int index) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => (onTap(index)),
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
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
