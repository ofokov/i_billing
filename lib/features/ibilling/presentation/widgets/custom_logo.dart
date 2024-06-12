import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/style/ibilling_icons.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      IBillingIcons.logo,
      height: 24,
      width: 24,
    );
  }
}
