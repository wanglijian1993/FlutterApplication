import 'package:json_annotation/json_annotation.dart';

part 'CollectBean.g.dart';

@JsonSerializable()
class CollectBean {
  DataBean data;
  num errorCode;
  String errorMsg;

  CollectBean(
      {required this.data, required this.errorCode, required this.errorMsg});

  factory CollectBean.fromJson(Map<String, dynamic> json) =>
      _$CollectBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CollectBeanToJson(this);
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
  String author;
  num chapterId;
  String chapterName;
  num courseId;
  String desc;
  String envelopePic;
  num id;
  String link;
  String niceDate;
  String origin;
  num originId;
  num publishTime;
  String title;
  num userId;
  num visible;
  num zan;

  DatasBean(
      {required this.author,
      required this.chapterId,
      required this.chapterName,
      required this.courseId,
      required this.desc,
      required this.envelopePic,
      required this.id,
      required this.link,
      required this.niceDate,
      required this.origin,
      required this.originId,
      required this.publishTime,
      required this.title,
      required this.userId,
      required this.visible,
      required this.zan});

  factory DatasBean.fromJson(Map<String, dynamic> json) =>
      _$DatasBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DatasBeanToJson(this);
}
