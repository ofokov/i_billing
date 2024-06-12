import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WShimmer extends StatelessWidget {
  final double height;
  final double width;

  const WShimmer({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(0xFF3A3A3D),
      highlightColor: Color(0xFF5A5A5D),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}
