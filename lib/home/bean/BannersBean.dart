import 'package:json_annotation/json_annotation.dart';

part 'BannersBean.g.dart';

@JsonSerializable()
class BannersBean {
  List<DataBean> data;
  num errorCode;
  String errorMsg;

  BannersBean({required this.data,required this.errorCode,required this.errorMsg});

  factory BannersBean.fromJson(Map<String, dynamic> json) => _$BannersBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BannersBeanToJson(this);
}

@JsonSerializable()
class DataBean {
  String desc;
  num id;
  String imagePath;
  num isVisible;
  num order;
  String title;
  num type;
  String url;

  DataBean({required this.desc,required this.id,required this.imagePath,required this.isVisible,required this.order,required this.title,required this.type,required this.url});

  factory DataBean.fromJson(Map<String, dynamic> json) => _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}

