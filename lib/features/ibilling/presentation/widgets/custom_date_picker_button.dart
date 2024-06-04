import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/style/ibilling_icons.dart';

class CustomDatePickerButton extends StatelessWidget {
  final String text;
  final DateTime initialDate;
  final void Function(DateTime) onChanged;
  final DateTime? minDate;
  final DateTime? maxDate;

  const CustomDatePickerButton({
    super.key,
    required this.text,
    required this.onChanged,
    this.minDate,
    this.maxDate,
    required this.initialDate,
  });

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
            });
      },
      child: Row(
        children: [
          Text(text),
          Image.asset(IBillingIcons.paper, width: 20, height: 20)
        ],
      ),
    );
  }
}
