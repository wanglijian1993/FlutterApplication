import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:my_appliciation/https/http_client.dart';
import 'package:my_appliciation/project/beans/ProjectArticles.dart' as Articles;
import 'package:my_appliciation/project/beans/ProjectTabs.dart';
import 'package:my_appliciation/widgets/MyDividers.dart';

import '../../https/http_qeury_params.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with TickerProviderStateMixin {
  var divider = const Divider(
    color: Colors.grey,
  );
  late var _tabControl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HttpClient.get(ProjectHttp.projectTree, null),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Response response = snapshot.data;
          ProjectTabs projectTabs = ProjectTabs.fromJson(response.data);
          _tabControl =
              TabController(length: projectTabs.data.length, vsync: this);
          return Scaffold(
              appBar: TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black,
                controller: _tabControl,
                tabs: projectTabs.data.map((e) {
                  return Tab(text: e.name);
                }).toList(),
                isScrollable: true,
              ),
              body: TabBarView(
                children: projectTabs.data.map((e) {
                  return ProjectArticles(e.courseId);
                }).toList(),
                controller: _tabControl,
              ));
        }
        return Text('');
      },
    );
  }
}

class ProjectArticles extends StatefulWidget {
  num courseId;

  ProjectArticles(this.courseId, {Key? key}) : super(key: key);

  @override
  State<ProjectArticles> createState() => _ProjectArticlesState();
}

class _ProjectArticlesState extends State<ProjectArticles> {
  final EasyRefreshController _controller = EasyRefreshController();
  List<Articles.DatasBean> mArtices = [];
  Divider divider = buildGreyDivider();
  int index = 0;

  @override
  void initState() {
    super.initState();
    reqeustProjectArticles(-1);
  }

  void reqeustProjectArticles(num type) {
    HttpClient.get('/project/list/$index/json?cid=${widget.courseId}', null)
        .then((value) {
      Articles.ProjectArticles projectArticles =
          Articles.ProjectArticles.fromJson(value.data);
      if (projectArticles.errorCode == 0) {
        setState(() {
          mArtices.addAll(projectArticles.data.datas);
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: EasyRefresh(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              Articles.DatasBean article = mArtices[index];
              return Row(
                children: [
                  Image(
                    image: NetworkImage(article.envelopePic),
                    width: 80,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(article.title,
                                style: const TextStyle(fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 10),
                            Text(article.desc,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black54),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 8),
                            Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "作者: ${article.author.length > 0 ? article.author : article.shareUser}"),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text("发布时间:${article.niceShareDate}"),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    CupertinoIcons.heart_circle,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) => divider,
            itemCount: mArtices.length),
        controller: _controller,
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        onRefresh: () async {
          index = 0;
          mArtices.clear();
          reqeustProjectArticles(0);
        },
        onLoad: () async {
          index++;
          reqeustProjectArticles(1);
        },
      ),
    );
  }
}
