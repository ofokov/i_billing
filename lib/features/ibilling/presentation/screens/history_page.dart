import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/custom_date_picker_button.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/style/ibilling_icons.dart';

import '../bloc/ibilling_bloc/ibilling_bloc.dart';
import '../widgets/display_contracts.dart';
import '../widgets/shimmer_contract_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime dateStart =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime dateEnd = DateTime.now().subtract(const Duration(minutes: 1));
  @override
  void initState() {
    BlocProvider.of<IbillingBloc>(context).add(GetListOfContractInDateRange(
      minDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      maxDate: DateTime.now(),
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Date',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CustomDatePickerButton(
                text: DateFormat("dd/MM/yyyy").format(dateStart),
                onChanged: (val) {
                  setState(() => dateStart = val);
                },
                maxDate: dateEnd,
                initialDate: dateStart,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(width: 10, child: Divider()),
              ),
              CustomDatePickerButton(
                initialDate: dateEnd,
                text: DateFormat("dd/MM/yyyy").format(dateEnd),
                onChanged: (val) {
                  setState(() => dateEnd = val);
                },
                minDate: dateStart,
                maxDate: DateTime.now().add(Duration(days: 1)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<IbillingBloc>(context)
                    .add(GetListOfContractInDateRange(
                  minDate: dateStart,
                  maxDate: dateEnd,
                ));
              },
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
                "Find",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<IbillingBloc, IbillingState>(
              builder: (context, state) {
                if (state is Initial) {
                  return const Center(
                    child: Text('No initial data'),
                  );
                } else if (state is Loading) {
                  return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const ShimmerContractsCard();
                    },
                  );
                } else if (state is LoadedListOfContractInDateRange) {
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
                                'No saved contracts',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        );
                }
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
                        'No saved contracts',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/*
BlocBuilder<IbillingBloc, IbillingState>(
      builder: (context, state) {
        if (state is Initial) {
        } else if (state is Loading) {
          return ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return const ShimmerContractsCard();
            },
          );
        } else if (state is LoadedListOfContracts) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Date',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CustomDatePickerButton(
                      text: DateFormat("dd/MM/yyyy").format(dateStart),
                      onChanged: (val) {
                        setState(() => dateStart = val);
                      },
                      maxDate: dateEnd,
                      initialDate: dateStart,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(width: 10, child: Divider()),
                    ),
                    CustomDatePickerButton(
                      initialDate: dateEnd,
                      text: DateFormat("dd/MM/yyyy").format(dateEnd),
                      onChanged: (val) {
                        setState(() => dateEnd = val);
                      },
                      minDate: dateStart,
                      maxDate: DateTime.now(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(child: DisplayContracts(contracts: state.contracts)),
              ],
            ),
          );
        }
        return Container();
      },
    );
*/
