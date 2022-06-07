import 'package:json_annotation/json_annotation.dart';

part 'SeachDetailBean.g.dart';

@JsonSerializable()
class SeachDetailBean {
  DataBean data;
  num errorCode;
  String errorMsg;

  SeachDetailBean(
      {required this.data, required this.errorCode, required this.errorMsg});

  factory SeachDetailBean.fromJson(Map<String, dynamic> json) =>
      _$SeachDetailBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SeachDetailBeanToJson(this);
}

@JsonSerializable()
class DataBean {
  num curPage;
  List<DatasBean> datas;
  num offset;
  bool over;
  num pageCount;
  num size;
  num total;

  DataBean(
      {required this.curPage,
      required this.datas,
      required this.offset,
      required this.over,
      required this.pageCount,
      required this.size,
      required this.total});

  factory DataBean.fromJson(Map<String, dynamic> json) =>
      _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}

@JsonSerializable()
class DatasBean {
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

  DatasBean(
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
      required this.shareDate,
      required this.shareUser,
      required this.superChapterId,
      required this.superChapterName,
      this.tags,
      required this.title,
      required this.type,
      required this.userId,
      required this.visible,
      required this.zan});

  factory DatasBean.fromJson(Map<String, dynamic> json) =>
      _$DatasBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DatasBeanToJson(this);
}
