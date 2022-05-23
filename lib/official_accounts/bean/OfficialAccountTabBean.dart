import 'package:json_annotation/json_annotation.dart';

part 'OfficialAccountTabBean.g.dart';

@JsonSerializable()
class OfficialAccountTabBean {
  List<DataBean> data;
  num errorCode;
  String errorMsg;

  OfficialAccountTabBean(
      {required this.data, required this.errorCode, required this.errorMsg});

  factory OfficialAccountTabBean.fromJson(Map<String, dynamic> json) =>
      _$OfficialAccountTabBeanFromJson(json);

  Map<String, dynamic> toJson() => _$OfficialAccountTabBeanToJson(this);
}

@JsonSerializable()
class DataBean {
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

  DataBean(
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

  factory DataBean.fromJson(Map<String, dynamic> json) =>
      _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}
