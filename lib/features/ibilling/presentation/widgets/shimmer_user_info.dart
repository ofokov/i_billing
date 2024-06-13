import 'package:flutter/material.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/w_shimmer.dart';

import 'shimmer_loading.dart'; // Import the WShimmer widget

class ShimmerUserInfo extends StatelessWidget {
  const ShimmerUserInfo({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: const Shimmer(
        linearGradient: shimmerGradient,
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  WShimmer(
                    width: 40,
                    height: 40,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ), // Shimmer for the icon
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WShimmer(width: 100, height: 16), // Shimmer for the name
                      SizedBox(height: 8),
                      WShimmer(width: 80, height: 12), // Shimmer for the title
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      WShimmer(width: 120, height: 14), // Shimmer for first row
                      SizedBox(width: 4),
                      WShimmer(width: 100, height: 14), // Shimmer for first row
                    ],
                  ),
                  SizedBox(height: 15),
                  WShimmer(width: 200, height: 14), // Shimmer for second row
                  SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WShimmer(width: 50, height: 14),
                      SizedBox(width: 10),
                      WShimmer(width: 100, height: 14), // Shimmer for email
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
