import 'package:flutter/material.dart';

class CustomTextFromField extends StatefulWidget {
  final TextInputType? textInputType;
  final String name;
  final ValueChanged<String?>? onChanged;

  const CustomTextFromField({
    super.key,
    required this.name,
    this.onChanged,
    this.textInputType,
  });

  @override
  State<CustomTextFromField> createState() => _CustomTextFromFieldState();
}

class _CustomTextFromFieldState extends State<CustomTextFromField> {
  final OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(color: Color(0xff2A2A2D)),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 6),
        TextFormField(
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
            border: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
          ),
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
