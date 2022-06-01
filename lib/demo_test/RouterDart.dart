import 'package:flutter/material.dart';

/**
 * 这里我们一定会调用runApp方法，这个方法可以说是Flutter程序的入口：
 */
void main() => runApp(RouterDartApp());

class RouterDartApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "new_page": (context) => TipRoute(
                text: 'aaaa',
              ),
          "/": (context) => RouterDartPage('Flutter Demo Home Page'),
        } //注册首页路由
        );
  }
}

class RouterDartPage extends StatefulWidget {
  RouterDartPage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  _RouterDartPageState createState() => _RouterDartPageState();
}

class _RouterDartPageState extends State<RouterDartPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RouterTestRoute(),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({
    Key? key,
    required this.text, // 接收一个text参数
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, "我是返回值"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          // 打开`TipRoute`，并等待返回结果
          var result = await Navigator.pushNamed(context, 'new_page');
          //输出`TipRoute`路由返回结果
          print("路由返回值: $result");
        },
        child: Text("打开提示页"),
      ),
    );
  }
}
