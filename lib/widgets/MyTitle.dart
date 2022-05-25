import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(String title) {
  return AppBar(
    backgroundColor: Colors.blue,
    centerTitle: true,
    leading: Padding(
      padding: const EdgeInsets.only(left: 32.0),
      child: Icon(CupertinoIcons.rectangle_stack_person_crop_fill),
    ),
    title: Text(
      title,
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
