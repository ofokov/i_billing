import 'package:flutter/material.dart';

class CustomTextFromField extends StatefulWidget {
  final TextInputType? textInputType;
  final String name;
  final ValueChanged<String?>? onChanged;
  final int? maxLength;

  const CustomTextFromField({
    super.key,
    required this.name,
    this.onChanged,
    this.textInputType,
    this.maxLength,
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
          maxLength: widget.maxLength,
          cursorColor: Color(0xFF00A795),
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 3,
          minLines: 1,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
            counterText: '',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            isDense: true,
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
        const SizedBox(height: 16),
      ],
    );
  }
}
