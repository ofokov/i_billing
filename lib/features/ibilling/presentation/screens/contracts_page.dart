import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_billing/features/ibilling/presentation/constants/formz_submission_status.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/custom_date.dart';

import '../../../../generated/locale_keys.g.dart';
import '../bloc/ibilling_bloc/ibilling_bloc.dart';
import '../constants/style/ibilling_icons.dart';
import '../widgets/display_contracts.dart';
import '../widgets/shimmer_contract_card.dart';

class ContractsPage extends StatefulWidget {
  const ContractsPage({super.key});

  @override
  State<ContractsPage> createState() => _ContractsPageState();
}

class _ContractsPageState extends State<ContractsPage>
    with TickerProviderStateMixin {
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
    TabController tabController = TabController(length: 2, vsync: this);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDate(onDateSelected: _onDateSelected),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    top: 32,
                  ),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    tabAlignment: TabAlignment.center,
                    indicatorSize: TabBarIndicatorSize.tab,
                    isScrollable: true,
                    indicator: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xff00A795),
                    ),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                    labelColor: Colors.white,
                    controller: tabController,
                    tabs: [
                      Container(
                        height: 36, // Adjust this height as needed
                        alignment: Alignment.center,
                        child: const Text("Contracts"),
                      ),
                      Container(
                        height: 36, // Adjust this height as needed
                        alignment: Alignment.center,
                        child: const Text("Invoices"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      BlocBuilder<IbillingBloc, IbillingState>(
                        builder: (context, state) {
                          if (state.filteredPageIndex == 0 &&
                              state.filterStatus ==
                                  FormzSubmissionStatus.success) {
                            if (state.filteredContracts.isNotEmpty) {
                              return DisplayContracts(
                                  contracts: state.filteredContracts);
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ],
                                ),
                              );
                            }
                          } else if (state.inSpecificStatus ==
                              FormzSubmissionStatus.inProgress) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return const ShimmerContractsCard();
                              },
                            );
                          } else if (state.inSpecificStatus ==
                              FormzSubmissionStatus.success) {
                            if (state.inSpecificDateContract.isNotEmpty) {
                              return DisplayContracts(
                                  contracts: state.inSpecificDateContract);
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ],
                                ),
                              );
                            }
                          } else if (state.inSpecificStatus ==
                              FormzSubmissionStatus.failure) {
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
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                      Center(
                        child: Text("EMPTY"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
