// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NavigationBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigationBean _$NavigationBeanFromJson(Map<String, dynamic> json) =>
    NavigationBean(
      data: (json['data'] as List<dynamic>)
          .map((e) => DataBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['errorCode'] as num,
      errorMsg: json['errorMsg'] as String,
    );

Map<String, dynamic> _$NavigationBeanToJson(NavigationBean instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

DataBean _$DataBeanFromJson(Map<String, dynamic> json) => DataBean(
      articles: (json['articles'] as List<dynamic>)
          .map((e) => ArticlesBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      cid: json['cid'] as num,
      name: json['name'] as String,
    );

Map<String, dynamic> _$DataBeanToJson(DataBean instance) => <String, dynamic>{
      'articles': instance.articles,
      'cid': instance.cid,
      'name': instance.name,
    };

ArticlesBean _$ArticlesBeanFromJson(Map<String, dynamic> json) => ArticlesBean(
      apkLink: json['apkLink'] as String,
      audit: json['audit'] as num,
      author: json['author'] as String,
      canEdit: json['canEdit'] as bool,
      chapterId: json['chapterId'] as num,
      chapterName: json['chapterName'] as String,
      collect: json['collect'] as bool,
      courseId: json['courseId'] as num,
      desc: json['desc'] as String,
      descMd: json['descMd'] as String,
      envelopePic: json['envelopePic'] as String,
      fresh: json['fresh'] as bool,
      host: json['host'] as String,
      id: json['id'] as num,
      link: json['link'] as String,
      niceDate: json['niceDate'] as String,
      niceShareDate: json['niceShareDate'] as String,
      origin: json['origin'] as String,
      prefix: json['prefix'] as String,
      projectLink: json['projectLink'] as String,
      publishTime: json['publishTime'] as num,
      realSuperChapterId: json['realSuperChapterId'] as num,
      selfVisible: json['selfVisible'] as num,
      shareDate: json['shareDate'],
      shareUser: json['shareUser'] as String,
      superChapterId: json['superChapterId'] as num,
      superChapterName: json['superChapterName'] as String,
      tags: json['tags'],
      title: json['title'] as String,
      type: json['type'] as num,
      userId: json['userId'] as num,
      visible: json['visible'] as num,
      zan: json['zan'] as num,
    );

Map<String, dynamic> _$ArticlesBeanToJson(ArticlesBean instance) =>
    <String, dynamic>{
      'apkLink': instance.apkLink,
      'audit': instance.audit,
      'author': instance.author,
      'canEdit': instance.canEdit,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'collect': instance.collect,
      'courseId': instance.courseId,
      'desc': instance.desc,
      'descMd': instance.descMd,
      'envelopePic': instance.envelopePic,
      'fresh': instance.fresh,
      'host': instance.host,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'niceShareDate': instance.niceShareDate,
      'origin': instance.origin,
      'prefix': instance.prefix,
      'projectLink': instance.projectLink,
      'publishTime': instance.publishTime,
      'realSuperChapterId': instance.realSuperChapterId,
      'selfVisible': instance.selfVisible,
      'shareDate': instance.shareDate,
      'shareUser': instance.shareUser,
      'superChapterId': instance.superChapterId,
      'superChapterName': instance.superChapterName,
      'tags': instance.tags,
      'title': instance.title,
      'type': instance.type,
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan,
    };
