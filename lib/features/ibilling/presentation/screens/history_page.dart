import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/custom_date_picker_button.dart';

import '../bloc/ibilling_bloc/ibilling_bloc.dart';
import '../widgets/display_contracts.dart';
import '../widgets/shimmer_contract_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime dateStart = DateTime.now().subtract(const Duration(hours: 1));
  DateTime dateEnd = DateTime.now().subtract(const Duration(minutes: 10));
  @override
  void initState() {
    BlocProvider.of<IbillingBloc>(context).add(const GetListOfContracts());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IbillingBloc, IbillingState>(
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
                  child: Text('Date', style: Theme.of(context).textTheme.titleMedium,),
                ),
                SizedBox(height: 20),
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
  }
}
