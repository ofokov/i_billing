import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
    print('============ HELOO');
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
        return Container(
          child: Center(
            child: SvgPicture.asset(
              color: Theme.of(context).primaryColor,
              IBillingIcons.noData,
              semanticsLabel: 'No data',
              height: 80,
              width: 80,
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
