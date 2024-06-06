import 'package:flutter/material.dart';

class CalendarDay extends StatefulWidget {
  final void Function() onTap;
  final String weekName;
  final String day;
  final bool isSelected;
  final bool isToday;

  const CalendarDay({
    super.key,
    required this.weekName,
    required this.day,
    required this.isSelected,
    required this.isToday,
    required this.onTap,
  });

  @override
  State<CalendarDay> createState() => _CalendarDayState();
}

class _CalendarDayState extends State<CalendarDay> {
  @override
  Widget build(BuildContext context) {
    Color selectionColor =
        (widget.isSelected || widget.isToday) ? Colors.white : Colors.grey;
    Color backgroundColor = widget.isToday
        ? const Color(0xFF00A795)
        : Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(9)),
          border: Border.all(
            color: widget.isSelected
                ? const Color(0xFF00A795)
                : Theme.of(context).primaryColor,
          ),
        ),
        child: Column(
          children: [
            Text(
              widget.weekName,
              style: TextStyle(
                color: selectionColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.day,
              style: TextStyle(
                color: selectionColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            Divider(
              color: selectionColor,
            ),
          ],
        ),
      ),
    );
  }
}
