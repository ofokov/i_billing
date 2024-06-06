import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/custom_date.dart';

import '../bloc/ibilling_bloc/ibilling_bloc.dart';
import '../widgets/display_contracts.dart';
import '../widgets/shimmer_contract_card.dart';
import '../widgets/style/ibilling_icons.dart';

class ContractsPage extends StatefulWidget {
  const ContractsPage({super.key});

  @override
  State<ContractsPage> createState() => _ContractsPageState();
}

class _ContractsPageState extends State<ContractsPage> {
  @override
  void initState() {
    BlocProvider.of<IbillingBloc>(context)
        .add(GetListOfContractInDate(dateTime: DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomDate(),
        Expanded(
          child: BlocBuilder<IbillingBloc, IbillingState>(
            builder: (context, state) {
              if (state is Loading) {
                return ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return const ShimmerContractsCard();
                  },
                );
              } else if (state is LoadedListOfContracts) {
                return (state.contracts.isNotEmpty)
                    ? DisplayContracts(contracts: state.contracts)
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              color: Theme.of(context).primaryColor,
                              IBillingIcons.noData,
                              semanticsLabel: 'No data',
                              height: 80,
                              width: 80,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'No contracts',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}

/*
ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return ContractsCard(
                contract: Contract(
                  contractState: 'Paid',
                  contractNumber: 222,
                  fullName: 'Ofoqov Abdulboriy',
                  amount: "9,564,444,200,000 UZS",
                  lastInvoiceNumber: 156,
                  numberOfInvoices: 6,
                  date: '31.12.2024',
                  isSaved: true,
                ),
              );
            },
          )
*/

/*
BlocBuilder<IbillingBloc, IbillingState>(
            builder: (context, state) {
              if (state is Initial) {
                return Container(
                  width: 200,
                  height: 200,
                  color: Colors.white,
                );
              } else if (state is Loading) {
                return CircularProgressIndicator();
              } else if (state is LoadedListOfContracts){}
            },
          ),
*/
