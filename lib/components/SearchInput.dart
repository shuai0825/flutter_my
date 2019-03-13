import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 40.0,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(4.0)),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding:
                EdgeInsetsDirectional.only(start: 10.0, top: 3.0, end: 10.0),
            child: new Icon(
              Icons.search,
              size: 24.0,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialSearchInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MaterialSearchInputState();
  }
}

class _MaterialSearchInputState extends State<MaterialSearchInput> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
