import 'dart:convert';

import 'package:flutter/material.dart';

class SingleNode extends StatefulWidget {
  SingleNode({
    Key key,
    @required this.fragmentPoolDateList,
    @required this.fragmentPoolDateMap,
    @required this.index,
  }) : super(key: key);

  final List<Map<dynamic, dynamic>> fragmentPoolDateList;
  final Map<String, dynamic> fragmentPoolDateMap;
  final int index;

  @override
  SingleNodeState createState() => SingleNodeState();
}

class SingleNodeState extends State<SingleNode> {
  /// 获取 [布局大小]
  void reGetLayoutSize() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Map<dynamic, dynamic> listItem = widget.fragmentPoolDateList[widget.index];
      widget.fragmentPoolDateMap[listItem["route"]]["this"] = this;

      /// 获取 [布局大小]
      Size size = (this.context.findRenderObject() as RenderBox).size;
      widget.fragmentPoolDateMap[listItem["route"]]["layout_width"] = size.width;
      widget.fragmentPoolDateMap[listItem["route"]]["layout_height"] = size.height;
    });
  }

  @override
  void initState() {
    super.initState();
    reGetLayoutSize();
  }

  @override
  void didUpdateWidget(SingleNode oldWidget) {
    super.didUpdateWidget(oldWidget);
    reGetLayoutSize();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.fragmentPoolDateMap[widget.fragmentPoolDateList[widget.index]["route"]]["layout_left"] ?? 0.0,
      top: widget.fragmentPoolDateMap[widget.fragmentPoolDateList[widget.index]["route"]]["layout_top"] ?? 0.0,
      child: Container(
        color: Colors.yellow,
        child: FlatButton(
          onPressed: () {
            setState(() {});
          },
          child: Text(widget.fragmentPoolDateList[widget.index]["out_display_name"]),
        ),
      ),
    );
  }
}
