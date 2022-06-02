// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserCoinBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCoinBean _$UserCoinBeanFromJson(Map<String, dynamic> json) => UserCoinBean(
      data: DataBean.fromJson(json['data'] as Map<String, dynamic>),
      errorCode: json['errorCode'] as num,
      errorMsg: json['errorMsg'] as String,
    );

Map<String, dynamic> _$UserCoinBeanToJson(UserCoinBean instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

DataBean _$DataBeanFromJson(Map<String, dynamic> json) => DataBean(
      coinCount: json['coinCount'] as num,
      level: json['level'] as num,
      nickname: json['nickname'] as String,
      rank: json['rank'] as String,
      userId: json['userId'] as num,
      username: json['username'] as String,
    );

Map<String, dynamic> _$DataBeanToJson(DataBean instance) => <String, dynamic>{
      'coinCount': instance.coinCount,
      'level': instance.level,
      'nickname': instance.nickname,
      'rank': instance.rank,
      'userId': instance.userId,
      'username': instance.username,
    };
