import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:my_appliciation/https/http_client.dart';

import '../../https/http_qeury_params.dart';
import '../../utils/CommonHttpRequest.dart';
import '../bean/OfficialAccountArticlesBean.dart';
import '../bean/OfficialAccountTabBean.dart' as Aticles;

class OfficialAccountPage extends StatefulWidget {
  const OfficialAccountPage({Key? key}) : super(key: key);

  @override
  State<OfficialAccountPage> createState() => _OfficialAccountPageState();
}

class _OfficialAccountPageState extends State<OfficialAccountPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    print('official_account_articles_page initState');
  }

  @override
  Widget build(BuildContext context) {
    print('official_account_articles_page build');
    return FutureBuilder(
      future: HttpClient.get(AffAccountHttp.OfficialAccount, null),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Response response = snapshot.data;
          var officialAccountBean =
              Aticles.OfficialAccountTabBean.fromJson(response.data);
          _tabController = TabController(
              length: officialAccountBean.data.length, vsync: this);
          return Scaffold(
            appBar: TabBar(
              labelColor: Colors.blue,
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              isScrollable: true,
              tabs: officialAccountBean.data
                  .map((e) => Tab(
                text: e.name,
              ))
                  .toList(),
              controller: _tabController,
            ),
            body: TabBarView(
                controller: _tabController,
                children: officialAccountBean.data.map((e) {
                  return MyTabBarView(e);
                }).toList()),
          );
        }
        return Text('');
      },
    );
  }
}

class MyTabBarView extends StatefulWidget {
  Aticles.DataBean mAritcles;

  MyTabBarView(this.mAritcles, {Key? key}) : super(key: key);

  @override
  State<MyTabBarView> createState() => _MyTabBarViewState();
}

class _MyTabBarViewState extends State<MyTabBarView> {
  Widget divider = const Divider(color: Colors.grey);
  EasyRefreshController _controller = EasyRefreshController();
  int index = 0;
  List<DatasBean> mOfficalAccount = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestOfficialAccountArticles(widget.mAritcles.id, -1);
  }

  void requestOfficialAccountArticles(num id, int type) {
    print('content$id,type$type');
    HttpClient.get('/wxarticle/list/$id/$index/json', null).then((value) {
      Response response = value;
      OfficialAccountArticlesBean offAccountArticles =
          OfficialAccountArticlesBean.fromJson(response.data);
      if (offAccountArticles.errorCode == 0) {
        setState(() {
          mOfficalAccount.addAll(offAccountArticles.data.datas);
          if (type == 0) {
            _controller.finishRefresh();
          } else if (type == 1) {
            _controller.finishLoad();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: _controller,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          var offAccountArticle = mOfficalAccount[index];
          return Padding(
            padding:
                const EdgeInsets.only(left: 8, top: 4, right: 4, bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(offAccountArticle.title),
                SizedBox(height: 6),
                Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '作者:${offAccountArticle.shareUser.length > 0 ? offAccountArticle.shareUser : offAccountArticle.author}'),
                        SizedBox(
                          height: 4,
                        ),
                        Text('发布时间:${offAccountArticle.niceShareDate}')
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        if(offAccountArticle.collect){
                          toUnCollectArticle(offAccountArticle.id);
                        }else {
                          toCollectArticle(offAccountArticle.id);
                        }
                        setState(() {
                          offAccountArticle.collect=!offAccountArticle.collect;
                        });
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          CupertinoIcons.heart_solid,
                          size: 20,
                          color:offAccountArticle.collect?Colors.red : Colors.black54,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
        itemCount: mOfficalAccount.length,
        separatorBuilder: (BuildContext context, int index) {
          return divider;
        },
      ),
      onRefresh: () async {
        index = 0;
        mOfficalAccount.clear();
        requestOfficialAccountArticles(widget.mAritcles.id, 0);
      },
      onLoad: () async {
        index++;
        requestOfficialAccountArticles(widget.mAritcles.id, 1);
      },
    );
  }
}
