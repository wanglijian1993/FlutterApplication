import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_appliciation/https/http_client.dart';

import '../../https/http_qeury_params.dart';
import '../bean/BannersBean.dart';
import '../bean/HomeArticles.dart';
import '../bean/HomeHotArticles.dart';

CustomScrollView buildCustomScrollView() {
  return CustomScrollView(
    slivers: [
      SliverAppBar(
        expandedHeight: 250,
        pinned: true,
        flexibleSpace: buildBanners(),
      ),
      HomeArticlesWidget(0),
      HomeArticlesWidget(1),
      // HomeArticlesWidget(1,index: 0,),
    ],
  );
}

/**
 * banners
 */
FlexibleSpaceBar buildBanners() {
  return FlexibleSpaceBar(
    title: const Text("wanAndroid"),
    background: FutureBuilder(
      future: HttpClient.get(HttpQueryParams.bannerQuery, null),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //请求完成
        if (snapshot.connectionState == ConnectionState.done) {
          Response response = snapshot.data;
          //发生错误
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          var banners = BannersBean.fromJson(response.data);
          //请求成功，通过项目信息构建用于显示项目名称的ListView
          return SizedBox(
              height: 230,
              child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(banners.data[index].imagePath,
                        fit: BoxFit.fill);
                  },
                  itemCount: banners.data.length,
                  loop: true,
                  autoplay: true,
                  duration: 300));
          ;
        }
        //请求未完成时弹出loading
        return const CircularProgressIndicator();
      },
    ),
  );
}

class HomeArticlesWidget extends StatefulWidget {
  late int mType;
  int mIndex = 0;

  HomeArticlesWidget(int type, {Key? key, int index = 0}) : super(key: key) {
    mType = type;
    mIndex = index;
  }

  @override
  State<StatefulWidget> createState() => _HomeArticlesWidget();
}

/**
 * home articles
 */
class _HomeArticlesWidget extends State<HomeArticlesWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.mType == 0
          ? HttpClient.get(HttpQueryParams.HotArticle, null)
          : HttpClient.get('/article/list/${widget.mIndex}/json', null),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Response response = snapshot.data;
          Object articles;
          int length;
          if (widget.mType == 0) {
            var homeHotArticles = HomeHotArticles.fromJson(response.data);
            length = homeHotArticles.data.length;
            articles = homeHotArticles;
          } else {
            var homeArticles = HomeArticles.fromJson(response.data);
            length = homeArticles.data.datas.length;
            articles = homeArticles;
          }
          return SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              var article;
              if (widget.mType == 0) {
                article = getHotHomeArticles(articles).data[index];
              } else {
                article = getArticles(articles).data.datas[index];
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      article.title,
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              "热",
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: Colors.red),
                            ),
                          ),
                          width: 30,
                          height: 18,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "作者:${article.author}",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        SizedBox(width: 3),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            article.niceShareDate,
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              CupertinoIcons.heart_solid,
                              size: 20,
                              color: Colors.red,
                            ),
                          )
                        ])
                  ],
                ),
              );
            },
            childCount: length,
          ));
        }
        return SliverList(
            delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Text('');
          },
          childCount: 0,
        ));
        ;
      },
    );
  }

  HomeHotArticles getHotHomeArticles(Object articles) =>
      articles as HomeHotArticles;

  HomeArticles getArticles(Object articles) => articles as HomeArticles;
}
