import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:my_appliciation/widgets/MyTitle.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(
              MediaQuery.of(context).size.width, AppBar().preferredSize.height),
          child: MyAppBar("wanAndroid", 0),
        ),
        body: CustomScrollView(
          //为了能使CustomScrollView拉到顶部时还能继续往下拉，必须让 physics 支持弹性效果
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            //我们需要实现的 SliverFlexibleHeader 组件
            SliverFlexibleHeader(
              visibleExtent: 200,
              builder: (BuildContext context, double maxExtent) {
                return GestureDetector(
                  onTap: () => print('tap'),
                  child: Image(
                    image: AssetImage(
                        'images/live_store_detail_live_default_bg.png'),
                    width: 50,
                    height: maxExtent,
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.cover,
                  ),
                );
              }, // 初始状态在列表中占用的布局高度
            ),
            // 构建一个list
            SliverList(
                delegate: SliverChildListDelegate.fixed(buildSliverList(30))),
          ],
        ),
      ),
    );
  }

  List<Widget> buildSliverList(int i) {
    List<Widget> widgets = List.generate(i, (index) {
      return Text('$i');
    }).toList();
    return widgets;
  }
}

class _SliverFlexibleHeader extends SingleChildRenderObjectWidget {
  const _SliverFlexibleHeader({
    Key? key,
    required Widget child,
    this.visibleExtent = 0,
  }) : super(key: key, child: child);
  final double visibleExtent;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _FlexibleHeaderRenderSliver(visibleExtent);
  }

  @override
  void updateRenderObject(
      BuildContext context, _FlexibleHeaderRenderSliver renderObject) {
    renderObject..visibleExtent = visibleExtent;
  }
}

class _FlexibleHeaderRenderSliver extends RenderSliverSingleBoxAdapter {
  _FlexibleHeaderRenderSliver(double visibleExtent)
      : _visibleExtent = visibleExtent;

  double _lastOverScroll = 0;
  double _lastScrollOffset = 0;
  late double _visibleExtent = 0;

  set visibleExtent(double value) {
    // 可视长度发生变化，更新状态并重新布局
    if (_visibleExtent != value) {
      _lastOverScroll = 0;
      _visibleExtent = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    // 滑动距离大于_visibleExtent时则表示子节点已经在屏幕之外了
    print(
        'constraints.scrollOffset:${constraints.scrollOffset},_visibleExtent:$_visibleExtent');
    if (child == null || (constraints.scrollOffset > _visibleExtent)) {
      geometry = SliverGeometry(scrollExtent: _visibleExtent);
      return;
    }

    // 测试overlap,下拉过程中overlap会一直变化.
    double overScroll = constraints.overlap < 0 ? constraints.overlap.abs() : 0;
    print(
        'constraints.overlap:${constraints.overlap},constraints.overlap.abs:${constraints.overlap.abs()}');

    var scrollOffset = constraints.scrollOffset;
    print('scrollOffset:$scrollOffset');

    // 在Viewport中顶部的可视空间为该 Sliver 可绘制的最大区域。
    // 1. 如果Sliver已经滑出可视区域则 constraints.scrollOffset 会大于 _visibleExtent，
    //    这种情况我们在一开始就判断过了。
    // 2. 如果我们下拉超出了边界，此时 overScroll>0，scrollOffset 值为0，所以最终的绘制区域为
    //    _visibleExtent + overScroll.
    double paintExtent = _visibleExtent + overScroll - constraints.scrollOffset;
    print('paintExtent:$paintExtent');
    // 绘制高度不超过最大可绘制空间
    paintExtent = min(paintExtent, constraints.remainingPaintExtent);
    print(
        'constraints.remainingPaintExtent):${constraints.remainingPaintExtent})');

    //对子组件进行布局，关于 layout 详细过程我们将在本书后面布局原理相关章节详细介绍，现在只需知道
    //子组件通过 LayoutBuilder可以拿到这里我们传递的约束对象（ExtraInfoBoxConstraints）
    child!.layout(
      constraints.asBoxConstraints(maxExtent: paintExtent),
      parentUsesSize: false,
    );

    //最大为_visibleExtent，最小为 0
    double layoutExtent = min(_visibleExtent, paintExtent);

    //设置geometry，Viewport 在布局时会用到
    geometry = SliverGeometry(
      scrollExtent: layoutExtent,
      paintOrigin: -overScroll,
      paintExtent: paintExtent,
      maxPaintExtent: paintExtent,
      layoutExtent: layoutExtent,
    );
  }
}

typedef SliverFlexibleHeaderBuilder = Widget Function(
  BuildContext context,
  double maxExtent,
  //ScrollDirection direction,
);

class SliverFlexibleHeader extends StatelessWidget {
  const SliverFlexibleHeader({
    Key? key,
    this.visibleExtent = 0,
    required this.builder,
  }) : super(key: key);

  final SliverFlexibleHeaderBuilder builder;
  final double visibleExtent;

  @override
  Widget build(BuildContext context) {
    return _SliverFlexibleHeader(
      visibleExtent: visibleExtent,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return builder(context, constraints.maxHeight);
        },
      ),
    );
  }
}