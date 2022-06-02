import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_appliciation/https/http_client.dart';
import 'package:my_appliciation/login/bean/LoginBean.dart';
import 'package:my_appliciation/login/bean/UserCoinBean.dart';
import 'package:my_appliciation/project/pages/project_page.dart';
import 'package:my_appliciation/square/pages/square_page.dart';
import 'package:my_appliciation/system/pages/system_page.dart';
import 'package:my_appliciation/utils/EventBusUtil.dart';
import 'package:my_appliciation/utils/LoginSingleton.dart';
import 'package:my_appliciation/widgets/MyTitle.dart';

import 'home/pages/home_articles_page.dart';
import 'https/http_qeury_params.dart';
import 'login/pages/Login.dart';
import 'official_accounts/pages/official_account_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  StatelessElement createElement() {
    return super.createElement();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeArticesPage(),
    );
  }
}

class HomeArticesPage extends StatefulWidget {
  HomeArticesPage({Key? key}) : super(key: key);
  var titles = ['首页', '广场', '公众号', '体系', '项目'];

  @override
  State<HomeArticesPage> createState() => _HomeArticesPage();
}

class _HomeArticesPage extends State<HomeArticesPage> {
  var pages;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    var home = const HomeWidget();
    var square = const SquarePage();
    var officialAccount = const OfficialAccountPage();
    var system = const SystemPage();
    var project = const ProjectPage();
    pages = [home, square, officialAccount, system, project];
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('main build');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
            _selectedIndex == 0 ? 0 : MediaQuery.of(context).size.width,
            _selectedIndex == 0 ? 0 : AppBar().preferredSize.height),
        child: MyAppBar("wanAndroid", _selectedIndex, titles: widget.titles),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: widget.titles[0]),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square), label: widget.titles[1]),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2_fill),
              label: widget.titles[2]),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.tree), label: widget.titles[3]),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.color_filter), label: widget.titles[4]),
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<String> mPortViewDatas = [
    '我的积分',
    '我的收藏',
    '我的分享',
    'TODO',
    '夜间模式',
    '系统设置'
  ];
  List<IconData> mIconData = [
    CupertinoIcons.squares_below_rectangle,
    CupertinoIcons.heart_circle,
    CupertinoIcons.share,
    CupertinoIcons.today,
    CupertinoIcons.moon_circle,
    CupertinoIcons.settings
  ];
  String coinLevel = "--";
  String coinRank = "--";
  late StreamSubscription<LoginBean> _loginSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginSubscription = EventBusUtil.listen<LoginBean>((event) {
      requestCoin();
    })!;
    requestCoin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void requestCoin() {
    if (LoginSingleton().isLogin) {
      HttpClient.get(LoginAndRegisterHttp.userCoin, null).then((value) {
        UserCoinBean userCoinBean = UserCoinBean.fromJson(value.data);
        if (userCoinBean.errorCode == 0) {
          setState(() {
            coinLevel = '${userCoinBean.data.level}';
            coinRank = '${userCoinBean.data.rank}';
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: GestureDetector(
              onTap: () async {
                // Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return LoginPage();
                }));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Icon(CupertinoIcons.person)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${LoginSingleton().isLogin ? LoginSingleton().login.data?.username : '未登录'}',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('等级:${coinLevel}',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      SizedBox(
                        width: 8,
                      ),
                      Text('排名:${coinRank}',
                          style: TextStyle(fontSize: 16, color: Colors.white))
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, top: 20),
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Icon(mIconData[index]),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      mPortViewDatas[index],
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                );
              },
              itemCount: mPortViewDatas.length,
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 40,
              ),
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
