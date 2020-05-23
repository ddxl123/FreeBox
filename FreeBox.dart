```

import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FreeBox extends StatefulWidget {
  FreeBox({
    @required this.drawerManager,
    @required this.width,
    @required this.height,
    this.floatDrawer = const <Widget>[],
  });
  final DrawerManager drawerManager;

  ///悬浮在 [FreeBox] 上的固定控件
  final List<Widget> floatDrawer;

  final double width;
  final double height;

  @override
  State<StatefulWidget> createState() {
    return _FreeBox();
  }
}

class _FreeBox extends State<FreeBox> {
  double _lastScale = 1;
  Offset _lastPosition = Offset.zero;

  Offset _endPosition;

  @override
  void initState() {
    super.initState();
    widget.drawerManager._rebuild = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: CustomPaint(
        painter: FreeBoxPainter(widget.drawerManager, widget.width, widget.height),
        child: Container(
          color: Colors.red,
          width: widget.width,
          height: widget.height,
          child: Stack(children: widget.floatDrawer),
        ),
        isComplex: true,
      ),
      onScaleStart: (ScaleStartDetails details) {
        _endPosition = details.localFocalPoint;
        scaleAndPositionStart(details);
        widget.drawerManager._isCanUseSelectSingleDrawer = true;
        setState(() {});
      },
      onScaleUpdate: (ScaleUpdateDetails details) {
        _endPosition = details.localFocalPoint;
        scaleAndPositionUpdate(details);
        widget.drawerManager._isCanUseSelectSingleDrawer = false;
        setState(() {});
      },
      onScaleEnd: (ScaleEndDetails details) {
        widget.drawerManager.useSelectedSingleDrawer(_endPosition);
        print("object");
        setState(() {});
      },
    );
  }

  void scaleAndPositionStart(ScaleStartDetails details) {
    _lastScale = 1;
    _lastPosition = details.localFocalPoint;
  }

  void scaleAndPositionUpdate(ScaleUpdateDetails details) {
    //在每次缩放的基础上缩放
    widget.drawerManager._scale *= (1 + (details.scale - _lastScale));
    //(当前位置-轴点)*缩放增量+轴点-上个位置，若是“=”而非“+=”,则会出现一个问题：在每次end后再start，轴点会瞬变
    widget.drawerManager._position += (widget.drawerManager.position - details.localFocalPoint) * (details.scale - _lastScale) + details.localFocalPoint - _lastPosition;

    _lastScale = details.scale;
    _lastPosition = details.localFocalPoint;
  }
}

///
///
///
///
///
class FreeBoxPainter extends CustomPainter {
  FreeBoxPainter(this.drawerManager, this.width, this.height);
  final DrawerManager drawerManager;
  final double width;
  final double height;
  Float64List float64list;
  @override
  void paint(Canvas canvas, Size size) {
    clipRect(canvas);
    translateAndScale(canvas);
    drawContent(canvas);
  }

  void clipRect(Canvas canvas) {
    final path = Path()
      ..addRect(
        Rect.fromPoints(Offset.zero, Offset(width, height)),
      );
    canvas.clipPath(path);
  }

  void translateAndScale(Canvas canvas) {
    //先平移后缩放,遵守准则：不让平移受缩放影响
    canvas.translate(drawerManager.position.dx, drawerManager.position.dy);
    canvas.scale(drawerManager.scale);
  }

  void drawContent(Canvas canvas) {
    drawerManager._drawers.forEach((SingleDrawer item) {
      //渲染背景
      canvas.drawRect(item.drawerRect, item.drawerPaint);
      //渲染文本
      item.textPainter.paint(canvas, item.drawerRect.topLeft);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

///
///
///
///
///
///流程:
///[addDrawer() → _drawers] → [rebuild() → repaint()]
class DrawerManager {
  ///整体位置
  ///初始化的(0,0)位置必须在局部的左上角，才能和 [touchPosition] 相匹配
  Offset _position = Offset.zero;
  Offset get position => _position;

  ///整体缩放
  double _scale = 1;
  double get scale => _scale;

  ///全部的 [SingleDrawer]
  List<SingleDrawer> _drawers = [];
  List<SingleDrawer> get drawers => _drawers;

  ///是否能执行选择
  ///当前被选择的 [SingleDrawer]
  bool _isCanUseSelectSingleDrawer = true;
  SingleDrawer _selectedSingleDrawer;
  SingleDrawer get selectedSingleDrawer => _selectedSingleDrawer;

  ///重新渲染，以备事件外部调用此模块函数时，可以被rebuild
  Function _rebuild;

  void addDrawer(Offset position, String text) => {_drawers.add(SingleDrawer(position, text)), _rebuild()};
  void useSelectedSingleDrawer(Offset touchPosition) {
    if (_isCanUseSelectSingleDrawer == false) return;

    ///上面的会覆盖掉下面的
    _selectedSingleDrawer?.initDrawerStyle();
    _selectedSingleDrawer = null;
    _drawers.forEach((item) {
      //先缩放后平移：不让平移受缩放影响
      Offset drTopLeft = item.drawerRect.topLeft * scale + position;
      Offset drBottomRight = Offset(item.drawerRect.width, item.drawerRect.height) * scale + drTopLeft;
      Rect dr = Rect.fromPoints(drTopLeft, drBottomRight);
      if (dr.contains(touchPosition)) {
        _selectedSingleDrawer = item;
      }
    });
    _selectedSingleDrawer?.resetDrawerStyle(color: Colors.yellow);
  }
}

///
///
///
///
///
class SingleDrawer {
  String text;
  TextPainter textPainter;
  Offset drawerPosition;
  Rect drawerRect;
  Paint drawerPaint;

  SingleDrawer(Offset pos, String txt) {
    this.drawerPosition = pos;
    //初始化文本
    this.text = txt;
    this.textPainter = TextPainter()
      ..textDirection = TextDirection.ltr
      ..text = TextSpan(text: txt)
      ..layout();
    //初始化背景：根据文本大小来判断背景大小
    this.drawerRect = Rect.fromPoints(pos, pos + Offset(textPainter.size.width, textPainter.size.height));
    this.drawerPaint = Paint()..color = Colors.green;
  }

  void initDrawerStyle() {
    this.drawerPaint = Paint()..color = Colors.green;
  }

  void resetDrawerStyle({Color color}) {
    this.drawerPaint = Paint()..color = color;
  }
}

```