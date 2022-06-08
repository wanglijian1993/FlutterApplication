import 'package:my_appliciation/login/bean/LoginBean.dart';

class LoginSingleton {
  static LoginSingleton _instance = LoginSingleton._internal();

  // 私有的命名构造函数
  LoginSingleton._internal();

  factory LoginSingleton() {
    if (_instance == null) {
      _instance = LoginSingleton._internal();
    }
    return _instance;
  }

  bool isLogin = false;
  late DataBean login;

  void exitAccount() {
    isLogin = false;
  }
}
