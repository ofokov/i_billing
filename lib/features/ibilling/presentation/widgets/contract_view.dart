import 'package:flutter/material.dart';
import '../constants/style/ibilling_icons.dart';

import '../../domain/enteties/contracts.dart';

class ContractView extends StatelessWidget {
  final Contract contract;
  const ContractView({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Row(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                        child: Image.asset(
                          IBillingIcons.paper,
                          width: 15,
                          height: 15,
                        ),
                      ),
                      TextSpan(
                          text: "№ ${contract.contractNumber}",
                          style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                ),
              ],
            ),
            actions: [Image.asset(IBillingIcons.bookmarkOutlined)]),
      ],
    );
  }
}
