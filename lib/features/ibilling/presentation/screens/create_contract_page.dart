import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/features/ibilling/data/models/contract_model.dart';
import 'package:i_billing/features/ibilling/presentation/constants/formz_submission_status.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/custom_overlay_portal.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/custom_text_from_field.dart';

import '../../../../generated/locale_keys.g.dart';
import '../bloc/ibilling_bloc/ibilling_bloc.dart';

class CreateContractPage extends StatefulWidget {
  const CreateContractPage({super.key});

  @override
  State<CreateContractPage> createState() => _CreateContractPageState();
}

class _CreateContractPageState extends State<CreateContractPage> {
  List<String> entityList = ['Физическое', 'Юридическое'];
  List<String> statusList = [
    'Paid',
    'In progress',
    'Rejected by IQ',
    'Rejected by Payme',
  ];
  String? selectedEntity;
  String? fullName;
  String? addressOfOrganization;
  String? tin;
  String? selectedStatus;
  String? amount;
  String? nameTransaction;

  bool checkReadyToSave() {
    return selectedEntity != null &&
        fullName != null &&
        fullName!.isNotEmpty &&
        nameTransaction != null &&
        nameTransaction!.isNotEmpty &&
        amount != null &&
        amount!.isNotEmpty &&
        addressOfOrganization != null &&
        addressOfOrganization!.isNotEmpty &&
        tin != null &&
        tin!.isNotEmpty &&
        selectedStatus != null;
  }

  void save() {
    BlocProvider.of<IbillingBloc>(context).add(
      CreateContract(
        ContractModel(
          tin: tin!,
          addressOfOrganization: addressOfOrganization!,
          contractState: selectedStatus!,
          isSaved: false,
          contractNumber: Random().nextInt(500),
          fullName: fullName!,
          amount: '$amount UZS',
          lastInvoiceNumber: 244,
          numberOfInvoices: 8,
          date: DateTime.now(),
          id: '',
        ),
      ),
    );
  }

  void updateState(VoidCallback fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomOverlayPortal(
              onChanged: (value) {
                updateState(() {
                  selectedEntity = value;
                });
              },
              entityList: entityList,
              name: LocaleKeys.entity.tr(),
            ),
            CustomTextFromField(
              name: LocaleKeys.fishers_full_name.tr(),
              onChanged: (value) {
                updateState(() {
                  fullName = value;
                });
              },
            ),
            CustomTextFromField(
              name: LocaleKeys.address_of_the_organization.tr(),
              onChanged: (value) {
                updateState(() {
                  addressOfOrganization = value;
                });
              },
            ),
            CustomTextFromField(
              maxLength: 9,
              textInputType: TextInputType.number,
              name: LocaleKeys.tin.tr(),
              onChanged: (value) {
                updateState(() {
                  tin = value;
                });
              },
            ),
            CustomOverlayPortal(
              onChanged: (value) {
                updateState(() {
                  selectedStatus = value;
                });
              },
              entityList: statusList,
              name: LocaleKeys.status.tr(),
            ),
            CustomTextFromField(
              name: LocaleKeys.name_of_operation.tr(),
              onChanged: (value) {
                updateState(() {
                  nameTransaction = value;
                });
              },
            ),
            CustomTextFromField(
              textInputType: TextInputType.number,
              name: LocaleKeys.amount_of_invoice.tr(),
              onChanged: (value) {
                updateState(() {
                  amount = value;
                });
              },
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder<IbillingBloc, IbillingState>(
                builder: (context, state) {
                  if (state.createContractStatus ==
                      FormzSubmissionStatus.inProgress) {
                    return ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor:
                            const Color(0xff00A795).withOpacity(0.4),
                        disabledForegroundColor: Colors.white.withOpacity(0.1),
                        backgroundColor: const Color(0xff00A795),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                      ),
                      child:
                          const CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  return SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: checkReadyToSave() ? save : null,
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor:
                            const Color(0xff00A795).withOpacity(0.4),
                        disabledForegroundColor: Colors.white.withOpacity(0.1),
                        backgroundColor: const Color(0xff00A795),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                      ),
                      child: Text(
                        LocaleKeys.save_contract.tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
