import 'package:json_annotation/json_annotation.dart';

part 'HotWoldBean.g.dart';

@JsonSerializable()
class HotWoldBean {
  List<DataBean> data;
  num errorCode;
  String errorMsg;

  HotWoldBean({required this.data, required this.errorCode, required this.errorMsg});

  factory HotWoldBean.fromJson(Map<String, dynamic> json) => _$HotWoldBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HotWoldBeanToJson(this);
}

@JsonSerializable()
class DataBean {
  num id;
  String link;
  String name;
  num order;
  num visible;

  DataBean({required this.id, required this.link, required this.name, required this.order, required this.visible});

  factory DataBean.fromJson(Map<String, dynamic> json) => _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}

