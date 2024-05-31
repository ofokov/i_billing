class Contract {
  final String contractState;
  final int contractNumber;
  final String fullName;
  final String amount;
  final int lastInvoiceNumber;
  final int numberOfInvoices;
  final DateTime date;
  final bool isSaved;

  Contract({
    required this.contractState,
    required this.isSaved,
    required this.contractNumber,
    required this.fullName,
    required this.amount,
    required this.lastInvoiceNumber,
    required this.numberOfInvoices,
    required this.date,
  });
}

/*enum ContractState {
  paid("Paid", 0xFF49B7A5),
  inProgress("In progress", 0xFFFDAB2A),
  rejectedByPayme("Rejected by Payme", 0xFFFF426D),
  rejectedByIQ("Rejected by IQ", 0xFFFF426D);

  final String name;
  final int colorCode;

  const ContractState(this.name, this.colorCode);
}*/
