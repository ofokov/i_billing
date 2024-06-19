import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageOption extends StatelessWidget {
  final String icon;
  final String language;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;
  final String checkedIcon;
  final String uncheckedIcon;

  const LanguageOption({
    required this.icon,
    required this.language,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.checkedIcon,
    required this.uncheckedIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = value == groupValue;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            SvgPicture.asset(icon, width: 24, height: 24),
            const SizedBox(
                width: 8), // Add some spacing between the icon and the text
            Expanded(
              child:
                  Text(language, style: Theme.of(context).textTheme.bodyMedium),
            ),
            SvgPicture.asset(
              isSelected ? checkedIcon : uncheckedIcon,
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
