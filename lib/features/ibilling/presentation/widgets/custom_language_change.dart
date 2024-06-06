import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/style/ibilling_icons.dart';

class CustomLanguageChange extends StatefulWidget {
  const CustomLanguageChange({Key? key}) : super(key: key);

  @override
  State<CustomLanguageChange> createState() => _CustomLanguageChangeState();
}

const List<String> _groupValue = [
  "O'zbek tili(Lotin)",
  "Русский язык",
  "English(USA)",
];

class _CustomLanguageChangeState extends State<CustomLanguageChange> {
  @override
  Widget build(BuildContext context) {
    String currentOption = (context.locale == Locale('uz'))
        ? _groupValue[0]
        : (context.locale == Locale('ru'))
            ? _groupValue[1]
            : _groupValue[2];
    return GestureDetector(
      onTap: () {
        _showLanguageChange(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (context.locale == Locale('uz'))
                    ? 'Uzbek (Lotin)'
                    : (context.locale == Locale('ru')
                        ? 'Русский'
                        : 'English (USA)'),
                style: TextStyle(
                  color: Colors.white,
                  height: 2.3,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              SvgPicture.asset(
                (context.locale == Locale('uz'))
                    ? IBillingIcons.flagUzbek
                    : (context.locale == Locale('ru')
                        ? IBillingIcons.flagRussian
                        : IBillingIcons.flagUsa),
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageChange(BuildContext context) {
    String currentOption = (context.locale == Locale('uz'))
        ? _groupValue[0]
        : (context.locale == Locale('ru'))
            ? _groupValue[1]
            : _groupValue[2];
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff2A2A2D),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 28,
                    top: 16,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Text(
                          "Choose language",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: 28),
                        ListTile(
                          leading: SvgPicture.asset(
                            IBillingIcons.flagUzbek,
                            width: 24,
                            height: 24,
                          ),
                          title: Text(
                            "O'zbek tili(Lotin)",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: Radio(
                            value: _groupValue[0],
                            groupValue: currentOption,
                            onChanged: (Object? value) {
                              setState(() {
                                currentOption = value.toString();
                                context.setLocale(const Locale('uz'));
                              });
                            },
                          ),
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                            IBillingIcons.flagRussian,
                            width: 24,
                            height: 24,
                          ),
                          title: Text(
                            "Русский язык",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: Radio(
                            value: _groupValue[1],
                            groupValue: currentOption,
                            onChanged: (Object? value) {
                              setState(() {
                                currentOption = value.toString();
                                context.setLocale(const Locale('ru'));
                              });
                            },
                          ),
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                            IBillingIcons.flagUsa,
                            width: 24,
                            height: 24,
                          ),
                          title: Text(
                            "English(USA)",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: Radio(
                            value: _groupValue[2],
                            groupValue: currentOption,
                            onChanged: (Object? value) {
                              setState(() {
                                currentOption = value.toString();
                                context.setLocale(const Locale('en'));
                              });
                            },
                          ),
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
}
