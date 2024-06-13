import 'package:flutter/material.dart';

class TabBarBottom extends StatefulWidget {
  final List<Widget> pages;
  final TabController tabController;
  const TabBarBottom({
    super.key,
    required this.pages,
    required this.tabController,
  });

  @override
  State<TabBarBottom> createState() => _TabBarBottomState();
}

class _TabBarBottomState extends State<TabBarBottom> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      children: widget.pages,
    );
  }
}
