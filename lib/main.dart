import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'home/bean/BannersBean.dart';
import 'home/http/http_qeury_params.dart';
import 'https/http_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wanAndroidApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '首页'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);




  @override
  State<MyHomePage> createState() => _MyHomePageState();


}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget divider = const Divider(color: Colors.grey);

    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(divider),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }

  /**
   * build body
   */
  Column buildBody(Widget divider) {
    return
      Column(
        children: [
          buildBanners(),
          buildArticlesWidget()
        ],
      );
  }

  RefreshIndicator buildArticlesWidget() {
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      color: Colors.white,
      backgroundColor: Colors.blue,
      strokeWidth: 4.0,
      onRefresh: () async {
        print('刷新');
      },
          child:FutureBuilder(
            future:_requestBody(0),
            builder:(BuildContext context,AsyncSnapshot snapshot){
              print('网络请求状态${snapshot.connectionState}');
              print('网络请求状态${snapshot.data}');
              if (snapshot.connectionState == ConnectionState.done) {


              }
              return ListView.separated("网络");
            },
          )
    );

  }

  /**
   * Performing multiple concurrent requests by future
   */
  Future _requestBody(int index) async{
    return Future.wait([HttpClient.get(HttpQueryParams.HotArticle, null),
      HttpClient.get('/article/list/$index/json', null)]);
  }

  /**
   * build appbar
   */
  AppBar buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          IconButton(onPressed: () {
            if (kDebugMode) {
              print("点击展示个人信息");
            }
          }, icon: const Icon(Icons.person)),
          const SizedBox(width: 30),
          const Text("wanAndroidApp"),
          Column()
        ],
      ),
      actions: [
        IconButton(onPressed: () {
          if (kDebugMode) {
            print("搜索");
          }
        }, icon: const Icon(Icons.search))
      ],
    );
  }

  /**
   * banners
   */
  Container buildBanners() {
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
      future: HttpClient.get(HttpQueryParams.bannerQuery, null),
      builder: (BuildContext context, AsyncSnapshot snapshot){
          //请求完成
        if (snapshot.connectionState == ConnectionState.done) {
          Response response = snapshot.data;
          //发生错误
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
         var banners= BannersBean.fromJson(response.data);
          //请求成功，通过项目信息构建用于显示项目名称的ListView
          return SizedBox(
              height: 230,
              child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                        banners.data[index].imagePath,
                        fit: BoxFit.fill);
                  },
                  itemCount: banners.data.length,
                  loop: true,
                  autoplay: true,
                  duration: 300
              )
          );;
        }
        //请求未完成时弹出loading
        return const CircularProgressIndicator();
      },
      ),
    );
  }
}

/**
 * navigationBar
 */
class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyBottomNavigationBar();
  }

}

class _MyBottomNavigationBar extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedIndex,
      showUnselectedLabels: true,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.icecream_outlined), label: '首页'),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_ic_call_outlined), label: '广场'),
        BottomNavigationBarItem(
            icon: Icon(Icons.icecream_outlined), label: '公众号'),
        BottomNavigationBarItem(
            icon: Icon(Icons.icecream_outlined), label: '体系'),
        BottomNavigationBarItem(
            icon: Icon(Icons.icecream_outlined), label: '项目'),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}