import 'package:flutter/material.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/shimmer_loading.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/w_shimmer.dart';

class ShimmerContractsCard extends StatelessWidget {
  const ShimmerContractsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 343,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 11,
          horizontal: 12,
        ),
        child: Shimmer(
          linearGradient: shimmerGradient,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WShimmer(height: 20, width: 67),
                  WShimmer(height: 20, width: 50),
                ],
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WShimmer(height: 20, width: 150),
                  SizedBox(height: 4),
                  WShimmer(height: 20, width: 120),
                  SizedBox(height: 4),
                  WShimmer(height: 20, width: 160),
                  SizedBox(height: 4),
                  WShimmer(height: 20, width: 150),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WShimmer(height: 20, width: 100),
                  WShimmer(height: 20, width: 70),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
