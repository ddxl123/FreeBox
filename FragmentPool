import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jysp/FreeBox.dart';
import 'package:jysp/SingleNode.dart';

class FragmentPool extends StatefulWidget {
  @override
  _FragmentPoolState createState() => _FragmentPoolState();
}

class _FragmentPoolState extends State<FragmentPool> {
  List<Map<dynamic, dynamic>> fragmentPoolDateList = [];
  Map<String, Map<dynamic, dynamic>> fragmentPoolDateMap = {};
  Map<String, int> tailMap = {};
  Function initFreeBoxPosition;

  @override
  void initState() {
    super.initState();
    fragmentPoolDateList = [
      {
        "route": "0",
        "type": 0,
        "out_display_name": "root",
      },
      {
        "route": "0-0",
        "type": 1,
        "out_display_name": "热污染3人安抚43热污染3人安抚433给热污染3人安抚433给 0-0",
      },
      {
        "route": "0-1",
        "type": 1,
        "out_display_name": "热污\n染3\n人安\n抚43\n3给热\n污\n染\n\热\n污\n染\n\热\n污\n染\n\热\n污\n染\n\n\n3人安抚\n\n433给热\n污\n染3人安抚433给热污\n染3人安抚4\n33给 0-1",
      },
      {
        "route": "0-2",
        "type": 1,
        "out_display_name": "热污染3人安抚3给 0-2",
      },
      {
        "route": "0-0-0",
        "type": 1,
        "out_display_name": "热污染3人安抚433给热污染3人安抚433给热污\n染3人安抚433安抚433给 0-0-0",
      },
      {
        "route": "0-0-0-0",
        "type": 1,
        "out_display_name": "热污染3给 0-0-0-0",
      },
      {
        "route": "0-0-0-1",
        "type": 1,
        "out_display_name": "热污染给热污染3人安抚433给热污染3人安抚433给 0-0-0-1",
      },
      {
        "route": "0-0-1",
        "type": 1,
        "out_display_name": "热污染3人安抚433给热污染3人安抚433给热污染3人安抚433给 0-0-1",
      },
      {
        "route": "0-0-1-0",
        "type": 1,
        "out_display_name": "热污染3人\n染3人安抚433给热污染3人安抚\n433给热\n污染3人安抚433给 0-0-1-0",
      },
      {
        "route": "0-0-1-1",
        "type": 1,
        "out_display_name": "热污染3人安抚433给热污染33给 0-0-1-1",
      },
      {
        "route": "0-0-1-2",
        "type": 1,
        "out_display_name": " 0-0-1-2",
      },
      {
        "route": "0-0-2",
        "type": 2,
        "out_display_name": "433给热污染3人安抚433给 0-0-2",
      },
      {
        "route": "0-1-0",
        "type": 2,
        "out_display_name": "热污\n染3抚433\n给 0-1-0",
      },
      {
        "route": "0-1-1",
        "type": 2,
        "out_display_name": "热0-1-0",
      },
      {
        "route": "0-1-0-0",
        "type": 2,
        "out_display_name": "热污染3人安抚433给热污污\n安抚433给 0-1-0",
      },
      {
        "route": "0-1-0-1",
        "type": 2,
        "out_display_name": "热污染3人安污\n安抚433给 0-1-0",
      },
      {
        "route": "0-1-0-2",
        "type": 2,
        "out_display_name": "热给 0-1-0",
      },
      {
        "route": "0-2-0",
        "type": 2,
        "out_display_name": "热污染3人安抚433给热污染3人安抚433染3人安抚433给 0-2-0",
      },
      {
        "route": "0-2-1",
        "type": 2,
        "out_display_name": "热污染3人安抚43热污\n染3人安抚433给热污染3人安抚433给热污染3人安抚433给 0-2-1",
      },
      {
        "route": "0-2-2",
        "type": 2,
        "out_display_name": "热污染3人安抚433给热污染3人安抚433给热污\n染3人安抚433给热污染3人安抚433给热污染3人安抚433给 0-2-2",
      },
    ];
  }

  /// 第一帧：获取全部layout_size
  /// 第二帧：
  /// 1、获取全部 tail_route 的 map
  /// 2、从 tail_route 依次向左迭代获取 container_height 和 container_left:
  /// container_height:
  ///   当前层级的 container_height 指的是当前层级的每个 route 的 container_height 相加,再加上 container 间被夹持的 height_space ,不包含非被夹持的最底下的 height_space;
  ///   tail_route 的 container_height 值为自身的 layout_height;
  ///   若当前层级的 container_height 大于父级的 layout_height ,则父级的 container_height 值为当前层级的 container_height ,并计算父级的 offset_top;
  ///   若当前层级的 container_height 小于父级的 layout_height ,则父级的 container_height 值为父级自身的 layout_height ,并计算子级的 offset_top;
  /// container_left:靠左，非靠右
  /// 3、设置全部 route 的 container_top:
  ///   container_top 指的是当前 route 上方的全部 route 的 container_height 相加,再加上 container 间被夹持的 height_space ,再加上自身的 offset_top,不包含非被夹持的最底下的 height_space;
  List<Widget> childrenWidget() {
    return <Widget>[
      for (int childrenIndex = 0; childrenIndex < fragmentPoolDateList.length + 1; childrenIndex++)
        if (childrenIndex != fragmentPoolDateList.length)
          SingleNode(
            fragmentPoolDateList: fragmentPoolDateList,
            index: childrenIndex,
            fragmentPoolDateMap: (() {
              if (fragmentPoolDateMap[fragmentPoolDateList[childrenIndex]["route"]] == null) {
                fragmentPoolDateMap[fragmentPoolDateList[childrenIndex]["route"]] = {
                  "index": childrenIndex,
                  "this": null,
                  "layout_height": 0.0,
                  "layout_width": 0.0,
                  "layout_left": 0.0,
                  "layout_top": 0.0,
                  "container_height": 0.0,
                  "vertical_center_offset": 0.0,
                };
              } else {
                /// 当这一帧被渲染时，SingleNode 应保留上一帧对应的 layout_left,layout_top,layout_width,layout_height
                /// 这里改变了 index ,但是并没有改变 route 对应的 子map
                fragmentPoolDateMap[fragmentPoolDateList[childrenIndex]["route"]]["index"] = childrenIndex;
              }
              return fragmentPoolDateMap;
            })(),
          )
        else
          EndIndex(
            s: () {
              setState(() {});
            },
            frameCallback: () {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                /// 清空
                tailMap.clear(); //必须清空,防止被残留的 key 干扰
                /// TODO: 注意在对 fragmentPoolDateList 进行 curd 时,一定要 curd对应的 fragmentPoolDateMap ,否则会被残留的 key 干扰

                /// 1、获取全部 tail_route 的 map ,并初始化 fragmentPoolDateMap 的值
                fragmentPoolDateMap.forEach((key, value) {
                  // fragmentPoolDateMap[key]["this"] = null;// 不能被重置,已被上一帧获取
                  // fragmentPoolDateMap[key]["layout_height"] = 0.0;// 不能置为0.0,已被上一帧获取
                  // fragmentPoolDateMap[key]["layout_width"] = 0.0;// 不能置为0.0,已被上一帧获取
                  // fragmentPoolDateMap[key]["layout_left"] = 0.0;// 可以置为0.0,下面还是会被重置
                  // fragmentPoolDateMap[key]["layout_top"] = 0.0;// 可以置为0.0,下面还是会被重置
                  fragmentPoolDateMap[key]["container_height"] = fragmentPoolDateMap[key]["layout_height"]; // 必须重置,因为下面并没有重新获取 tail ,若尾部 layout_height 发生变化,则会发生错误结果
                  // fragmentPoolDateMap[key]["vertical_center_offset"] = 0.0;// 可以置为0.0,下面还是会被重置

                  /// 获取 tail_route
                  if (!fragmentPoolDateMap.containsKey(key + "-0")) {
                    tailMap[key] = value["index"];
                  }
                });

                /// 2、从 tail_route 开始,依次向左迭代获取 container_height
                double heightSpace = 40.0;
                double widthSpace = 80.0;

                tailMap.forEach((key, value) {
                  /// 向左传递,逐渐减
                  for (int partIndex = key.length ~/ 2; partIndex >= 0; partIndex--) {
                    String partRoute = key.substring(0, partIndex * 2 + 1);

                    /// 既然从尾部开始，那么就不处理"0"
                    if (partRoute != "0") {
                      String fatherRoute = partRoute.substring(0, partRoute.length - 2);
                      double childrenContainerHeight = 0.0 - heightSpace; // 减去 height_space 是因为 container_height 不包含最底下的 height_space

                      /// 迭代同层级的 route
                      for (int incIndex = 0; incIndex < fragmentPoolDateMap.length; incIndex++) {
                        String incRoute = fatherRoute + "-$incIndex";
                        childrenContainerHeight += fragmentPoolDateMap[incRoute]["container_height"] + heightSpace; // 需要加上 heightSpace
                        if (fragmentPoolDateMap.containsKey(fatherRoute + "-${incIndex + 1}") == false) {
                          break;
                        }
                      }

                      /// 比较并赋值
                      fragmentPoolDateMap[fatherRoute]["container_height"] =
                          fragmentPoolDateMap[fatherRoute]["layout_height"] > childrenContainerHeight ? fragmentPoolDateMap[fatherRoute]["layout_height"] : childrenContainerHeight;
                    }
                  }
                });

                /// 3、从任意 route 开始,向上紧贴,向左对齐
                fragmentPoolDateMap.forEach((key, value) {
                  double topContainerHeight = 0.0; // 不减去 height_space 是因为 top 时包含最底下的 height_space
                  double finalLeft = 0.0;

                  /// 逐渐减
                  for (int partIndex = key.length ~/ 2; partIndex >= 0; partIndex--) {
                    String partRoute = key.substring(0, partIndex * 2 + 1);

                    /// 向上紧贴
                    for (int upIndex = 0; upIndex < int.parse(partRoute[partRoute.length - 1]); upIndex++) {
                      topContainerHeight += fragmentPoolDateMap[partRoute.substring(0, partRoute.length - 1) + "$upIndex"]["container_height"] + heightSpace;
                    }

                    /// 向左对齐
                    if (partRoute != key) {
                      finalLeft += fragmentPoolDateMap[partRoute]["layout_width"] + widthSpace; // 需要加上 widthSpace
                    }
                  }
                  fragmentPoolDateMap[key]["layout_top"] = topContainerHeight;
                  fragmentPoolDateMap[key]["layout_left"] = finalLeft;
                });

                /// 4、从 tail_route 开始,垂直居中偏移
                tailMap.forEach((key, value) {
                  /// 向左传递,逐渐减
                  for (int partIndex = key.length ~/ 2; partIndex >= 0; partIndex--) {
                    String partRoute = key.substring(0, partIndex * 2 + 1);

                    /// 既然从尾部开始，那么就不处理"0"
                    if (partRoute != "0") {
                      String fatherRoute = partRoute.substring(0, partRoute.length - 2);
                      int childCount = 0;

                      /// 迭代同层级的 route
                      for (int incIndex = 0; incIndex < fragmentPoolDateMap.length; incIndex++) {
                        if (fragmentPoolDateMap.containsKey(fatherRoute + "-${incIndex + 1}") == false) {
                          childCount = incIndex + 1;
                          break;
                        }
                      }
                      double childrenUp = fragmentPoolDateMap[fatherRoute + "-0"]["layout_top"];
                      double childrenDown = fragmentPoolDateMap[fatherRoute + "-${childCount - 1}"]["layout_top"] + fragmentPoolDateMap[fatherRoute + "-${childCount - 1}"]["layout_height"];
                      double childrenUDHeight = (childrenDown - childrenUp).abs();
                      double fatherUp = fragmentPoolDateMap[fatherRoute]["layout_top"];
                      double fatherHeight = fragmentPoolDateMap[fatherRoute]["layout_height"];
                      if (childrenUDHeight >= fragmentPoolDateMap[fatherRoute]["layout_height"]) {
                        /// 1、这里不能用"2、"的方式,因为 children 上方的空无不容易计算;
                        fragmentPoolDateMap[fatherRoute]["layout_top"] = (childrenUDHeight / 2 - fatherHeight / 2) + childrenUp;
                      } else {
                        /// 2、这里不能用"1、"的方法,因为需要把整个 children 进行调整;
                        double finalchild0Top = (fatherHeight / 2 - childrenUDHeight / 2) + fatherUp;
                        double delta = (finalchild0Top - childrenUp).abs();
                        void func(String route) {
                          for (int i = 0; i < fragmentPoolDateMap.length; i++) {
                            String childRoute = route + "-$i";
                            Map<dynamic, dynamic> map = fragmentPoolDateMap[childRoute];
                            if (map != null) {
                              fragmentPoolDateMap[childRoute]["vertical_center_offset"] = delta;
                              func(childRoute);
                            } else {
                              break;
                            }
                          }
                        }

                        func(fatherRoute);
                      }
                    }
                  }
                });

                fragmentPoolDateMap.forEach((key, value) {
                  fragmentPoolDateMap[key]["layout_top"] += fragmentPoolDateMap[key]["vertical_center_offset"];
                  (value["this"] as SingleNodeState).setState(() {});
                });

                /// 5、镜头调至原点
                Offset zeroCorrectOffset = Offset(fragmentPoolDateMap["0"]["layout_left"], -fragmentPoolDateMap["0"]["layout_top"]);
                Offset mediaCenter = Offset(MediaQueryData.fromWindow(window).size.width / 2, MediaQueryData.fromWindow(window).size.height / 2);
                Offset zeroCenter = -Offset(fragmentPoolDateMap["0"]["layout_width"] / 2, fragmentPoolDateMap["0"]["layout_height"] / 2);
                initFreeBoxPosition(zeroCorrectOffset + mediaCenter + zeroCenter);
              });
            },
          ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FreeBox(
      boxWidth: double.maxFinite,
      boxHeight: double.maxFinite,
      eventWidth: double.maxFinite,
      eventHeight: double.maxFinite,
      backgroundColor: Colors.green,
      initPosition: (rebuild) {
        initFreeBoxPosition = rebuild;
      },

      /// [FreeBox] 被 [rebuild] , [childrenWidget] 并不会被 [rebuild] ， [FragmentPool] 被 [rebuild] , [childrenWidget] 才会被 [rebuild]
      children: childrenWidget(),
    );
  }
}

class EndIndex extends StatefulWidget {
  EndIndex({Key key, @required this.frameCallback, @required this.s}) : super(key: key);
  final Function frameCallback;
  final Function s;

  @override
  _EndIndexState createState() => _EndIndexState();
}

class _EndIndexState extends State<EndIndex> {
  void reGetLayoutSize() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// 当所有 [SingleNode] 都build完一遍后调用。
      widget.frameCallback();
    });
  }

  @override
  void didUpdateWidget(EndIndex oldWidget) {
    super.didUpdateWidget(oldWidget);
    reGetLayoutSize();
  }

  @override
  void initState() {
    super.initState();
    reGetLayoutSize();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () {
          widget.s();
        },
        child: Text("data"),
      ),
    );
  }
}
