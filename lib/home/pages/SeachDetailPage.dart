import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:my_appliciation/home/bean/SeachDetailBean.dart';
import 'package:my_appliciation/https/http_client.dart';
import 'package:my_appliciation/widgets/MyDividers.dart';

import '../../login/pages/Login.dart';
import '../../utils/CommonHttpRequest.dart';
import '../../utils/LoginSingleton.dart';

class SeachDetailPage extends StatefulWidget {
  String value;

  SeachDetailPage(@required this.value, {Key? key}) : super(key: key);

  @override
  State<SeachDetailPage> createState() => _SeachDetailPageState();
}

class _SeachDetailPageState extends State<SeachDetailPage> {
  EasyRefreshController _controller = EasyRefreshController();
  List<DatasBean> seachContents = [];
  Divider _divider = buildGreyDivider();
  int index = 0;

  @override
  void initState() {
    super.initState();
    HttpClient.post('/article/query/$index/json', {"k": widget.value})
        .then((value) {
      SeachDetailBean seachDetailBean = SeachDetailBean.fromJson(value);
      if (seachDetailBean.errorCode == 0) {
        setState(() {
          seachContents.addAll(seachDetailBean.data.datas);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.value),
      ),
      body: EasyRefresh(
        controller: _controller,
        enableControlFinishLoad: true,
        enableControlFinishRefresh: true,
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              var seachContent = seachContents[index];
              return Padding(
                padding:
                    const EdgeInsets.only(left: 8, top: 4, right: 4, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(seachContent.title),
                    SizedBox(height: 6),
                    Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '作者:${seachContent.shareUser.length > 0 ? seachContent.shareUser : seachContent.author}'),
                            SizedBox(
                              height: 4,
                            ),
                            Text('发布时间:${seachContent.niceShareDate}')
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            if (!LoginSingleton().isLogin) {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return LoginPage();
                              }));
                              return;
                            }
                            if (seachContent.collect) {
                              toUnCollectArticle(seachContent.id);
                            } else {
                              toCollectArticle(seachContent.id);
                            }
                            setState(() {
                              seachContent.collect = !seachContent.collect;
                            });
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              CupertinoIcons.heart_solid,
                              size: 20,
                              color: seachContent.collect
                                  ? Colors.red
                                  : Colors.black54,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => _divider,
            itemCount: seachContents.length),
      ),
    );
  }
}
