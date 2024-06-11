import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/bloc/ibilling_bloc/ibilling_bloc.dart';

import '../../domain/enteties/contracts.dart';
import 'contract_expanded_detailed_card.dart';
import 'expanded_contract_appbar.dart';

class ExpandedContractCard extends StatefulWidget {
  final Contract contract;

  const ExpandedContractCard({super.key, required this.contract});

  @override
  State<ExpandedContractCard> createState() => _ExpandedContractCardState();
}

class _ExpandedContractCardState extends State<ExpandedContractCard> {
  late bool isSaved;
  TextEditingController controller = TextEditingController();
  bool buttonIsVisible = false;

  @override
  void initState() {
    super.initState();
    isSaved = widget.contract.isSaved;
    controller.addListener(() {
      setState(() {
        buttonIsVisible = controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    controller.addListener(() {
      setState(() {
        buttonIsVisible = controller.text.isNotEmpty;
      });
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ExpandedContractAppBar(
        contract: widget.contract,
        isSaved: isSaved,
        onSaveToggle: () {
          setState(() {
            isSaved = !isSaved;
            BlocProvider.of<IbillingBloc>(context).add(
              ContractChangeSaveState(
                  contract: widget.contract, isSaved: isSaved),
            );
          });
        },
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ContractExpandedDetailsCard(contract: widget.contract),
            const SizedBox(height: 10),
            ActionButtons(
              contract: widget.contract,
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final TextEditingController controller;
  final Contract contract;

  const ActionButtons(
      {super.key, required this.controller, required this.contract});

  final OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(color: Color(0xff2A2A2D)),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return DeleteContractDialog(
                      contract: contract, controller: controller);
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffFF426D).withOpacity(0.3),
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
            ),
            child: const Text(
              "Delete contract",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(0xffFF426D),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff00A795),
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
            ),
            child: const Text(
              "Create contract",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DeleteContractDialog extends StatefulWidget {
  final TextEditingController controller;
  final Contract contract;

  const DeleteContractDialog(
      {super.key, required this.controller, required this.contract});

  @override
  State<DeleteContractDialog> createState() => _DeleteContractDialogState();
}

class _DeleteContractDialogState extends State<DeleteContractDialog> {
  bool buttonIsVisible = false;

  final OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(color: Color(0xff2A2A2D)),
  );

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateButtonVisibility);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateButtonVisibility);
    super.dispose();
  }

  void _updateButtonVisibility() {
    setState(() {
      buttonIsVisible = widget.controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff2A2A2D),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  "Leave a comment, why are you deleting this contract?",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: widget.controller,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    hintText: 'Type a comment',
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    fillColor: const Color(0xff5C5C5C),
                    border: outlineInputBorder,
                    filled: true,
                    focusedBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                  ),
                ),
                if (buttonIsVisible)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              widget.controller.clear();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xffFF426D).withOpacity(0.3),
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                            ),
                            child: const Text(
                              "Cancle",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xffFF426D),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<IbillingBloc>(context)
                                  .add(DeleteContract(widget.contract));
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffFF426D),
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                            ),
                            child: const Text(
                              "Done",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
