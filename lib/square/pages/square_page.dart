import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:my_appliciation/https/http_client.dart';

import '../../widgets/MyDividers.dart';
import '../bean/Squares.dart';

/**
 * 广场
 */
class SquarePage extends StatefulWidget {
  const SquarePage({Key? key}) : super(key: key);

  @override
  State<SquarePage> createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage> {
  int index = 0;
  List<DatasBean> _mySquaras = [];
  var divider = buildGreyDivider();
  late EasyRefreshController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = EasyRefreshController();
    print('square_articles_page initState');
    reqeustSquares(-1);
  }

  @override
  Widget build(BuildContext context) {
    print('square_articles_page build');
    return EasyRefresh(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          var square = _mySquaras[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  square.title,
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "作者:${square.author.length > 0 ? square.author : square.shareUser}"),
                    Text("分享时间:${square.shareDate}")
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("分类:${square.superChapterName}/${square.chapterName}"),
                    Icon(
                      CupertinoIcons.heart_solid,
                      size: 20,
                      color: Colors.red,
                    )
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: _mySquaras.length,
        separatorBuilder: (BuildContext context, int index) {
          return divider;
        },
      ),
      enableControlFinishLoad: true,
      enableControlFinishRefresh: true,
      controller: _controller,
      onLoad: () async {
        index++;
        reqeustSquares(1);
      },
      onRefresh: () async {
        index = 0;
        _mySquaras.clear();
        reqeustSquares(0);
      },
    );
  }

  void reqeustSquares(int type) async {
    Future future = HttpClient.get('/user_article/list/$index/json', null);
    future.then((value) {
      Squares mySquars = Squares.fromJson(value.data);
      if (mySquars.errorCode == 0) {
        _mySquaras.addAll(mySquars.data.datas);
        setState(() {
          if (type == 0) {
            _controller.finishRefresh();
          } else if (type == 1) {
            _controller.finishLoad();
          }
        });
      }
    }).catchError(print);
  }
}
