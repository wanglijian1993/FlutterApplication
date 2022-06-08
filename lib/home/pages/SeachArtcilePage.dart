import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_appliciation/home/bean/HotWoldBean.dart';
import 'package:my_appliciation/https/http_client.dart';
import 'package:sqflite/sqflite.dart';

import '../../https/http_qeury_params.dart';
import '../../utils/HistoryDbHelper.dart';
import 'SeachDetailPage.dart';

/**
 * 搜索界面
 */
class SeachArticlePage extends StatefulWidget {
  const SeachArticlePage({Key? key}) : super(key: key);

  @override
  State<SeachArticlePage> createState() => _SeachArticlePageState();
}

class _SeachArticlePageState extends State<SeachArticlePage> {
  final TextEditingController _seachControl = TextEditingController();
  List<DataBean> hotWords = [];
  List<String> histories = [];
  Database? historyDb;

  @override
  void initState() {
    super.initState();
    initHistories();
    requestHotWold();
  }

  void initHistories() async {
    HistoryDbHelper.getInstance().openDb();
    histories.addAll(await HistoryDbHelper.getInstance().queryHistry());
  }

  @override
  void dispose() {
    super.dispose();
    historyDb?.close();
  }

  void requestHotWold() {
    HttpClient.post(HttpQueryParams.HotWord, null).then((value) {
      HotWoldBean hotWold = HotWoldBean.fromJson(value);
      if (hotWold.errorCode == 0) {
        setState(() {
          hotWords.addAll(hotWold.data);
        });
      }
    });
  }

  clearHistory() async {
    await HistoryDbHelper.getInstance().clearContent_DB();
    setState(() {
      histories.clear();
    });
  }

  insertHistory() async {
    await HistoryDbHelper.getInstance().insertToHistryDb(_seachControl.text);
    setState(() {
      if (!histories.contains(_seachControl.text)) {
        histories.add(_seachControl.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: TextField(
            controller: _seachControl,
            maxLines: 1,
            style: TextStyle(color: Colors.white, fontSize: 16),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '输入想要搜索的内容',
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
             if(_seachControl.text.isNotEmpty) {
                insertHistory();
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return SeachDetailPage(_seachControl.text);
                }));
              }
            },
            child: Icon(CupertinoIcons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:15.0,right: 15,top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('热词',style: TextStyle(color: Colors.blue,fontSize: 20),),
            const SizedBox(height: 10,),
            Wrap(
              children: List.generate(hotWords.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      hotWords[index].name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 30,
              child: Center(
                child: Stack(children: [
                  Text(
                    '搜索历史',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      clearHistory();
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '清空历史记录',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  )
                ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              children: List.generate(histories.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    histories[index],
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

}
