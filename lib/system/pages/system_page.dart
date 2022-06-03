import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:my_appliciation/https/http_client.dart';
import 'package:my_appliciation/system/bean/NavigationBean.dart' as Navi;
import 'package:my_appliciation/system/bean/SystemBean.dart' as TreeSystem;

import '../../https/http_qeury_params.dart';
import '../../widgets/MyDividers.dart';

class SystemPage extends StatefulWidget {
   SystemPage({Key? key}) : super(key: key);

  @override
  State<SystemPage> createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = <String>["体系", "导航"];
  Widget divider = const Divider(color: Colors.grey);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    print('system_page build');
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
              return const SystemContentWidget();
            } else {
              return const NavigationContentWidget();
            }
          }).toList()),
    );
  }
}

class SystemContentWidget extends StatefulWidget {
  const SystemContentWidget({Key? key}) : super(key: key);

  @override
  State<SystemContentWidget> createState() => _SystemContentWidgetState();
}

class _SystemContentWidgetState extends State<SystemContentWidget> {
  final EasyRefreshController _controller = EasyRefreshController();
  Divider divider = buildGreyDivider();
  List<TreeSystem.DataBean> mTrees = [];

  @override
  void initState() {
    super.initState();
    requestTreeDatas(-1);
  }

  void requestTreeDatas(int type) {
    HttpClient.get(SystemHttp.system, null).then((value) {
      TreeSystem.SystemBean systemBean =
          TreeSystem.SystemBean.fromJson(value.data);
      if (systemBean.errorCode == 0) {
        setState(() {
          mTrees.addAll(systemBean.data);
          if (type == 0) {
            _controller.finishRefresh();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          TreeSystem.DataBean system = mTrees[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  system.name,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: 6,
                ),
                Wrap(
                  spacing: 2,
                  runSpacing: 5,
                  children: List.generate(system.children.length, (index) {
                    TreeSystem.ChildrenBean children = system.children[index];
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          children.name,
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(
                          width: 4,
                        )
                      ],
                    );
                  }),
                ),
              ],
            ),
          );
        },
        itemCount: mTrees.length,
        separatorBuilder: (BuildContext context, int index) {
          return divider;
        },
      ),
      controller: _controller,
      enableControlFinishRefresh: true,
      onRefresh: () async {
        mTrees.clear();
        requestTreeDatas(0);
      },
    );
  }
}

class NavigationContentWidget extends StatefulWidget {
  const NavigationContentWidget({Key? key}) : super(key: key);

  @override
  State<NavigationContentWidget> createState() =>
      _NavigationContentWidgetState();
}

class _NavigationContentWidgetState extends State<NavigationContentWidget> {
  List<Navi.DataBean> mNavis = [];
  Divider divider = buildGreyDivider();
  int _onTap = 0;
  final EasyRefreshController _controller = EasyRefreshController();

  @override
  void initState() {
    super.initState();
    requestNavis(-1);
  }

  void requestNavis(int type) {
    HttpClient.get(SystemHttp.navi, null).then((value) {
      Navi.NavigationBean navigation = Navi.NavigationBean.fromJson(value.data);
      if (navigation.errorCode == 0) {
        setState(() {
          mNavis.addAll(navigation.data);
          if (type == 0) {
            _controller.finishRefresh();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mNavis.length == 0) {
      return Text('');
    }
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _onTap = index;
                  setState(() {});
                },
                child: Container(
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: Center(
                      child: Text(mNavis[index].name,
                          style: TextStyle(
                              fontSize: 16,
                              color: _onTap == index
                                  ? Colors.blue
                                  : Colors.black54)),
                    )),
              );
            },
            itemExtent: 50,
            shrinkWrap: true,
            itemCount: mNavis.length,
          ),
        ),
        Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      mNavis[_onTap].name,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: Wrap(
                      children: List.generate(
                          mNavis[_onTap].articles.length,
                          (index) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: OutlinedButton(
                                    onPressed: () {},
                                    child: Text(
                                        mNavis[_onTap].articles[index].title)),
                              )),
                    )),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
