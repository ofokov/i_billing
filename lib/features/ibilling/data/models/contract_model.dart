import 'package:easy_localization/easy_localization.dart';
import 'package:i_billing/features/ibilling/domain/enteties/contracts.dart';

class ContractModel extends Contract {
  final String? addressOfOrganization;
  ContractModel({
    required super.contractState,
    required super.isSaved,
    required super.contractNumber,
    required super.fullName,
    required super.amount,
    required super.lastInvoiceNumber,
    required super.numberOfInvoices,
    required super.date,
    this.addressOfOrganization,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      addressOfOrganization: json['addressOfOrganization'] as String,
      contractState: json["contractState"] as String,
      contractNumber: (json["contractNumber"] as num).toInt(),
      isSaved: json["isSaved"] as bool,
      fullName: json["fullName"] as String,
      amount: json["amount"] as String,
      lastInvoiceNumber: (json["lastInvoiceNumber"] as num).toInt(),
      numberOfInvoices: (json["numberOfInvoices"] as num).toInt(),
      date: (DateFormat("dd.MM.yyyy").parse(json["date"] as String)),
    );
  }
  // DateFormat("MM/dd/yy")
  //         .format(DateFormat("MM/dd/yy").parse('04/03/20'))

  Map<String, dynamic> toJson() {
    return {
      'contractState': contractState,
      'contractNumber': contractNumber,
      'isSaved': isSaved,
      'fullName': fullName,
      'amount': amount,
      'lastInvoiceNumber': lastInvoiceNumber,
      'numberOfInvoices': numberOfInvoices,
      'date': (DateFormat("dd.MM.yyyy").format(date)),
      'addressOfOrganization': addressOfOrganization,
    };
  }
}
