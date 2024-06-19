class Contract {
  final String contractState;
  final String id;
  final String tin;
  final int contractNumber;
  final String fullName;
  final String amount;
  final int lastInvoiceNumber;
  final int numberOfInvoices;
  final DateTime date;
  final bool isSaved;
  final String addressOfOrganization;

  Contract({
    this.addressOfOrganization = '',
    this.tin = '',
    this.id = '',
    this.contractState = 'Paid',
    this.isSaved = true,
    this.contractNumber = 456,
    this.fullName = 'ERROR',
    this.amount = 'ERROR',
    this.lastInvoiceNumber = 455,
    this.numberOfInvoices = 2,
    DateTime? date,
  }) : date = date ?? DateTime.now();
}
