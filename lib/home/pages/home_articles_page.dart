import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:my_appliciation/https/http_client.dart';

import '../../https/http_qeury_params.dart';
import '../../widgets/MyTitle.dart';
import '../bean/BannersBean.dart' as Banner;
import '../bean/BannersBean.dart';
import '../bean/HomeArticles.dart';
import '../bean/HomeHotArticles.dart' as Articles;

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late EasyRefreshController _controller;

  //下标
  int index = 0;

  //置顶文章
  List<Articles.DataBean> topArticles = [];

  //热门文章
  List<Articles.DataBean> hotArticles = [];

  //Banner
  late List<Banner.DataBean> mBanners = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = EasyRefreshController();
    reqeustHomeDatas();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              title: MyAppBar('wanAndroid', 0),
              floating: true,
              flexibleSpace: MyBanner(mBanners),
            ),
            HomeArticlesWidget(topArticles, 0),
            HomeArticlesWidget(hotArticles, 1),
          ],
        ),
        controller: _controller,
        header: MaterialHeader(),
        enableControlFinishLoad: true,
        enableControlFinishRefresh: true,
        onRefresh: () async {
          print('onRefresh');
          reqeustHomeDatas();
          _controller.finishRefresh();
        },
        onLoad: () async {
          _controller.finishLoad();
        });
  }

  void reqeustHomeDatas() async {
    Future.wait([
      HttpClient.get(HttpQueryParams.HotArticle, null),
      HttpClient.get('/article/list/${index}/json', null),
      HttpClient.get(HttpQueryParams.bannerQuery, null)
    ]).then((value) {
      print(
          'reqeustHomeDatas future-wait0:${value[0]},1:${value[1]},2:${value[2]}');
      var homeHotArticles = Articles.HomeHotArticles.fromJson(value[0].data);
      if (homeHotArticles.errorCode == 0) {
        topArticles.addAll(homeHotArticles.data);
      }
      var homeArticles = HomeArticles.fromJson(value[1].data);
      if (homeArticles.errorCode == 0) {
        hotArticles.addAll(homeArticles.data.datas);
      }
      var banners = BannersBean.fromJson(value[2].data);
      if (banners.errorCode == 0) {
        mBanners.addAll(banners.data);
      }
      print('value:${value.length}');
      print(
          'topArticles:${topArticles.length},hotArticles:${hotArticles.length},banner${mBanners.length}');
      setState(() {});
    }).catchError((e) {
      print('error:${e}');
    });
  }

  /**
   * 请求首页文章
   */
  Future reqeustArticle(int type) async {
    print('reqeustTopArticle');
    if (type == 0) {
      Response articles =
          await HttpClient.get(HttpQueryParams.HotArticle, null);
      print('data:${articles.data}');
      var homeHotArticles = Articles.HomeHotArticles.fromJson(articles.data);
      if (homeHotArticles.errorCode == 0) {
        topArticles.addAll(homeHotArticles.data);
      }
    } else if (type == 1) {
      Response articles =
          await HttpClient.get('/article/list/${index}/json', null);
      var homeArticles = HomeArticles.fromJson(articles.data);
      if (homeArticles.errorCode == 0) {
        hotArticles.addAll(homeArticles.data.datas);
      }
    }
    print('reqeustArticle 完成');
  }

  Future reqeustBanners() async {
    print('reqeustBanners');
    try {
      Response response =
          await HttpClient.get(HttpQueryParams.bannerQuery, null);
      var banners = BannersBean.fromJson(response.data);
      if (banners.errorCode == 0) {
        mBanners.addAll(banners.data);
      }
      print('reqeustBanners 完成');
    } on DioError catch (e) {}
  }
}

class MyBanner extends StatefulWidget {
  late List<Banner.DataBean> mBanners = [];

  MyBanner(@required this.mBanners, {Key? key}) : super(key: key);

  @override
  State<MyBanner> createState() => _MyBannerState();
}

class _MyBannerState extends State<MyBanner> {

  @override
  void initState() {
    super.initState();
    print('_MyBannerState initState init');
  }

  @override
  Widget build(BuildContext context) {
    print('_MyBannerState build');
    return FlexibleSpaceBar(
      background: SizedBox(
          height: 230,
          child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.network(widget.mBanners[index].imagePath,
                    fit: BoxFit.fill);
              },
              itemCount: widget.mBanners.length,
              loop: true,
              autoplay: true,
              duration: 300)),
    );
  }
}

class HomeArticlesWidget extends StatefulWidget {
  late int mType;
  List<Articles.DataBean> articles = [];

  HomeArticlesWidget(@required this.articles, @required int type, {Key? key})
      : super(key: key) {
    mType = type;
  }

  @override
  State<StatefulWidget> createState() => _HomeArticlesWidget();
}

/**
 * home articles
 */
class _HomeArticlesWidget extends State<HomeArticlesWidget> {
  var divider = Divider(
    color: Colors.grey.shade300,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('_HomeArticlesWidget init');
  }

  @override
  Widget build(BuildContext context) {
    print('_HomeArticlesWidget build');
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        var article = widget.articles[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: widget.mType == 0 ? "HOT" : "TOP",
                            style: TextStyle(color: Colors.red, fontSize: 12)),
                        TextSpan(
                          text: '  ${article.title}',
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        )
                      ])),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "作者:${article.author}",
                        maxLines: 2,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 6,
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
                          ]),
                    ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 0.5,
              child: divider,
            )
          ],
        );
      },
      childCount: widget.articles.length,
    ));
  }
}