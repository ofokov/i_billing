import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../domain/enteties/contracts.dart';

class ExpandedContractCard extends StatelessWidget {
  final Contract contract;
  const ExpandedContractCard({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 11,
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: LocaleKeys.full_name.tr(),
                      style: Theme.of(context).textTheme.headlineSmall),
                  TextSpan(
                      text: "${contract.fullName}\n",
                      style: Theme.of(context).textTheme.labelMedium),
                  TextSpan(
                      text: LocaleKeys.status_of_the_contract.tr(),
                      style: Theme.of(context).textTheme.headlineSmall),
                  TextSpan(
                      text: "${contract.contractState}\n",
                      style: Theme.of(context).textTheme.labelMedium),
                  TextSpan(
                      text: LocaleKeys.amount.tr(),
                      style: Theme.of(context).textTheme.headlineSmall),
                  TextSpan(
                      text: "${contract.amount}\n",
                      style: Theme.of(context).textTheme.labelMedium),
                  TextSpan(
                      text: LocaleKeys.last_invoice.tr(),
                      style: Theme.of(context).textTheme.headlineSmall),
                  TextSpan(
                      text: "№ ${contract.lastInvoiceNumber} \n",
                      style: Theme.of(context).textTheme.labelMedium),
                  TextSpan(
                      text: LocaleKeys.address_of_the_organization.tr(),
                      style: Theme.of(context).textTheme.headlineSmall),
                  TextSpan(
                      text: "${contract.addressOfOrganization}\n",
                      style: Theme.of(context).textTheme.labelMedium),
                  TextSpan(
                      text: LocaleKeys.itn_of_the_organization.tr(),
                      style: Theme.of(context).textTheme.headlineSmall),
                  TextSpan(
                      text: "${contract.tin}\n",
                      style: Theme.of(context).textTheme.labelMedium),
                  TextSpan(
                      text: LocaleKeys.created_at.tr(),
                      style: Theme.of(context).textTheme.headlineSmall),
                  TextSpan(
                      text: DateFormat('dd.MM.yy').format(contract.date),
                      style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
