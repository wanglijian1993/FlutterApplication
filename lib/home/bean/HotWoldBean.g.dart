// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HotWoldBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotWoldBean _$HotWoldBeanFromJson(Map<String, dynamic> json) => HotWoldBean(
      data: (json['data'] as List<dynamic>)
          .map((e) => DataBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['errorCode'] as num,
      errorMsg: json['errorMsg'] as String,
    );

Map<String, dynamic> _$HotWoldBeanToJson(HotWoldBean instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

DataBean _$DataBeanFromJson(Map<String, dynamic> json) => DataBean(
      id: json['id'] as num,
      link: json['link'] as String,
      name: json['name'] as String,
      order: json['order'] as num,
      visible: json['visible'] as num,
    );

Map<String, dynamic> _$DataBeanToJson(DataBean instance) => <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
      'name': instance.name,
      'order': instance.order,
      'visible': instance.visible,
    };
