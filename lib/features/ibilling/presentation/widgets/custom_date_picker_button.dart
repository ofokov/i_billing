import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/style/ibilling_icons.dart';

class CustomDatePickerButton extends StatelessWidget {
  final String text;
  final DateTime initialDate;
  final void Function(DateTime) onChanged;
  final DateTime? minDate;
  final DateTime? maxDate;

  const CustomDatePickerButton({
    Key? key,
    required this.text,
    required this.onChanged,
    this.minDate,
    this.maxDate,
    required this.initialDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      onPressed: () async {
        if (Platform.isIOS) {
          await showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return SizedBox(
                height: 250,
                child: CupertinoDatePicker(
                  initialDateTime: initialDate,
                  minimumDate: minDate,
                  maximumDate: maxDate,
                  mode: CupertinoDatePickerMode.date,
                  dateOrder: DatePickerDateOrder.dmy,
                  use24hFormat: true,
                  backgroundColor: Colors.white,
                  onDateTimeChanged: onChanged,
                ),
              );
            },
          );
        } else {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: minDate ?? DateTime(1900),
            lastDate: maxDate ?? DateTime(2100),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: Theme.of(context),
                child: child!,
              );
            },
          );
          if (picked != null && picked != initialDate) {
            onChanged(picked);
          }
        }
      },
      child: Row(
        children: [
          Text(text),
          const SizedBox(width: 8),
          SvgPicture.asset(
            IBillingIcons.calendar,
            semanticsLabel: 'Calendar Icon',
            height: 14,
            width: 14,
          ),
        ],
      ),
    );
  }
}
