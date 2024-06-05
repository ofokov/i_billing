import 'package:flutter/material.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/style/ibilling_icons.dart';

class CustomDate extends StatefulWidget {
  const CustomDate({super.key});

  @override
  State<CustomDate> createState() => _CustomDateState();
}

class _CustomDateState extends State<CustomDate> {
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int dayToday = DateTime.now().day;
  List<int> res = [];
  int after = 7 -
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ).weekday;
  int before = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ).weekday -
      1;

  void _getWeek() {
    for (int i = before - 1; i >= 0; i--) {
      int date =
          DateTime(year, month, dayToday).subtract(Duration(days: i + 1)).day;
      //  print("${date}  : ${DateTime(year, month, dayToday).day}");
      res.add(date);
    }

    for (int i = 0; i <= after; i++) {
      int date = DateTime(year, month, dayToday).add(Duration(days: i)).day;
      //  print("${date}  : ${DateTime(year, month, dayToday).day}");
      res.add(date);
    }
  }

  void _previousWeek() {
    dayToday =
        DateTime(year, month, dayToday).subtract(const Duration(days: 7)).day;
    month = DateTime(year, month, dayToday)
            .subtract(const Duration(days: 7))
            .month -
        1;
    year =
        DateTime(year, month, dayToday).subtract(const Duration(days: 7)).year;
    res.clear();
    _getWeek();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'May, 2016',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(IBillingIcons.arrowLeftIos)),
                    VerticalDivider(
                      color: Theme.of(context).primaryColor,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(IBillingIcons.arrowRightIos))
                  ],
                )
              ],
            ),
            Row(
              children: [
                for (int i = 0; i < 6; i++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xFF00A795),
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Fr',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '28',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
