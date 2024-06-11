import 'package:flutter/material.dart';

import '../../domain/enteties/contracts.dart';
import 'contracts_card.dart';

class DisplayContracts extends StatefulWidget {
  // final Future<List<Contract>> Function()? getMore;
  final List<Contract> contracts;
  const DisplayContracts({
    super.key,
    required this.contracts,
    // this.getMore,
  });

  @override
  State<DisplayContracts> createState() => _DisplayContractsState();
}

class _DisplayContractsState extends State<DisplayContracts> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.contracts.length,
      itemBuilder: (context, index) {
        final Contract contract = widget.contracts[index];
        return ContractsCard(contract: contract);
      },
    );
  }
}
