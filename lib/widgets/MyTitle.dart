import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return AppBar(
      backgroundColor:
          widget.selectedIndex == 0 ? Colors.transparent : Colors.blue,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: Icon(CupertinoIcons.rectangle_stack_person_crop_fill),
      ),
      title: Text(
        widget.titles == null ? '首页' : widget.titles[widget.selectedIndex],
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 32.0),
          child: Icon(CupertinoIcons.search),
        )
      ],
      elevation: 0,
    );
  }
}
