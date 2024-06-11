import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../domain/enteties/contracts.dart';

class ContractExpandedDetailsCard extends StatelessWidget {
  final Contract contract;

  const ContractExpandedDetailsCard({Key? key, required this.contract})
      : super(key: key);

  final TextStyle style = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontFamily: "Ubuntu",
    height: 2.5,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: LocaleKeys.full_name.tr(), style: style),
                    TextSpan(
                      text: "${contract.fullName}\n",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    TextSpan(
                        text: LocaleKeys.status_of_the_contract.tr(),
                        style: style),
                    TextSpan(
                      text: "${contract.contractState}\n",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    TextSpan(text: LocaleKeys.amount.tr(), style: style),
                    TextSpan(
                      text: "${contract.amount}\n",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    TextSpan(text: LocaleKeys.last_invoice.tr(), style: style),
                    TextSpan(
                      text: "№ ${contract.lastInvoiceNumber}\n",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    TextSpan(
                      text: LocaleKeys.address_of_the_organization.tr(),
                      style: style,
                    ),
                    TextSpan(
                      text: "${contract.addressOfOrganization}\n",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    TextSpan(
                        text: LocaleKeys.itn_of_the_organization.tr(),
                        style: style),
                    TextSpan(
                      text: "${contract.tin}\n",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    TextSpan(text: LocaleKeys.created_at.tr(), style: style),
                    TextSpan(
                      text: DateFormat('dd.MM.yy').format(contract.date),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
