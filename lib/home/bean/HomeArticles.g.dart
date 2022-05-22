// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeArticles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeArticles _$HomeArticlesFromJson(Map<String, dynamic> json) => HomeArticles(
      data: ArticlesBean.fromJson(json['data'] as Map<String, dynamic>),
      errorCode: json['errorCode'] as num,
      errorMsg: json['errorMsg'] as String,
    );

Map<String, dynamic> _$HomeArticlesToJson(HomeArticles instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

ArticlesBean _$ArticlesBeanFromJson(Map<String, dynamic> json) => ArticlesBean(
      curPage: json['curPage'] as num,
      datas: (json['datas'] as List<dynamic>)
          .map((e) => DataBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      offset: json['offset'] as num,
      over: json['over'] as bool,
      pageCount: json['pageCount'] as num,
      size: json['size'] as num,
      total: json['total'] as num,
    );

Map<String, dynamic> _$ArticlesBeanToJson(ArticlesBean instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
    };
