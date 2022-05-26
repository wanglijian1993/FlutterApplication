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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
              snap: true,
              flexibleSpace: MyBanner(),
            ),
            HomeArticlesWidget(0),
            HomeArticlesWidget(1),
          ],
        ),
        controller: _controller,
        header: MaterialHeader(),
        enableControlFinishLoad: true,
        enableControlFinishRefresh: true,
        onRefresh: () async {
          _controller.finishRefresh();
        },
        onLoad: () async {
          _controller.finishLoad();
        });
  }
}

class MyBanner extends StatefulWidget {
  const MyBanner({Key? key}) : super(key: key);

  @override
  State<MyBanner> createState() => _MyBannerState();
}

class _MyBannerState extends State<MyBanner> {
  late List<Banner.DataBean> mBanners = [];

  @override
  void initState() {
    super.initState();
    reqeustBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: SizedBox(
          height: 230,
          child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.network(mBanners[index].imagePath,
                    fit: BoxFit.fill);
              },
              itemCount: mBanners.length,
              loop: true,
              autoplay: true,
              duration: 300)),
    );
  }

  void reqeustBanners() async {
    try {
      Response response =
          await HttpClient.get(HttpQueryParams.bannerQuery, null);
      var banners = BannersBean.fromJson(response.data);
      if (banners.errorCode == 0) {
        mBanners.addAll(banners.data);
        setState(() {});
      }
    } on DioError catch (e) {}
  }
}

class HomeArticlesWidget extends StatefulWidget {
  late int mType;

  HomeArticlesWidget(int type, {Key? key}) : super(key: key) {
    mType = type;
  }

  @override
  State<StatefulWidget> createState() => _HomeArticlesWidget();
}

/**
 * home articles
 */
class _HomeArticlesWidget extends State<HomeArticlesWidget> {
  //下标
  int index = 0;
  List<Articles.DataBean> articles = [];

  var divider = Divider(
    color: Colors.grey.shade300,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('_HomeArticlesWidget init');
    reqeustTopArticle(widget.mType);
  }

  /**
   * 请求首页文章
   */
  void reqeustTopArticle(int type) async {
    if (type == 0) {
      Response articles =
          await HttpClient.get(HttpQueryParams.HotArticle, null);
      var homeHotArticles = Articles.HomeHotArticles.fromJson(articles.data);
      if (homeHotArticles.errorCode == 0) {
        this.articles.addAll(homeHotArticles.data);
        setState(() {});
      }
    } else if (type == 1) {
      Response articles =
          await HttpClient.get('/article/list/${index}/json', null);
      var homeArticles = HomeArticles.fromJson(articles.data);
      if (homeArticles.errorCode == 0) {
        this.articles.addAll(homeArticles.data.datas);
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        var article = articles[index];
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
      childCount: articles.length,
    ));
  }
}