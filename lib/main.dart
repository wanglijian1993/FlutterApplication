import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_appliciation/project/pages/project_page.dart';
import 'package:my_appliciation/square/pages/square_page.dart';
import 'package:my_appliciation/system/pages/system_page.dart';

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
  const HomeArticesPage({Key? key}) : super(key: key);

  @override
  State<HomeArticesPage> createState() => _HomeArticesPage();
}

class _HomeArticesPage extends State<HomeArticesPage> {
  var pages = [
    buildCustomScrollView(),
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
    Widget divider = const Divider(color: Colors.grey);

    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text("标题"),
        ),
        preferredSize: Size(
            _selectedIndex == 0 ? 0 : MediaQuery.of(context).size.width,
            _selectedIndex == 0 ? 0 : AppBar().preferredSize.height),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: '首页'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square), label: '广场'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2_fill), label: '公众号'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.tree), label: '体系'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.color_filter), label: '项目'),
        ],
      ),
    );
  }
}




