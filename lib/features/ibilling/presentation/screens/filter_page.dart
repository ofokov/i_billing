import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/locale_keys.g.dart';
import '../bloc/ibilling_bloc/ibilling_bloc.dart';
import '../widgets/custom_date_picker_button.dart';
import '../widgets/custom_filter_ticks.dart';

class FilterPage extends StatefulWidget {
  final int pageIndex;
  const FilterPage({super.key, required this.pageIndex});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  DateTime dateStart =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime dateEnd = DateTime.now().subtract(const Duration(minutes: 1));
  List<String> states = [];
  Map<String, bool> filterSelections = {
    'Paid': false,
    'In progress': false,
    'Rejected by Payme': false,
    'Rejected by IQ': false,
  };

  void _updateFilterSelection(String text) {
    setState(() {
      filterSelections[text] = !filterSelections[text]!;
      if (filterSelections[text]!) {
        states.add(text);
      } else {
        states.remove(text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color(0xff141416),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    size: 24,
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                LocaleKeys.filters.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 28,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.status.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFilterTicks(
                        text: 'Paid',
                        onPressed: () {},
                        isSelected: filterSelections['Paid']!,
                        onFilterChanged: _updateFilterSelection,
                      ),
                      CustomFilterTicks(
                        text: 'In progress',
                        onPressed: () {},
                        isSelected: filterSelections['In progress']!,
                        onFilterChanged: _updateFilterSelection,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFilterTicks(
                        text: 'Rejected by Payme',
                        onPressed: () {},
                        isSelected: filterSelections['Rejected by Payme']!,
                        onFilterChanged: _updateFilterSelection,
                      ),
                      CustomFilterTicks(
                        text: 'Rejected by IQ',
                        onPressed: () {},
                        isSelected: filterSelections['Rejected by IQ']!,
                        onFilterChanged: _updateFilterSelection,
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                LocaleKeys.date.tr(),
                style: Theme.of(context).textTheme.titleMedium,
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
                    maxDate: DateTime.now().add(const Duration(days: 1)),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xff00A795).withOpacity(0.4),
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                        ),
                        child: Text(
                          LocaleKeys.cancel.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        // In the FilterPage class, wrap the Navigator.pop in the onPressed callback of Apply Filters button
                        onPressed: () {
                          BlocProvider.of<IbillingBloc>(context).add(
                            GetFilteredListOfContract(
                              minDate: dateStart,
                              maxDate: dateEnd,
                              states: states,
                              filteredPage: widget.pageIndex,
                            ),
                          );
                          print(
                              "====================PAGE INDEX ${widget.pageIndex}");
                          Navigator.pop(context,
                              true); // Pass data back to indicate filters were applied
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
                          LocaleKeys.apply_filters.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
