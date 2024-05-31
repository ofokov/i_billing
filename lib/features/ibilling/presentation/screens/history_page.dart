import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/ibilling_bloc/ibilling_bloc.dart';
import '../widgets/display_contracts.dart';
import '../widgets/shimmer_contract_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    BlocProvider.of<IbillingBloc>(context).add(const GetListOfContracts());
    ;
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
          return DisplayContracts(contracts: state.contracts);
        }
        return Container();
      },
    );
  }
}
