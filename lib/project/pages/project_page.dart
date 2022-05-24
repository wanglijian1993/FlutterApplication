import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_appliciation/https/http_client.dart';
import 'package:my_appliciation/project/beans/ProjectArticles.dart';
import 'package:my_appliciation/project/beans/ProjectTabs.dart';

import '../../https/http_qeury_params.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with TickerProviderStateMixin {
  int _onTap = 0;
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
                  return FutureBuilder(
                    future: HttpClient.get(
                        '/project/list/1/json?cid=${e.courseId}', null),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Response reponse = snapshot.data;
                        ProjectArticles projectArticles =
                            ProjectArticles.fromJson(reponse.data);
                        return ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              DatasBean article =
                                  projectArticles.data.datas[index];
                              return Row(
                                children: [
                                  Image(
                                    image: NetworkImage(article.envelopePic),
                                    width: 100,
                                  ),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text(article.title),
                                      SizedBox(height: 8),
                                      Text(article.desc),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(article.author),
                                              Text(article.niceShareDate),
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
                                      )
                                    ],
                                  ))
                                ],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => divider,
                            itemCount: projectArticles.data.datas.length);
                      }
                      return Text('');
                    },
                  );
                }).toList(),
                controller: _tabControl,
              ));
        }
        return Text('');
      },
    );
  }
}
