//Flutter Package
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

//Dependencies Package
import 'package:hallodoc/utils/colors.dart';
import 'package:hallodoc/utils/screenutil.dart';

class MarBottomAppBarItem {
  MarBottomAppBarItem({this.iconData, this.text});
  IconData iconData;
  String text;
}

class MarBottomAppBar extends StatefulWidget {
  MarBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.notchedShape,
    this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<MarBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => MarBottomAppBarState();
}

class MarBottomAppBarState extends State<MarBottomAppBar> {
  int _selectedIndex = 0;
  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      allowFontScaling: true,
    )..init(context);
    
    List<Widget> items = List.generate(widget.items.length, (int index) {
      print(index.toString());
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildTabItem({
    MarBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: _selectedIndex == index ?
            ShaderMask(
              blendMode: BlendMode.srcIn, 
              shaderCallback: (Rect bounds) {
                return ui.Gradient.linear(
                  Offset(0.0, 40.0),
                  Offset(40.0, 0.0),
                  [
                    TemaApp.redColor,
                    Color(0xFF5C3B95),
                  ]
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(item.iconData, size: widget.iconSize),
                  SizedBox(height: 2.0),
                  Text(
                    item.text,
                    style: TextStyle(fontSize: ScreenUtil().setSp(30), fontFamily: 'Comfortaa'),
                  )
                ],
              )
            ) : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(item.iconData, color: color, size: widget.iconSize),
                  SizedBox(height: 2.0),
                  Text(
                    item.text,
                    style: TextStyle(color: color, fontFamily: 'Comfortaa', fontSize: ScreenUtil().setSp(30)),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}