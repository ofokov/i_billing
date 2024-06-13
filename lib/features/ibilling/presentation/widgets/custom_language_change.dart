import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../generated/locale_keys.g.dart';
import '../constants/style/ibilling_icons.dart';

class CustomLanguageChange extends StatefulWidget {
  const CustomLanguageChange({super.key});

  @override
  State<CustomLanguageChange> createState() => _CustomLanguageChangeState();
}

const List<String> _languageOptions = [
  "O'zbek tili(Lotin)",
  "Русский язык",
  "English(USA)",
];

class _CustomLanguageChangeState extends State<CustomLanguageChange> {
  @override
  Widget build(BuildContext context) {
    // Determine the current language option based on the locale
    String currentOption = _getCurrentLanguageOption(context.locale);

    return GestureDetector(
      onTap: () {
        _showLanguageChangeDialog(context, currentOption);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getLanguageDisplayName(context.locale),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              SvgPicture.asset(
                _getLanguageFlagIcon(context.locale),
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to get the current language option
  String _getCurrentLanguageOption(Locale locale) {
    if (locale == const Locale('uz')) {
      return _languageOptions[0];
    } else if (locale == const Locale('ru')) {
      return _languageOptions[1];
    } else {
      return _languageOptions[2];
    }
  }

  // Function to get the display name of the language
  String _getLanguageDisplayName(Locale locale) {
    if (locale == const Locale('uz')) {
      return 'Uzbek (Lotin)';
    } else if (locale == const Locale('ru')) {
      return 'Русский';
    } else {
      return 'English (USA)';
    }
  }

  // Function to get the flag icon for the language
  String _getLanguageFlagIcon(Locale locale) {
    if (locale == const Locale('uz')) {
      return IBillingIcons.flagUzbek;
    } else if (locale == const Locale('ru')) {
      return IBillingIcons.flagRussian;
    } else {
      return IBillingIcons.flagUsa;
    }
  }

  // Function to show the language change dialog
  void _showLanguageChangeDialog(BuildContext context, String currentOption) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff2A2A2D),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 28,
                      left: 28,
                      right: 28,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Choose language",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 16),
                        _buildLanguageOption(
                          context,
                          IBillingIcons.flagUzbek,
                          "O'zbek tili(Lotin)",
                          _languageOptions[0],
                          currentOption,
                          (value) {
                            setState(() {
                              currentOption = value;
                            });
                          },
                        ),
                        _buildLanguageOption(
                          context,
                          IBillingIcons.flagRussian,
                          "Русский язык",
                          _languageOptions[1],
                          currentOption,
                          (value) {
                            setState(() {
                              currentOption = value;
                            });
                          },
                        ),
                        _buildLanguageOption(
                          context,
                          IBillingIcons.flagUsa,
                          "English(USA)",
                          _languageOptions[2],
                          currentOption,
                          (value) {
                            setState(() {
                              currentOption = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: _buildDialogButton(
                                context,
                                LocaleKeys.cancel.tr(),
                                const Color(0xff00A795).withOpacity(0.4),
                                () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildDialogButton(
                                context,
                                LocaleKeys.done.tr(),
                                const Color(0xff00A795),
                                () {
                                  _changeLanguage(context, currentOption);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Helper function to build language option widget
  Widget _buildLanguageOption(
    BuildContext context,
    String icon,
    String language,
    String value,
    String groupValue,
    ValueChanged<String> onChanged,
  ) {
    return Padding(
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
          SizedBox(
            width: 20,
            height: 20,
            child: Radio(
              activeColor: Color(0xFF00A795),
              value: value,
              groupValue: groupValue,
              onChanged: (Object? value) {
                onChanged(value.toString());
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build dialog button
  Widget _buildDialogButton(
    BuildContext context,
    String text,
    Color backgroundColor,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: text == "Cancel"
              ? const Color(0xff00A795).withOpacity(0.8)
              : Colors.white,
        ),
      ),
    );
  }

  // Function to change the language and close the dialog
  void _changeLanguage(BuildContext context, String currentOption) {
    int result = _languageOptions.indexOf(currentOption);
    setState(() {
      switch (result) {
        case 0:
          context.setLocale(const Locale('uz'));
          break;
        case 1:
          context.setLocale(const Locale('ru'));
          break;
        case 2:
          context.setLocale(const Locale('en'));
          break;
      }
    });
    Navigator.pop(context);
  }
}
