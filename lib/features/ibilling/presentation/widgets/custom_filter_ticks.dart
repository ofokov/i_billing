import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'style/ibilling_icons.dart';

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
    return TextButton.icon(
      onPressed: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
        widget.onFilterChanged(widget.text);
      },
      icon: SvgPicture.asset(
        (widget.isSelected)
            ? IBillingIcons.tickSquareFilled
            : IBillingIcons.tickSquareOutlined,
        semanticsLabel: 'No data',
        height: 20,
        width: 20,
      ),
      label: Text(
        widget.text,
        style: (widget.isSelected)
            ? Theme.of(context).textTheme.bodyMedium
            : Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
