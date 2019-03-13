import 'package:flutter/material.dart';

class empty_view extends StatelessWidget {
  var tital;

  var imagePath;

  empty_view(this.imagePath, this.tital);

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    print(topPadding);
    print(bottomPadding);
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Image.asset(
              imagePath,
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width / 2,
            ),
            Text(tital),
          ],
        ),
      ],
    );
  }
}
