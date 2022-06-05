// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CollectBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectBean _$CollectBeanFromJson(Map<String, dynamic> json) => CollectBean(
      data: DataBean.fromJson(json['data'] as Map<String, dynamic>),
      errorCode: json['errorCode'] as num,
      errorMsg: json['errorMsg'] as String,
    );

Map<String, dynamic> _$CollectBeanToJson(CollectBean instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

DataBean _$DataBeanFromJson(Map<String, dynamic> json) => DataBean(
      curPage: json['curPage'] as num,
      datas: (json['datas'] as List<dynamic>)
          .map((e) => DatasBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      offset: json['offset'] as num,
      over: json['over'] as bool,
      pageCount: json['pageCount'] as num,
      size: json['size'] as num,
      total: json['total'] as num,
    );

Map<String, dynamic> _$DataBeanToJson(DataBean instance) => <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
    };

DatasBean _$DatasBeanFromJson(Map<String, dynamic> json) => DatasBean(
      author: json['author'] as String,
      chapterId: json['chapterId'] as num,
      chapterName: json['chapterName'] as String,
      courseId: json['courseId'] as num,
      desc: json['desc'] as String,
      envelopePic: json['envelopePic'] as String,
      id: json['id'] as num,
      link: json['link'] as String,
      niceDate: json['niceDate'] as String,
      origin: json['origin'] as String,
      originId: json['originId'] as num,
      publishTime: json['publishTime'] as num,
      title: json['title'] as String,
      userId: json['userId'] as num,
      visible: json['visible'] as num,
      zan: json['zan'] as num,
    );

Map<String, dynamic> _$DatasBeanToJson(DatasBean instance) => <String, dynamic>{
      'author': instance.author,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'courseId': instance.courseId,
      'desc': instance.desc,
      'envelopePic': instance.envelopePic,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'origin': instance.origin,
      'originId': instance.originId,
      'publishTime': instance.publishTime,
      'title': instance.title,
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan,
    };
