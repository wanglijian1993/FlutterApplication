import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_appliciation/login/bean/LoginBean.dart';
import 'package:my_appliciation/login/bean/RegisterBean.dart';
import 'package:my_appliciation/utils/EventBusUtil.dart';
import 'package:my_appliciation/utils/LoginSingleton.dart';
import 'package:my_appliciation/utils/MyToast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../https/http_client.dart';
import '../../https/http_qeury_params.dart';
import '../../utils/Constants.dart';

/**
 * 这里我们一定会调用runApp方法，这个方法可以说是Flutter程序的入口：
 */
class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //0登录 1.注册
  int type = 0;
  final TextEditingController _account = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final TextEditingController _repwd = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void requestLoginOrRegister() async {
    if (type == 0) {
      HttpClient.post(LoginAndRegisterHttp.login, {
        'username': _account.text,
        'password': _pwd.text,
      }).then((value) {
        print('login${value.toString()}');
        LoginBean login = LoginBean.fromJson(value);
        String msg = '登录成功!';
        if (login.errorCode == 0) {
          //发送event事件
          if (login.data != null) {
            EventBusUtil.fire(login);
            LoginSingleton().isLogin = true;
            LoginSingleton().login = login.data!;
            String userInfo = json.encode(login.data!);
            _prefs
                .then((sp) => {
                      sp.setString(Constants.loginInfo, userInfo),
                      sp.setString(Constants.loginAccount, _account.text),
                      sp.setString(Constants.loginPwd, _pwd.text)
                    })
                .whenComplete(() {
              Navigator.pop(context);
            });
          }
        } else {
          msg = login.errorMsg;
        }
        toast(msg);
      });
    } else if (type == 1) {
      HttpClient.post(LoginAndRegisterHttp.regsiter, {
        'username': _account.text,
        'password': _pwd.text,
        'repassword': _repwd.text
      }).then((value) {
        print('注册${value}end');
        RegisterBean registerBean = RegisterBean.fromJson(value);
        if (registerBean.errorCode == 0) {
          toast('注册成功，请登录');
        }
        toast(registerBean.errorMsg);
        setState(() {
          type = 0;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, '登录页面关闭');
          },
          child: Icon(CupertinoIcons.back),
        ),
        centerTitle: true,
        title: Text('登录'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          top: 50,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '${type == 0 ? '用户登录' : '注册用户'}',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              '${type == 0 ? '请使用WanAndroid账户登录!' : '用户注册后才可以登录'}',
              style: TextStyle(color: Colors.black54, fontSize: 18),
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: _account,
              maxLines: 1,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: '用户名',
                hintStyle: TextStyle(color: Colors.white60),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: _pwd,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: '密码',
                  prefixIcon: Icon(Icons.lock),
                  hintStyle: TextStyle(color: Colors.white60)),
            ),
            SizedBox(
              height: 40,
            ),
            Visibility(
              visible: isVisible(),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: _repwd,
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: '再输入一次密码',
                      prefixIcon: Icon(Icons.lock),
                      hintStyle: TextStyle(color: Colors.white60)),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    requestLoginOrRegister();
                  },
                  child: Text(
                    '${type == 0 ? '登录' : '注册'}',
                    style: TextStyle(fontSize: 16),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                toast('注册成功，请登录');
                setState(() {
                  if (type == 0) {
                    type = 1;
                  } else {
                    type = 0;
                  }
                });
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text('${type == 0 ? '没有帐号? 去注册' : '已有账户? 去登录'}',
                    style: TextStyle(color: Colors.black54, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  bool isVisible() => type == 0 ? false : true;
}
