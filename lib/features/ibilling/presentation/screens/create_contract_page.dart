import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/features/ibilling/data/models/contract_model.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/custom_selection_dropdown.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/custom_text_from_field.dart';

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

  void save() {
    if (selectedEntity != null &&
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
        selectedStatus != null) {
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
    } else {
      showModalBottomSheet(
          context: context,
          isDismissible: false,
          builder: (BuildContext context) {
            // Start a timer to close the bottom sheet after 3 seconds
            Timer(const Duration(seconds: 2), () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            });
            return Container(
              height: 100,
              color: Colors.black,
              child: const Center(
                child: Text(
                  'Invalid value',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            );
          });
    }
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
            CustomDropdownButtonFormField(
              onChanged: (value) {
                selectedEntity = value;
              },
              entityList: entityList,
              name: 'Лицо',
            ),
            CustomTextFromField(
              name: "Fisher’s full name",
              onChanged: (value) {
                fullName = value;
              },
            ),
            CustomTextFromField(
              name: 'Address of Organization',
              onChanged: (value) {
                addressOfOrganization = value;
              },
            ),
            CustomTextFromField(
              textInputType: TextInputType.number,
              name: 'ИНН',
              onChanged: (value) {
                tin = value;
              },
            ),
            CustomDropdownButtonFormField(
              onChanged: (value) {
                selectedStatus = value;
              },
              entityList: statusList,
              name: 'Статус',
            ),
            CustomTextFromField(
              name: 'Название операции',
              onChanged: (value) {
                nameTransaction = value;
              },
            ),
            CustomTextFromField(
              textInputType: TextInputType.number,
              name: 'Сумма счета',
              onChanged: (value) {
                amount = value;
              },
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder<IbillingBloc, IbillingState>(
                builder: (context, state) {
                  if (state is Initial) {
                    return ElevatedButton(
                      onPressed: save,
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
                        "Save Contract",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  } else if (state is Loading) {
                    return ElevatedButton(
                      onPressed: save,
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
                  } else if (state is CreateSuccessfully) {
                    return ElevatedButton(
                      onPressed: save,
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
                        "Save Contract",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  } else if (state is Erorr) {
                    return ElevatedButton(
                      onPressed: save,
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
                        "Save Contract",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }
                  return ElevatedButton(
                    onPressed: save,
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
                      "Save Contract",
                      style: Theme.of(context).textTheme.bodyLarge,
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
