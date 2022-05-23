import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_appliciation/https/http_client.dart';
import 'package:my_appliciation/official_accounts/bean/OfficialAccountArticlesBean.dart';
import 'package:my_appliciation/official_accounts/bean/OfficialAccountTabBean.dart';

import '../../https/http_qeury_params.dart';

class OfficialAccountPage extends StatefulWidget {
  const OfficialAccountPage({Key? key}) : super(key: key);

  @override
  State<OfficialAccountPage> createState() => _OfficialAccountPageState();
}

class _OfficialAccountPageState extends State<OfficialAccountPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  Widget divider = const Divider(color: Colors.grey);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HttpClient.get(AffAccountHttp.OfficialAccount, null),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Response response = snapshot.data;
          print('data:${response.data}');
          var officialAccountBean =
              OfficialAccountTabBean.fromJson(response.data);
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
                  return FutureBuilder(
                    future:
                        HttpClient.get('/wxarticle/list/${e.id}/0/json', null),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      Response response = snapshot.data;
                      OfficialAccountArticlesBean offAccountArticles =
                          OfficialAccountArticlesBean.fromJson(response.data);
                      return ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          var offAccountArticle =
                              offAccountArticles.data.datas[index];
                          return Column(
                            children: [
                              Text(offAccountArticle.title),
                              SizedBox(height: 5),
                              Stack(
                                children: [
                                  Column(
                                    children: [
                                      Text('作者:${offAccountArticle.title}'),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                          '发布时间:${offAccountArticle.shareDate}')
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      CupertinoIcons.heart_solid,
                                      size: 40,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                        },
                        itemCount: offAccountArticles.data.datas.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return divider;
                        },
                      );
                    },
                  );
                }).toList()),
          );
        }
        return Text('');
      },
    );
  }
}

