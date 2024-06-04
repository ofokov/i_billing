import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/bloc/ibilling_bloc/ibilling_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/display_contracts.dart';

import '../../../../injection_container.dart';
import '../widgets/shimmer_contract_card.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({Key? key}) : super(key: key);

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  @override
  void initState() {
    controller.addListener(_listener);
    super.initState();
  }

  void _listener() {
    print(controller.text);
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IbillingBloc>(
      create: (context) => sl<IbillingBloc>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.8),
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              title: TextFormField(
                onFieldSubmitted: (val) {
                  if (controller.text.isNotEmpty) {
                    BlocProvider.of<IbillingBloc>(context)
                        .add(GetContractsByName(name: controller.text));
                  }
                },
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: Theme.of(context).textTheme.labelMedium,
                  border: InputBorder.none,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      controller.clear();
                    });
                  },
                  icon: const Icon(Icons.clear, color: Colors.white),
                )
              ],
            ),
            body: BlocBuilder<IbillingBloc, IbillingState>(
              builder: (context, state) {
                if (state is Loading) {
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return const ShimmerContractsCard();
                    },
                  );
                } else if (state is LoadedContractsByName) {
                  return DisplayContracts(contracts: state.contracts);
                }
                return Container();
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
