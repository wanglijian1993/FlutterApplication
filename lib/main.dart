import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_appliciation/home/pages/MyCoolectWdiget.dart';
import 'package:my_appliciation/https/http_client.dart';
import 'package:my_appliciation/login/bean/LoginBean.dart' as LoginBean;
import 'package:my_appliciation/login/bean/UserCoinBean.dart';
import 'package:my_appliciation/project/pages/project_page.dart';
import 'package:my_appliciation/square/pages/square_page.dart';
import 'package:my_appliciation/system/pages/system_page.dart';
import 'package:my_appliciation/utils/Constants.dart';
import 'package:my_appliciation/utils/EventBusUtil.dart';
import 'package:my_appliciation/utils/LoginSingleton.dart';
import 'package:my_appliciation/widgets/MyTitle.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<Widget>? pages;
  late int _selectedIndex = 0;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    HttpClient.init();
    isLogin();
    pages ??= [
      const HomeWidget(),
      const SquarePage(),
      const OfficialAccountPage(),
      SystemPage(),
      const ProjectPage()
    ];
  }

  void isLogin() {
    _prefs.then((sp) {
      String? loginInfo = sp.getString(Constants.loginInfo);
      if (loginInfo != null) {
        LoginBean.DataBean login =
            LoginBean.DataBean.fromJson(json.decode(loginInfo));
        LoginSingleton().isLogin = true;
        LoginSingleton().login = login;
      }
    });
  }

  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: TickerMode(
        enabled: _selectedIndex == index,
        child: pages![index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
            _selectedIndex == 0 ? 0 : MediaQuery.of(context).size.width,
            _selectedIndex == 0 ? 0 : AppBar().preferredSize.height),
        child: MyAppBar("wanAndroid", _selectedIndex, titles: widget.titles),
      ),
      body: Stack(
        children: [
          _getPagesWidget(0),
          _getPagesWidget(1),
          _getPagesWidget(2),
          _getPagesWidget(3),
          _getPagesWidget(4),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
  late StreamSubscription<LoginBean.LoginBean> _loginSubscription;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginSubscription = EventBusUtil.listen<LoginBean.LoginBean>((event) {
      requestCoin();
    })!;
    requestCoin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? account = '';
  String? pwd = '';
  String? integal='';

  void requestCoin() {
    HttpClient.get(LoginAndRegisterHttp.userCoin, null).then((value) {
      UserCoinBean userCoinBean = UserCoinBean.fromJson(value.data);
      if (userCoinBean.errorCode == 0) {
        setState(() {
          coinLevel = '${userCoinBean.data.level}';
          coinRank = '${userCoinBean.data.rank}';
          integal='${userCoinBean.data.coinCount}';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // Navigator.pop(context);
        if(!LoginSingleton().isLogin){
          Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){
            return LoginPage();
          }));
          return;
        }
      },
      child: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Icon(CupertinoIcons.person)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      LoginSingleton().isLogin
                          ? LoginSingleton().login.username
                          : '未登录',
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
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (index == 1) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return MyCoolectWdigetPage();
                        }));
                      }
                    },
                    child: Row(
                      children: [
                        Icon(mIconData[index]),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          mPortViewDatas[index],
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Visibility(
                            visible: (index==0&&LoginSingleton().isLogin) ? true:false,
                            child: Wrap(
                                children: [
                                  SizedBox(width: 20,),
                                  Text(integal!,style: TextStyle(color: Colors.blue),)
                                ],
                                )
                        )

                      ],
                    ),
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
      ),
    );
  }
}
