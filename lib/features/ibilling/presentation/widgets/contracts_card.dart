import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_billing/generated/locale_keys.g.dart';

import '../../domain/enteties/contracts.dart';
import 'style/ibilling_icons.dart';

class ContractsCard extends StatelessWidget {
  final Contract contract;
  const ContractsCard({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    var (status, colorCode) = _getStateInfo(contract.contractState);
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Color(colorCode).withOpacity(0.15),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(colorCode)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
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
                      text: LocaleKeys.amount.tr(),
                      style: Theme.of(context).textTheme.headlineSmall),
                  TextSpan(
                      text: "${contract.amount}\n",
                      style: Theme.of(context).textTheme.labelMedium),
                  TextSpan(
                      text: LocaleKeys.last_invoice.tr(),
                      style: Theme.of(context).textTheme.headlineSmall),
                  TextSpan(
                      text: "№ ${contract.lastInvoiceNumber}",
                      style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: LocaleKeys.number_of_invoice.tr(),
                          style: Theme.of(context).textTheme.headlineSmall),
                      TextSpan(
                          text: "${contract.numberOfInvoices}",
                          style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ),
                Text(
                  "${contract.date.day}.${contract.date.month}.${contract.date.year}",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  (String, int) _getStateInfo(String contractState) {
    switch (contractState.toLowerCase()) {
      case 'paid':
        {
          return ("Paid", 0xFF49B7A5);
        }
      case 'in progress':
        {
          return ("In progress", 0xFFFDAB2A);
        }
      case 'rejected by payme':
        {
          return ("Rejected by Payme", 0xFFFF426D);
        }
      case 'rejected by iq':
        {
          return ("Rejected by IQ", 0xFFFF426D);
        }
      default:
        return ("Undefined", 0xFF999999);
    }
  }
}
