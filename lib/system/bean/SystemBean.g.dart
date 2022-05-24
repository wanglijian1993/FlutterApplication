// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SystemBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemBean _$SystemBeanFromJson(Map<String, dynamic> json) => SystemBean(
      data: (json['data'] as List<dynamic>)
          .map((e) => DataBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['errorCode'] as num,
      errorMsg: json['errorMsg'] as String,
    );

Map<String, dynamic> _$SystemBeanToJson(SystemBean instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

DataBean _$DataBeanFromJson(Map<String, dynamic> json) => DataBean(
      author: json['author'] as String,
      children: (json['children'] as List<dynamic>)
          .map((e) => ChildrenBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      courseId: json['courseId'] as num,
      cover: json['cover'] as String,
      desc: json['desc'] as String,
      id: json['id'] as num,
      lisense: json['lisense'] as String,
      lisenseLink: json['lisenseLink'] as String,
      name: json['name'] as String,
      order: json['order'] as num,
      parentChapterId: json['parentChapterId'] as num,
      userControlSetTop: json['userControlSetTop'] as bool,
      visible: json['visible'] as num,
    );

Map<String, dynamic> _$DataBeanToJson(DataBean instance) => <String, dynamic>{
      'author': instance.author,
      'children': instance.children,
      'courseId': instance.courseId,
      'cover': instance.cover,
      'desc': instance.desc,
      'id': instance.id,
      'lisense': instance.lisense,
      'lisenseLink': instance.lisenseLink,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible,
    };

ChildrenBean _$ChildrenBeanFromJson(Map<String, dynamic> json) => ChildrenBean(
      author: json['author'] as String,
      children: json['children'],
      courseId: json['courseId'] as num,
      cover: json['cover'] as String,
      desc: json['desc'] as String,
      id: json['id'] as num,
      lisense: json['lisense'] as String,
      lisenseLink: json['lisenseLink'] as String,
      name: json['name'] as String,
      order: json['order'] as num,
      parentChapterId: json['parentChapterId'] as num,
      userControlSetTop: json['userControlSetTop'] as bool,
      visible: json['visible'] as num,
    );

Map<String, dynamic> _$ChildrenBeanToJson(ChildrenBean instance) =>
    <String, dynamic>{
      'author': instance.author,
      'children': instance.children,
      'courseId': instance.courseId,
      'cover': instance.cover,
      'desc': instance.desc,
      'id': instance.id,
      'lisense': instance.lisense,
      'lisenseLink': instance.lisenseLink,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible,
    };
