import 'package:flutter/material.dart';

class CustomDropdownButtonFormField extends StatefulWidget {
  final String name;
  final List<String> entityList;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownButtonFormField({
    super.key,
    required this.entityList,
    required this.name,
    this.onChanged,
  });

  @override
  State<CustomDropdownButtonFormField> createState() =>
      _CustomDropdownButtonFormFieldState();
}

class _CustomDropdownButtonFormFieldState
    extends State<CustomDropdownButtonFormField> {
  String? _selectedEntity;

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
        DropdownButtonFormField<String>(
          value: _selectedEntity,
          dropdownColor: const Color(0xff2A2A2D),
          decoration: InputDecoration(
            border: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
          ),
          items: widget.entityList
              .map((entity) => DropdownMenuItem<String>(
                    value: entity,
                    child: Text(entity),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() => _selectedEntity = value);
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

/*
import 'package:flutter/material.dart';

class CustomDropdownButtonFormField extends StatefulWidget {
  final String name;
  final List<String> entityList;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownButtonFormField({
    super.key,
    required this.entityList,
    required this.name,
    this.onChanged,
  });

  @override
  State<CustomDropdownButtonFormField> createState() =>
      _CustomDropdownButtonFormFieldState();
}

class _CustomDropdownButtonFormFieldState
    extends State<CustomDropdownButtonFormField> {
  String? _selectedEntity;

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
        DropdownButtonFormField<String>(
          value: _selectedEntity,
          dropdownColor: const Color(0xff2A2A2D),
          decoration: InputDecoration(
            border: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
          ),
          items: widget.entityList
              .map((entity) => DropdownMenuItem<String>(
                    value: entity,
                    child: Text(entity),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() => _selectedEntity = value);
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
*/
