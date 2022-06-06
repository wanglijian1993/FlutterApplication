import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:my_appliciation/https/http_client.dart';
import 'package:my_appliciation/utils/CommonHttpRequest.dart';
import 'package:my_appliciation/webview/MyWebView.dart';

import '../../https/http_qeury_params.dart';
import '../../widgets/MyDividers.dart';
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
  late final EasyRefreshController _controller = EasyRefreshController();

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
    print('HomeWidget initState');
    reqeustHomeDatas(-1);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('home_articles_page build');
    return EasyRefresh.custom(
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
        header: MaterialHeader(),
        controller: _controller,
        enableControlFinishLoad: true,
        enableControlFinishRefresh: true,
        onRefresh: () async {
          index = 0;
          topArticles.clear();
          hotArticles.clear();
          reqeustHomeDatas(0);
        },
        onLoad: () async {
          reqeustArticle();
        });
  }

  void reqeustHomeDatas(int type) async {
    Future.wait([
      HttpClient.get(HttpQueryParams.HotArticle, null),
      HttpClient.get('/article/list/${index}/json', null),
      HttpClient.get(HttpQueryParams.bannerQuery, null)
    ]).then((value) {
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
        mBanners.clear();
        mBanners.addAll(banners.data);
      }
      setState(() {
        if (type == 0) {
          _controller.finishRefresh(success: true);
        }
      });
    }).catchError((e) {
      print('error:${e}');
    });
  }

  /**
   * 请求首页文章
   */
  Future reqeustArticle() async {
    index++;
    Response articles =
        await HttpClient.get('/article/list/${index}/json', null);
    var homeArticles = HomeArticles.fromJson(articles.data);
    if (homeArticles.errorCode == 0) {
      hotArticles.addAll(homeArticles.data.datas);
    }
    setState(() {
      _controller.finishLoad(success: true);
    });
  }
}

class MyBanner extends StatefulWidget {
  List<Banner.DataBean> mBanners;

  MyBanner(this.mBanners, {Key? key}) : super(key: key);

  @override
  State<MyBanner> createState() => _MyBannerState();
}

class _MyBannerState extends State<MyBanner> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
  var divider = buildGreyDivider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        var article = widget.articles[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return MyWebView(article.link);
            }));
          },
          child: Column(
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
                      "作者:${article.author.length > 0 ? article.author : article.shareUser}",
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
                          GestureDetector(
                            onTap: () {
                              if(article.collect){
                                 toUnCollectArticle(article.id);
                              }else {
                                toCollectArticle(article.id);
                              }
                              setState(() {
                                article.collect=!article.collect;
                              });
                            },
                            child: GestureDetector(
                              onTap: () {
                                if(article.collect){
                                  toUnCollectArticle(article.id);
                                }else {
                                  toCollectArticle(article.id);
                                }
                                setState(() {
                                  article.collect=!article.collect;
                                });
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  CupertinoIcons.heart_fill,
                                  size: 20,
                                  color: article.collect?Colors.red : Colors.black54,
                                ),
                              ),
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
          ),
        );
      },
      childCount: widget.articles.length,
    ));
  }
}