import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_appliciation/project/pages/project_page.dart';
import 'package:my_appliciation/square/pages/square_page.dart';
import 'package:my_appliciation/system/pages/system_page.dart';
import 'package:my_appliciation/widgets/MyTitle.dart';

import 'home/pages/home_articles_page.dart';
import 'official_accounts/pages/official_account_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  StatelessElement createElement() {
    // TODO: implement createElement
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
  var pages = [
    HomeWidget(),
    SquarePage(),
    OfficialAccountPage(),
    SystemPage(),
    ProjectPage()
  ];
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
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
    print('index:$_selectedIndex');
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
    );
  }
}




