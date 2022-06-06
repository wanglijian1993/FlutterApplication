

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_appliciation/home/bean/HotWoldBean.dart';
import 'package:my_appliciation/https/http_client.dart';
import 'package:sqflite/sqflite.dart';

import '../../https/http_qeury_params.dart';

/**
 * 搜索界面
 */
class SeachArticlePage extends StatefulWidget {
  const SeachArticlePage({Key? key}) : super(key: key);


  @override
  State<SeachArticlePage> createState() => _SeachArticlePageState();

}

class _SeachArticlePageState extends State<SeachArticlePage> {
  final TextEditingController _seachControl=TextEditingController();
  List<DataBean> hotWords=[];
  List<String> histories=[];
  final String _dbName='history';
  final String _seachKey='name';

  late Database historyDb;

  @override
  void initState() {
    super.initState();
    initDb();
    queryHistry();
    requestHotWold();
  }

  @override
  void dispose() {
    super.dispose();
    historyDb.close();
  }

  void initDb()async{
    historyDb=await openDatabase('history.db');
    historyDb.execute('CREATE TABLE $_dbName (id INTEGER PRIMARY KEY, $_seachKey TEXT)');
  }
  
  void insertToHistryDb(String value){
    historyDb.insert(_dbName, {_seachKey:value});
  }
  
  void clearContent_DB()async{
    historyDb.execute('DELETE FROM $_dbName');
  }

  void closeDb() async{
    await historyDb.close();
  }

  void queryHistry()async{

    List<Map<String, dynamic>> resul = await historyDb.query(_dbName,distinct: true,orderBy: 'name asc',limit: 8);
    print('result$resul');

  }



  void requestHotWold(){
    HttpClient.post(HttpQueryParams.HotWord, null).then((value){
      HotWoldBean hotWold=HotWoldBean.fromJson(value);
      if(hotWold.errorCode==0){
        setState(() {
          hotWords.addAll(hotWold.data);
        });
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
            decoration: const InputDecoration(
                border: InputBorder.none,
              hintText: '输入想要搜索的内容',
              hintStyle: TextStyle(color: Colors.white)
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
             if(_seachControl.text.isNotEmpty){
               insertToHistryDb(_seachControl.text);
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
              children:List.generate(hotWords.length, (index){
                return Padding(padding: const EdgeInsets.only(right: 20),
                child:Text(hotWords[index].name,style: const TextStyle(fontSize: 16),),
                );
              }),
            ),
            const SizedBox(height: 30,),
            const Text('搜索历史',style: TextStyle(color: Colors.blue,fontSize: 20),),
            const SizedBox(height: 10,),
            Wrap(
              children: List.generate(histories.length, (index){
                return Padding(padding: const EdgeInsets.only(right: 20),
                  child:Text(histories[index],style: const TextStyle(fontSize: 16),),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

}
