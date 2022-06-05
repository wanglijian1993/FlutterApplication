import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:my_appliciation/home/bean/CollectBean.dart';
import 'package:my_appliciation/https/http_client.dart';
import 'package:my_appliciation/widgets/MyDividers.dart';

/**
 * 收藏Widget
 */

class MyCoolectWdigetPage extends StatefulWidget {
  MyCoolectWdigetPage({Key? key}) : super(key: key);

  @override
  _MyCoolectWdigetPageState createState() => _MyCoolectWdigetPageState();
}

class _MyCoolectWdigetPageState extends State<MyCoolectWdigetPage> {
  Divider _divider = buildGreyDivider();
  List<DatasBean> mCollects = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    requestCollectCircle();
  }

  void requestCollectCircle() {
    HttpClient.get('/lg/collect/list/$index/json', null).then((value) {
      print('collect:$value');
      CollectBean collectBean = CollectBean.fromJson(value.data);
      if (collectBean.errorCode == 0) {
        setState(() {
          mCollects.addAll(collectBean.data.datas);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('我的收藏'),
        ),
        body: EasyRefresh(
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                var collectArticle = mCollects[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 8, top: 4, right: 4, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(collectArticle.title),
                      SizedBox(height: 6),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('作者:${collectArticle.author}'),
                          SizedBox(
                            height: 4,
                          ),
                          Text('发布时间:${collectArticle.publishTime}')
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => _divider,
              itemCount: mCollects.length),
        ));
  }
}
