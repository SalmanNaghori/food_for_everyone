import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonShimmerEffect extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const SkeletonShimmerEffect({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      effect: const ShimmerEffect(),
      child: child,
    );
  }
}