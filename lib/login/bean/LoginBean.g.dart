// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBean _$LoginBeanFromJson(Map<String, dynamic> json) => LoginBean(
      data: DataBean.fromJson(json['data'] as Map<String, dynamic>),
      errorCode: json['errorCode'] as num,
      errorMsg: json['errorMsg'] as String,
    );

Map<String, dynamic> _$LoginBeanToJson(LoginBean instance) => <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

DataBean _$DataBeanFromJson(Map<String, dynamic> json) => DataBean(
      admin: json['admin'] as bool,
      chapterTops: json['chapterTops'],
      coinCount: json['coinCount'] as num,
      collectIds:
          (json['collectIds'] as List<dynamic>).map((e) => e as num).toList(),
      email: json['email'] as String,
      icon: json['icon'] as String,
      id: json['id'] as num,
      nickname: json['nickname'] as String,
      password: json['password'] as String,
      publicName: json['publicName'] as String,
      token: json['token'] as String,
      type: json['type'] as num,
      username: json['username'] as String,
    );

Map<String, dynamic> _$DataBeanToJson(DataBean instance) => <String, dynamic>{
      'admin': instance.admin,
      'chapterTops': instance.chapterTops,
      'coinCount': instance.coinCount,
      'collectIds': instance.collectIds,
      'email': instance.email,
      'icon': instance.icon,
      'id': instance.id,
      'nickname': instance.nickname,
      'password': instance.password,
      'publicName': instance.publicName,
      'token': instance.token,
      'type': instance.type,
      'username': instance.username,
    };
