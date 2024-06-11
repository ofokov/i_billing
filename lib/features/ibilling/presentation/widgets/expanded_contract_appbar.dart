import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../domain/enteties/contracts.dart';
import '../constants/style/ibilling_icons.dart';

class ExpandedContractAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Contract contract;
  final bool isSaved;
  final VoidCallback onSaveToggle;

  const ExpandedContractAppBar({
    super.key,
    required this.contract,
    required this.isSaved,
    required this.onSaveToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: onSaveToggle,
          icon: SvgPicture.asset(
            isSaved
                ? IBillingIcons.bookmarkFilled
                : IBillingIcons.bookmarkOutlined,
            width: 18,
            height: 20,
          ),
        )
      ],
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      title: Row(
        children: [
          Image.asset(IBillingIcons.vaucher, width: 17, height: 20),
          const SizedBox(width: 8),
          Text(
            "№ ${contract.lastInvoiceNumber}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
