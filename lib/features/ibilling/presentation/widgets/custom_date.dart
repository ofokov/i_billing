import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/bloc/ibilling_bloc/ibilling_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/calendar_day.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/style/ibilling_icons.dart';
import 'package:i_billing/generated/locale_keys.g.dart';

class CustomDate extends StatefulWidget {
  const CustomDate({super.key});

  @override
  State<CustomDate> createState() => _CustomDateState();
}

class _CustomDateState extends State<CustomDate> {
  DateTime today = DateTime.now();
  DateTime selectedDate = DateTime.now();
  List<DateTime> weekDates = [];

  @override
  void initState() {
    super.initState();
    weekDates = _getWeek();
  }

  List<DateTime> _getWeek() {
    List<DateTime> result = [];
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));

    for (int i = 0; i < 7; i++) {
      result.add(startOfWeek.add(Duration(days: i)));
    }
    return result;
  }

  void _previousWeek() {
    setState(() {
      today = today.subtract(const Duration(days: 7));
      weekDates = _getWeek();
    });
  }

  void _nextWeek() {
    setState(() {
      today = today.add(const Duration(days: 7));
      weekDates = _getWeek();
    });
  }

  String _getWeekName(int index) {
    switch (index) {
      case 0:
        return LocaleKeys.mo.tr();
      case 1:
        return LocaleKeys.tu.tr();
      case 2:
        return LocaleKeys.we.tr();
      case 3:
        return LocaleKeys.th.tr();
      case 4:
        return LocaleKeys.fr.tr();
      case 5:
        return LocaleKeys.sa.tr();
      default:
        return LocaleKeys.mo.tr();
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return LocaleKeys.january.tr();
      case 2:
        return LocaleKeys.february.tr();
      case 3:
        return LocaleKeys.march.tr();
      case 4:
        return LocaleKeys.april.tr();
      case 5:
        return LocaleKeys.may.tr();
      case 6:
        return LocaleKeys.june.tr();
      case 7:
        return LocaleKeys.july.tr();
      case 8:
        return LocaleKeys.august.tr();
      case 9:
        return LocaleKeys.september.tr();
      case 10:
        return LocaleKeys.october.tr();
      case 11:
        return LocaleKeys.november.tr();
      case 12:
        return LocaleKeys.december.tr();
      default:
        return LocaleKeys.january.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            _buildHeader(context),
            _buildCalendarDays(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${_getMonthName(today.month)}, ${today.year}",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Row(
          children: [
            IconButton(
              onPressed: _previousWeek,
              icon: Image.asset(IBillingIcons.arrowLeftIos),
            ),
            VerticalDivider(
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: _nextWeek,
              icon: Image.asset(IBillingIcons.arrowRightIos),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarDays() {
    return Row(
      children: [
        for (int i = 0; i < weekDates.length - 1; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 2.0,
                vertical: 10,
              ),
              child: CalendarDay(
                isSelected: selectedDate == weekDates[i],
                isToday: _isToday(weekDates[i]),
                weekName: _getWeekName(i),
                day: "${weekDates[i].day}",
                onTap: () {
                  setState(() {
                    selectedDate = weekDates[i];
                    print(selectedDate);
                    BlocProvider.of<IbillingBloc>(context)
                        .add(GetListOfContractInDate(dateTime: selectedDate));
                  });
                },
              ),
            ),
          ),
      ],
    );
  }

  bool _isToday(DateTime date) {
    DateTime now = DateTime.now();
    return now.day == date.day &&
        now.month == date.month &&
        now.year == date.year;
  }
}
