import 'package:flutter/material.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/shimmer_loading.dart';

class WShimmer extends StatelessWidget {
  final BorderRadius? borderRadius;
  final double height;
  final double width;

  const WShimmer(
      {super.key,
      required this.height,
      required this.width,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              borderRadius ?? const BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}
