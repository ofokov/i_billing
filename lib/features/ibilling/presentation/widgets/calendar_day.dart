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
    Color selectionColor = (widget.isSelected)
        ? Colors.white
        : (widget.isToday)
            ? const Color(0xFF00A795)
            : Colors.grey;
    Color backgroundColor =
        widget.isSelected ? const Color(0xFF00A795) : const Color(0xff1E1E20);

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(9)),
        ),
        child: Column(
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 150),
              style: TextStyle(
                color: widget.isSelected
                    ? Colors.white
                    : widget.isToday
                        ? const Color(0xFF00A795)
                        : Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              child: Text(widget.weekName),
            ),
            const SizedBox(height: 7),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 150),
              style: TextStyle(
                color: widget.isSelected
                    ? Colors.white
                    : widget.isToday
                        ? const Color(0xFF00A795)
                        : Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              child: Text(widget.day),
            ),
            SizedBox(
              width: 14,
              child: Divider(
                color: selectionColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
