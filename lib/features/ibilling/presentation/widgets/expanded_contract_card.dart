import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_billing/features/ibilling/presentation/bloc/ibilling_bloc/ibilling_bloc.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../domain/enteties/contracts.dart';
import '../constants/style/ibilling_icons.dart';

class ExpandedContractCard extends StatefulWidget {
  final Contract contract;
  const ExpandedContractCard({super.key, required this.contract});

  @override
  State<ExpandedContractCard> createState() => _ExpandedContractCardState();
}

class _ExpandedContractCardState extends State<ExpandedContractCard> {
  late bool isSaved;
  @override
  void initState() {
    isSaved = widget.contract.isSaved;
    super.initState();
  }

  TextStyle style = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontFamily: "Ubuntu",
      height: 2.5);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSaved = !isSaved;
                BlocProvider.of<IbillingBloc>(context).add(
                    ContractChangeSaveState(
                        contract: widget.contract, isSaved: isSaved));
              });
            },
            icon: (isSaved)
                ? SvgPicture.asset(
                    IBillingIcons.bookmarkFilled,
                    width: 18,
                    height: 20,
                  )
                : SvgPicture.asset(
                    IBillingIcons.bookmarkOutlined,
                    width: 18,
                    height: 20,
                  ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            Image.asset(
              IBillingIcons.vaucher,
              width: 17,
              height: 20,
            ),
            const SizedBox(width: 8),
            Text(
              "№ ${widget.contract.lastInvoiceNumber}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
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
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: LocaleKeys.full_name.tr(),
                                  style: style),
                              TextSpan(
                                  text: "${widget.contract.fullName}\n",
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              TextSpan(
                                  text: LocaleKeys.status_of_the_contract.tr(),
                                  style: style),
                              TextSpan(
                                  text: "${widget.contract.contractState}\n",
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              TextSpan(
                                  text: LocaleKeys.amount.tr(), style: style),
                              TextSpan(
                                  text: "${widget.contract.amount}\n",
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              TextSpan(
                                  text: LocaleKeys.last_invoice.tr(),
                                  style: style),
                              TextSpan(
                                  text:
                                      "№ ${widget.contract.lastInvoiceNumber} \n",
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              TextSpan(
                                  text: LocaleKeys.address_of_the_organization
                                      .tr(),
                                  style: style),
                              TextSpan(
                                  text:
                                      "${widget.contract.addressOfOrganization}\n",
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              TextSpan(
                                  text: LocaleKeys.itn_of_the_organization.tr(),
                                  style: style),
                              TextSpan(
                                  text: "${widget.contract.tin}\n",
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              TextSpan(
                                  text: LocaleKeys.created_at.tr(),
                                  style: style),
                              TextSpan(
                                  text: DateFormat('dd.MM.yy')
                                      .format(widget.contract.date),
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<IbillingBloc>(context)
                            .add(DeleteContract(widget.contract));
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xffFF426D).withOpacity(0.3),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Delete contract",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xffFF426D)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      // In the FilterPage class, wrap the Navigator.pop in the onPressed callback of Apply Filters button
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor:
                            const Color(0xff00A795).withOpacity(0.4),
                        backgroundColor: const Color(0xff00A795),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
