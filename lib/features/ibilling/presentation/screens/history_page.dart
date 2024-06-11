import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_billing/features/ibilling/presentation/constants/formz_submission_status.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/custom_date_picker_button.dart';

import '../../../../generated/locale_keys.g.dart';
import '../bloc/ibilling_bloc/ibilling_bloc.dart';
import '../constants/style/ibilling_icons.dart';
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
              LocaleKeys.date.tr(),
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
                print(dateStart);
                print(dateEnd);
                BlocProvider.of<IbillingBloc>(context)
                    .add(GetListOfContractInDateRange(
                  minDate: dateStart,
                  maxDate: dateEnd,
                ));
              },
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor:
                    const Color(0xff00A795).withOpacity(0.4),
                backgroundColor: const Color(0xff00A795),
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
              ),
              child: Text(
                LocaleKeys.find.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<IbillingBloc, IbillingState>(
              builder: (context, state) {
                if (state.filteredPageIndex == 1 &&
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
                            semanticsLabel:
                                LocaleKeys.no_contracts_are_made.tr(),
                            height: 80,
                            width: 80,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            LocaleKeys.no_contracts_are_made.tr(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    );
                  }
                } else if (state.inDateRangeStatus ==
                    FormzSubmissionStatus.initial) {
                  return Center(
                    child: Text(LocaleKeys.no_contracts_are_made.tr()),
                  );
                } else if (state.inDateRangeStatus ==
                    FormzSubmissionStatus.inProgress) {
                  return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const ShimmerContractsCard();
                    },
                  );
                } else if (state.inDateRangeStatus ==
                    FormzSubmissionStatus.success) {
                  return (state.inDateRangeContracts.isNotEmpty)
                      ? DisplayContracts(contracts: state.inDateRangeContracts)
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                color: Theme.of(context).primaryColor,
                                IBillingIcons.noData,
                                semanticsLabel:
                                    LocaleKeys.no_history_for_this_period.tr(),
                                height: 80,
                                width: 80,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                LocaleKeys.no_history_for_this_period.tr(),
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
                        semanticsLabel:
                            LocaleKeys.no_history_for_this_period.tr(),
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        LocaleKeys.no_history_for_this_period.tr(),
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
