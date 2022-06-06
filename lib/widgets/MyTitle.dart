import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home/pages/SeachArtcilePage.dart';

class MyAppBar extends StatefulWidget {
  String title = "";
  int selectedIndex;
  var titles;

  MyAppBar(this.title, this.selectedIndex, {Key? key, List<String>? titles})
      : super(key: key) {
    this.titles = titles;
  }

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    bool isVisible = widget.selectedIndex == 0 ? false : true;
    return AppBar(
      leading: Visibility(
        visible: isVisible,
        child: GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Icon(CupertinoIcons.text_justify),
        ),
      ),
      backgroundColor:
          widget.selectedIndex == 0 ? Colors.transparent : Colors.blue,
      centerTitle: true,
      title: Text(
        widget.titles == null ? '首页' : widget.titles[widget.selectedIndex],
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      actions: [
        GestureDetector(
          onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return SeachArticlePage();
              }));
           },
          child:Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(CupertinoIcons.search),
          ),
        )

      ],
      elevation: 0,
    );
  }
}
