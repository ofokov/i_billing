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
          contract: contract,
        );
      },
    );
  }
}
