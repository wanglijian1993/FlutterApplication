import 'package:json_annotation/json_annotation.dart';

part 'UserCoinBean.g.dart';

@JsonSerializable()
class UserCoinBean {
  DataBean data;
  num errorCode;
  String errorMsg;

  UserCoinBean(
      {required this.data, required this.errorCode, required this.errorMsg});

  factory UserCoinBean.fromJson(Map<String, dynamic> json) =>
      _$UserCoinBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserCoinBeanToJson(this);
}

@JsonSerializable()
class DataBean {
  num coinCount;
  num level;
  String nickname;
  String rank;
  num userId;
  String username;

  DataBean(
      {required this.coinCount,
      required this.level,
      required this.nickname,
      required this.rank,
      required this.userId,
      required this.username});

  factory DataBean.fromJson(Map<String, dynamic> json) =>
      _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}
