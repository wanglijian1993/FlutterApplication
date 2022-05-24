import 'package:json_annotation/json_annotation.dart';

part 'SystemBean.g.dart';

@JsonSerializable()
class SystemBean {
  List<DataBean> data;
  num errorCode;
  String errorMsg;

  SystemBean(
      {required this.data, required this.errorCode, required this.errorMsg});

  factory SystemBean.fromJson(Map<String, dynamic> json) =>
      _$SystemBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SystemBeanToJson(this);
}

@JsonSerializable()
class DataBean {
  String author;
  List<ChildrenBean> children;
  num courseId;
  String cover;
  String desc;
  num id;
  String lisense;
  String lisenseLink;
  String name;
  num order;
  num parentChapterId;
  bool userControlSetTop;
  num visible;

  DataBean(
      {required this.author,
      required this.children,
      required this.courseId,
      required this.cover,
      required this.desc,
      required this.id,
      required this.lisense,
      required this.lisenseLink,
      required this.name,
      required this.order,
      required this.parentChapterId,
      required this.userControlSetTop,
      required this.visible});

  factory DataBean.fromJson(Map<String, dynamic> json) =>
      _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}

@JsonSerializable()
class ChildrenBean {
  String author;
  dynamic children;
  num courseId;
  String cover;
  String desc;
  num id;
  String lisense;
  String lisenseLink;
  String name;
  num order;
  num parentChapterId;
  bool userControlSetTop;
  num visible;

  ChildrenBean(
      {required this.author,
      this.children,
      required this.courseId,
      required this.cover,
      required this.desc,
      required this.id,
      required this.lisense,
      required this.lisenseLink,
      required this.name,
      required this.order,
      required this.parentChapterId,
      required this.userControlSetTop,
      required this.visible});

  factory ChildrenBean.fromJson(Map<String, dynamic> json) =>
      _$ChildrenBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ChildrenBeanToJson(this);
}
