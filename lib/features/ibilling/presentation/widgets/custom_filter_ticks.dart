import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/style/ibilling_icons.dart';

class CustomFilterTicks extends StatefulWidget {
  final void Function() onPressed;
  final void Function(String) onFilterChanged;
  bool isSelected;
  final String text;
  CustomFilterTicks({
    super.key,
    this.isSelected = false,
    required this.text,
    required this.onPressed,
    required this.onFilterChanged,
  });

  @override
  State<CustomFilterTicks> createState() => _CustomFilterTicksState();
}

class _CustomFilterTicksState extends State<CustomFilterTicks> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
        widget.onFilterChanged(widget.text);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SvgPicture.asset(
              (widget.isSelected)
                  ? IBillingIcons.tickSquareFilled
                  : IBillingIcons.tickSquareOutlined,
              semanticsLabel: 'No data',
              height: 20,
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              child: Text(
                widget.text,
                style: (widget.isSelected)
                    ? const TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )
                    : const TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffA6A6A6),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
