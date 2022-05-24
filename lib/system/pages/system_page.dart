import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_appliciation/https/http_client.dart';
import 'package:my_appliciation/system/bean/NavigationBean.dart' as Navi;
import 'package:my_appliciation/system/bean/SystemBean.dart' as TreeSystem;

import '../../https/http_qeury_params.dart';

class SystemPage extends StatefulWidget {
  const SystemPage({Key? key}) : super(key: key);

  @override
  State<SystemPage> createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = <String>["体系", "导航"];
  Widget divider = const Divider(color: Colors.grey);

  @override
  void initState() {
    // TODO: implement initStateuz
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: _tabController,
        labelColor: Colors.blue,
        indicatorColor: Colors.blue,
        unselectedLabelColor: Colors.black,
        tabs: _tabs.map((e) => Tab(text: e)).toList(),
      ),
      body: TabBarView(
          controller: _tabController,
          children: _tabs.map((e) {
            if (e == '体系') {
              return FutureBuilder(
                future: HttpClient.get(SystemHttp.system, null),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Response response = snapshot.data;
                    TreeSystem.SystemBean systemBean =
                        TreeSystem.SystemBean.fromJson(response.data);
                    return ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        TreeSystem.DataBean system = systemBean.data[index];
                        return Column(
                          children: [
                            Text(system.name),
                            Wrap(
                              spacing: 2,
                              runSpacing: 5,
                              children: List.generate(system.children.length,
                                  (index) {
                                TreeSystem.ChildrenBean children =
                                    system.children[index];
                                return Text(children.name);
                              }),
                            ),
                          ],
                        );
                      },
                      itemCount: systemBean.data.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return divider;
                      },
                    );
                  }
                  return Text('');
                },
              );
            } else {
              return FutureBuilder(
                future: HttpClient.get(SystemHttp.navi, null),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    int _onTap = 0;
                    Response response = snapshot.data;
                    Navi.NavigationBean navigation =
                        Navi.NavigationBean.fromJson(response.data);

                    return Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: ListView.separated(
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(navigation.data[index].name);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        divider,
                                itemCount: navigation.data.length)),
                        Expanded(
                            flex: 3,
                            child: Wrap(
                              children: List.generate(
                                  navigation.data[_onTap].articles.length,
                                  (index) => Text(navigation
                                      .data[_onTap].articles[index].title)),
                            )),
                      ],
                    );
                  }
                  return Text('');
                },
              );
            }
          }).toList()),
    );
  }
}
