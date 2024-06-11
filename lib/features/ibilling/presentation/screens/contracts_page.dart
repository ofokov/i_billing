import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../domain/enteties/contracts.dart';
import '../bloc/ibilling_bloc/ibilling_bloc.dart';
import '../constants/formz_submission_status.dart';
import '../constants/style/ibilling_icons.dart';
import '../widgets/contracts_card.dart';
import '../widgets/custom_date.dart';
import '../widgets/shimmer_contract_card.dart';

class ContractsPage extends StatefulWidget {
  const ContractsPage({Key? key}) : super(key: key);

  @override
  State<ContractsPage> createState() => _ContractsPageState();
}

class _ContractsPageState extends State<ContractsPage> {
  DateTime selectedDate = DateTime.now();
  List<bool> isSelected = [true, false];

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
    return Column(
      children: [
        CustomDate(onDateSelected: _onDateSelected),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildToggleButtons(),
                  BlocBuilder<IbillingBloc, IbillingState>(
                    builder: (context, state) {
                      return _buildContractDisplay(state);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          _buildToggleButton(0, 'Contracts'),
          _buildToggleButton(1, 'Invoice'),
        ],
      ),
    );
  }

  Widget _buildToggleButton(int index, String text) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isSelected = List.generate(isSelected.length, (i) => i == index);
        });
      },
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        foregroundColor: Colors.white,
        backgroundColor:
            isSelected[index] ? const Color(0xff00A795) : Colors.transparent,
      ),
      child: Text(text),
    );
  }

  Widget _buildContractDisplay(IbillingState state) {
    if (state.filterStatus == FormzSubmissionStatus.success) {
      if (state.filteredContracts.isNotEmpty) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.filteredContracts.length,
          itemBuilder: (context, index) {
            final Contract contract = state.filteredContracts[index];
            return ContractsCard(contract: contract);
          },
        );
      } else {
        return _buildNoDataWidget();
      }
    } else if (state.inSpecificStatus == FormzSubmissionStatus.inProgress) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) => const ShimmerContractsCard(),
      );
    } else if (state.inSpecificStatus == FormzSubmissionStatus.success) {
      if (state.inSpecificDateContract.isNotEmpty) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.inSpecificDateContract.length,
          itemBuilder: (context, index) {
            final Contract contract = state.inSpecificDateContract[index];
            return ContractsCard(contract: contract);
          },
        );
      } else {
        return _buildNoDataWidget();
      }
    } else {
      return _buildNoDataWidget();
    }
  }

  Widget _buildNoDataWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            IBillingIcons.noData,
            color: Theme.of(context).primaryColor,
            semanticsLabel: LocaleKeys.no_contracts_are_made.tr(),
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
}
