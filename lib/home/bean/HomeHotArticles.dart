import 'package:json_annotation/json_annotation.dart';

part 'HomeHotArticles.g.dart';

@JsonSerializable()
class HomeHotArticles {
  List<DataBean> data;
  num errorCode;
  String errorMsg;

  HomeHotArticles({required this.data, required this.errorCode, required this.errorMsg});

  factory HomeHotArticles.fromJson(Map<String, dynamic> json) => _$HomeHotArticlesFromJson(json);

  Map<String, dynamic> toJson() => _$HomeHotArticlesToJson(this);
}

@JsonSerializable()
class DataBean {
  String apkLink;
  num audit;
  String author;
  bool canEdit;
  num chapterId;
  String chapterName;
  bool collect;
  num courseId;
  String desc;
  String descMd;
  String envelopePic;
  bool fresh;
  String host;
  num id;
  String link;
  String niceDate;
  String niceShareDate;
  String origin;
  String prefix;
  String projectLink;
  num publishTime;
  num realSuperChapterId;
  num selfVisible;
  num shareDate;
  String shareUser;
  num superChapterId;
  String superChapterName;
  dynamic tags;
  String title;
  num type;
  num userId;
  num visible;
  num zan;

  DataBean({required this.apkLink,required this.audit,required this.author,required this.canEdit, required this.chapterId, required this.chapterName, required this.collect, required this.courseId, required this.desc, required this.descMd, required this.envelopePic,required this.fresh,required this.host, required this.id, required this.link, required this.niceDate, required this.niceShareDate, required this.origin, required this.prefix,required this.projectLink, required this.publishTime, required this.realSuperChapterId,required this.selfVisible, required this.shareDate, required this.shareUser, required this.superChapterId, required this.superChapterName, this.tags, required this.title, required this.type, required this.userId,required this.visible, required this.zan});

  factory DataBean.fromJson(Map<String, dynamic> json) => _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}

