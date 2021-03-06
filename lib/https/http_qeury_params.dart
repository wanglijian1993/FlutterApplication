class HttpQueryParams {
  //轮播图
  static const String bannerQuery = '/banner/json';

  //热门文章
  static const String HotArticle = "/article/top/json";

  //热词
  static const String HotWord='/hotkey/json';
}

class AffAccountHttp {
  static const String OfficialAccount = '/wxarticle/chapters/json';
}

class SystemHttp {
  static const String system = '/tree/json';
  static const String navi = '/navi/json';
}

class ProjectHttp {
  static const String projectTree = '/project/tree/json';
}

class LoginAndRegisterHttp {
  static const String login = '/user/login';
  static const String regsiter = '/user/register';
  static const String exitLogin = '/user/logout/json';
  static const String userCoin = '/lg/coin/userinfo/json';
  static const String exitAccount = '/user/logout/json';
}