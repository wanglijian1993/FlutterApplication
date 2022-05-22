import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_appliciation/https/http_client.dart';

import '../bean/Squares.dart';

class SquarePage extends StatelessWidget {
  const SquarePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSquares(0);
  }

  FutureBuilder<dynamic> buildSquares(int index) {
    Widget divider = const Divider(color: Colors.grey);

    return FutureBuilder(
      future: HttpClient.get('/user_article/list/$index/json', null),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Response response = snapshot.data;
          var squares = Squares.fromJson(response.data);
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              var square = squares.data.datas[index];
              return Column(
                children: [
                  Text(
                    square.title,
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("作者:${square.author}"),
                      Text("分享时间:${square.shareDate}")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "分类:${square.superChapterName}/${square.chapterName}"),
                      Icon(
                        CupertinoIcons.heart_solid,
                        size: 20,
                        color: Colors.red,
                      )
                    ],
                  ),
                ],
              );
            },
            itemCount: squares.data.datas.length,
            separatorBuilder: (BuildContext context, int index) {
              return divider;
            },
          );
        }
        return Text("");
      },
    );
  }
}
