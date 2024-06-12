import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_billing/features/ibilling/presentation/constants/style/ibilling_icons.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/calendar_day.dart';
import 'package:i_billing/generated/locale_keys.g.dart';

class CustomDate extends StatefulWidget {
  final void Function(DateTime) onDateSelected;

  const CustomDate({super.key, required this.onDateSelected});

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
      color: const Color(0xff1E1E20),
      child: Column(
        children: [
          _buildHeader(context),
          _buildCalendarDays(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${_getMonthName(today.month)}, ${today.year}",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: Colors
                    .transparent, // Use a transparent color to see the ripple effect on the SvgPicture
                child: InkWell(
                  borderRadius: BorderRadius.circular(
                      16), // Optional: to provide rounded corners to the tap area
                  child: SvgPicture.asset(
                    IBillingIcons.arrowLeft,
                    width: 32,
                    height: 32,
                  ),
                  onTap: _previousWeek,
                ),
              ),
              SizedBox(width: 16), // Adding some space between the buttons
              Material(
                color: Colors
                    .transparent, // Use a transparent color to see the ripple effect on the SvgPicture
                child: InkWell(
                  borderRadius: BorderRadius.circular(
                      16), // Optional: to provide rounded corners to the tap area
                  child: SvgPicture.asset(
                    IBillingIcons.arrowRight,
                    width: 32,
                    height: 32,
                  ),
                  onTap: _nextWeek,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarDays() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          for (int i = 0; i < weekDates.length - 1; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CalendarDay(
                  isSelected: selectedDate == weekDates[i],
                  isToday: _isToday(weekDates[i]),
                  weekName: _getWeekName(i),
                  day: "${weekDates[i].day}",
                  onTap: () {
                    setState(() {
                      selectedDate = weekDates[i];
                      widget.onDateSelected(selectedDate);
                    });
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  bool _isToday(DateTime date) {
    DateTime now = DateTime.now();
    return now.day == date.day &&
        now.month == date.month &&
        now.year == date.year;
  }
}
