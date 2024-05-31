import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/bloc/ibilling_bloc/ibilling_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/display_contracts.dart';

import '../widgets/shimmer_contract_card.dart';
import '../widgets/style/ibilling_icons.dart';

class SavePage extends StatefulWidget {
  const SavePage({Key? key}) : super(key: key);

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  @override
  void initState() {
    BlocProvider.of<IbillingBloc>(context).add(const GetSavedListOfContracts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IbillingBloc, IbillingState>(
      builder: (context, state) {
        if (state is Loading) {
          return ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return const ShimmerContractsCard();
            },
          );
        } else if (state is LoadedSavedListOfContracts) {
          return DisplayContracts(contracts: state.contracts);
        }
        return Container(
          color: Theme.of(context).secondaryHeaderColor,
          child: Center(
            child: Image.asset(
              IBillingIcons.noSavedContracts,
              scale: 4,
            ),
          ),
        );
      },
    );
  }
}

/*
Container(
      color: Theme.of(context).secondaryHeaderColor,
      child: Center(
        child: Image.asset(
          IBillingIcons.noSavedContracts,
          scale: 4,
        ),
      ),
    );
*/
