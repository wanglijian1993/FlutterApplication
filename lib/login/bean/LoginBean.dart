import 'package:json_annotation/json_annotation.dart';
import 'package:my_appliciation/utils/EventBusUtil.dart';

part 'LoginBean.g.dart';

@JsonSerializable()
class LoginBean extends Event {
  DataBean? data;
  num errorCode;
  String errorMsg;

  LoginBean(
      {required this.data, required this.errorCode, required this.errorMsg});

  factory LoginBean.fromJson(Map<String, dynamic> json) =>
      _$LoginBeanFromJson(json);

  Map<String, dynamic> toJson() => _$LoginBeanToJson(this);
}

@JsonSerializable()
class DataBean {
  bool admin;
  dynamic chapterTops;
  num coinCount;
  List<num> collectIds;
  String email;
  String icon;
  num id;
  String nickname;
  String password;
  String publicName;
  String token;
  num type;
  String username;

  DataBean(
      {required this.admin,
      this.chapterTops,
      required this.coinCount,
      required this.collectIds,
      required this.email,
      required this.icon,
      required this.id,
      required this.nickname,
      required this.password,
      required this.publicName,
      required this.token,
      required this.type,
      required this.username});

  factory DataBean.fromJson(Map<String, dynamic> json) =>
      _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}
