import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_billing/features/ibilling/presentation/constants/formz_submission_status.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/custom_date.dart';

import '../bloc/ibilling_bloc/ibilling_bloc.dart';
import '../widgets/display_contracts.dart';
import '../widgets/shimmer_contract_card.dart';
import '../constants/style/ibilling_icons.dart';

class ContractsPage extends StatefulWidget {
  const ContractsPage({super.key});

  @override
  State<ContractsPage> createState() => _ContractsPageState();
}

class _ContractsPageState extends State<ContractsPage> {
  late bool hasConnection;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<IbillingBloc>(context)
        .add(GetListOfContractInDate(dateTime: selectedDate));
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      BlocProvider.of<IbillingBloc>(context)
          .add(GetListOfContractInDate(dateTime: selectedDate));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDate(onDateSelected: _onDateSelected),
        Expanded(
          child: BlocBuilder<IbillingBloc, IbillingState>(
            builder: (context, state) {
              if (state.inSpecificStatus == FormzSubmissionStatus.inProgress) {
                return ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return const ShimmerContractsCard();
                  },
                );
              } else if (state.inSpecificStatus ==
                  FormzSubmissionStatus.success) {
                return (state.inSpecificDateContract.isNotEmpty)
                    ? DisplayContracts(contracts: state.inSpecificDateContract)
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
              } else if (state.inSpecificStatus ==
                  FormzSubmissionStatus.failure) {
                return Center(
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
                        '',
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
