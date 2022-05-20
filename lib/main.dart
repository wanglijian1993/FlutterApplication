import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:Row(
          children: [
            IconButton(onPressed: (){
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
          IconButton(onPressed: (){
            if (kDebugMode) {
              print("搜索");
            }
          }, icon:const Icon(Icons.search))
        ],
      ),
      body:Container(
        child: Column(
          children: [
            Container(
              height: 250,
            child:Swiper(
                    itemBuilder: (BuildContext context,int index){
                      return Image.asset("images/live_store_detail_live_default_bg.png",fit: BoxFit.fill);
                    },
                    itemCount: 3,
                    loop: true,
                    autoplay: true,
                    duration: 300
                )
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:  Colors.blue,
        items: const [
          BottomNavigationBarItem(icon:Icon(Icons.icecream_outlined),label: "首页"),
          BottomNavigationBarItem(icon:Icon(Icons.add_ic_call_outlined),label: "广场"),
          BottomNavigationBarItem(icon:Icon(Icons.icecream_outlined),label: "公众号"),
          BottomNavigationBarItem(icon:Icon(Icons.icecream_outlined),label: "体系"),
          BottomNavigationBarItem(icon:Icon(Icons.icecream_outlined),label: "项目"),
        ],
      ),
    );
  }
}
