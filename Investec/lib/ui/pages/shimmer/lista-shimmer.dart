import 'package:flutter/material.dart';

import 'lista-shimmer-item.dart';

class ShimmerList extends StatelessWidget {
  final int itemCount;

  const ShimmerList({Key key, this.itemCount = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return ShimmerListItem();
      },
    );
  }
}
