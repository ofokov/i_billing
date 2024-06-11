import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_billing/features/ibilling/presentation/bloc/ibilling_bloc/ibilling_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/display_contracts.dart';
import 'package:i_billing/generated/locale_keys.g.dart';

import '../constants/formz_submission_status.dart';
import '../constants/style/ibilling_icons.dart';
import '../widgets/shimmer_contract_card.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  @override
  void initState() {
    BlocProvider.of<IbillingBloc>(context).add(const GetSavedListOfContracts());
    print('============ HELLO');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IbillingBloc, IbillingState>(
      builder: (context, state) {
        if (state.filteredPageIndex == 3 &&
            state.filterStatus == FormzSubmissionStatus.success) {
          if (state.filteredContracts.isNotEmpty) {
            return DisplayContracts(contracts: state.filteredContracts);
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    IBillingIcons.noData,
                    color: Theme.of(context).primaryColor,
                    semanticsLabel: LocaleKeys.no_saved_contracts.tr(),
                    height: 80,
                    width: 80,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    LocaleKeys.no_saved_contracts.tr(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            );
          }
        } else if (state.savedStatus == FormzSubmissionStatus.inProgress) {
          return ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return const ShimmerContractsCard();
            },
          );
        } else if (state.savedStatus == FormzSubmissionStatus.success) {
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<IbillingBloc>(context)
                  .add(const GetSavedListOfContracts());
            },
            child: (state.savedContracts.isNotEmpty)
                ? DisplayContracts(contracts: state.savedContracts)
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          color: Theme.of(context).primaryColor,
                          IBillingIcons.noData,
                          semanticsLabel: LocaleKeys.no_saved_contracts.tr(),
                          height: 80,
                          width: 80,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          LocaleKeys.no_saved_contracts.tr(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
          );
        }
        return Center(
          child: SvgPicture.asset(
            color: Theme.of(context).primaryColor,
            IBillingIcons.noData,
            semanticsLabel: LocaleKeys.no_saved_contracts.tr(),
            height: 80,
            width: 80,
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
