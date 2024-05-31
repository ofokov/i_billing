import 'package:flutter/material.dart';

import '../../domain/enteties/contracts.dart';
import 'contracts_card.dart';

class DisplayContracts extends StatelessWidget {
  final List<Contract> contracts;
  const DisplayContracts({super.key, required this.contracts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contracts.length,
      itemBuilder: (context, index) {
        final Contract contract = contracts[index];
        return ContractsCard(
          contract: Contract(
            contractState: contract.contractState,
            contractNumber: contract.contractNumber,
            fullName: contract.fullName,
            amount: contract.amount,
            lastInvoiceNumber: contract.lastInvoiceNumber,
            numberOfInvoices: contract.numberOfInvoices,
            date: contract.date,
            isSaved: contract.isSaved,
          ),
        );
      },
    );
  }
}
