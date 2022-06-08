import 'package:my_appliciation/utils/EventBusUtil.dart';

class LoginEvent extends Event {
  bool isLogin = false;

  LoginEvent(this.isLogin);
}
