import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/bloc/ibilling_bloc/ibilling_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/constants/formz_submission_status.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/display_contracts.dart';

import '../../../../generated/locale_keys.g.dart';
import '../widgets/shimmer_contract_card.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({super.key});

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
    setState(() {
      print(controller.text);
    });
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.95),
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
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          autofocus: true,
          onChanged: (val) {
            if (controller.text.isNotEmpty) {
              BlocProvider.of<IbillingBloc>(context)
                  .add(GetContractsByName(name: controller.text));
            }
          },
          controller: controller,
          decoration: InputDecoration(
            hintText: LocaleKeys.search_by_keywords.tr(),
            hintStyle: Theme.of(context).textTheme.labelMedium,
            border: InputBorder.none,
          ),
        ),
        actions: (controller.text.isNotEmpty)
            ? [
                IconButton(
                  onPressed: () {
                    setState(() {
                      controller.clear();
                    });
                  },
                  icon: const Icon(Icons.clear, color: Colors.white),
                )
              ]
            : null,
      ),
      body: BlocBuilder<IbillingBloc, IbillingState>(
        builder: (context, state) {
          if (state.searchedStatus == FormzSubmissionStatus.inProgress) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const ShimmerContractsCard();
                },
              ),
            );
          } else if (state.searchedStatus == FormzSubmissionStatus.success) {
            print(state.searchedContracts);
            print(state.inSpecificDateContract);
            return Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                child: DisplayContracts(
                  contracts: state.searchedContracts,
                ));
          }
          return Container();
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
