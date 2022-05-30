import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/**
 * 这里我们一定会调用runApp方法，这个方法可以说是Flutter程序的入口：
 */
void main() => runApp(EasyRefreshApp());

class EasyRefreshApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EasyRefreshPage('Flutter Demo Home Page'),
    );
  }
}

class EasyRefreshPage extends StatefulWidget {
  EasyRefreshPage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  _EasyRefreshPageState createState() => _EasyRefreshPageState();
}

class _EasyRefreshPageState extends State<EasyRefreshPage> {
  int _counter = 0;
  List<String> content = [];
  EasyRefreshController _controller = EasyRefreshController();

  @override
  void initState() {
    List.generate(25, (index) => {content.add('$index')});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: EasyRefresh(
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        header: MaterialHeader(),
        footer: MaterialFooter(),
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Text(content[index]);
            },
            separatorBuilder: (BuildContext context, int index) =>
                Divider(color: Colors.blue),
            itemCount: content.length),
        controller: _controller,
        onLoad: () async {
          content.clear();
          List.generate(25, (index) => {content.add('$index')});

          await Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              // 控制器关闭刷新功能
              _controller.finishRefresh(success: true);
            });
          });
        },
        onRefresh: () async {
          List.generate(25, (index) => {content.add('$index')});
          await Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              // 控制器关闭刷新功能
              _controller.finishRefresh(success: true);
            });
          });
        },
      ),
    );
  }
}
