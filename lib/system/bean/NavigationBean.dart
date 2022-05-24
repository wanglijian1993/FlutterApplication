import 'package:json_annotation/json_annotation.dart';

part 'NavigationBean.g.dart';

@JsonSerializable()
class NavigationBean {
  List<DataBean> data;
  num errorCode;
  String errorMsg;

  NavigationBean(
      {required this.data, required this.errorCode, required this.errorMsg});

  factory NavigationBean.fromJson(Map<String, dynamic> json) =>
      _$NavigationBeanFromJson(json);

  Map<String, dynamic> toJson() => _$NavigationBeanToJson(this);
}

@JsonSerializable()
class DataBean {
  List<ArticlesBean> articles;
  num cid;
  String name;

  DataBean({required this.articles, required this.cid, required this.name});

  factory DataBean.fromJson(Map<String, dynamic> json) =>
      _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}

@JsonSerializable()
class ArticlesBean {
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
  dynamic shareDate;
  String shareUser;
  num superChapterId;
  String superChapterName;
  dynamic tags;
  String title;
  num type;
  num userId;
  num visible;
  num zan;

  ArticlesBean(
      {required this.apkLink,
      required this.audit,
      required this.author,
      required this.canEdit,
      required this.chapterId,
      required this.chapterName,
      required this.collect,
      required this.courseId,
      required this.desc,
      required this.descMd,
      required this.envelopePic,
      required this.fresh,
      required this.host,
      required this.id,
      required this.link,
      required this.niceDate,
      required this.niceShareDate,
      required this.origin,
      required this.prefix,
      required this.projectLink,
      required this.publishTime,
      required this.realSuperChapterId,
      required this.selfVisible,
      this.shareDate,
      required this.shareUser,
      required this.superChapterId,
      required this.superChapterName,
      this.tags,
      required this.title,
      required this.type,
      required this.userId,
      required this.visible,
      required this.zan});

  factory ArticlesBean.fromJson(Map<String, dynamic> json) =>
      _$ArticlesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesBeanToJson(this);
}
