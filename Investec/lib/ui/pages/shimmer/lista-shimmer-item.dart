import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListItem extends StatelessWidget {
  const ShimmerListItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: ListTile(
        title: SizedBox(
          width: 50,
          height: 15,
          child: Shimmer.fromColors(
            child: Card(
              color: Colors.grey[100],
            ),
            baseColor: Colors.white70,
            highlightColor: Colors.grey[300],
            direction: ShimmerDirection.ltr,
          ),
        ),
        subtitle: SizedBox(
          width: 50,
          height: 80,
          child: Shimmer.fromColors(
            child: Card(
              color: Colors.grey[100],
            ),
            baseColor: Colors.white70,
            highlightColor: Colors.grey[300],
            direction: ShimmerDirection.ltr,
          ),
        ),
        trailing: SizedBox(
          width: 40,
          height: 40,
          child: Shimmer.fromColors(
            child: Card(
              color: Colors.grey[100],
            ),
            baseColor: Colors.white70,
            highlightColor: Colors.grey[300],
            direction: ShimmerDirection.ltr,
          ),
        ),
      ),
    );
  }
}
