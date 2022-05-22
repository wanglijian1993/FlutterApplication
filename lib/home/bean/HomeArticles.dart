import 'package:json_annotation/json_annotation.dart';

import 'HomeHotArticles.dart';

part 'HomeArticles.g.dart';

@JsonSerializable()
class HomeArticles {
  ArticlesBean data;
  num errorCode;
  String errorMsg;

  HomeArticles({required this.data, required this.errorCode,required this.errorMsg});

  factory HomeArticles.fromJson(Map<String, dynamic> json) => _$HomeArticlesFromJson(json);

  Map<String, dynamic> toJson() => _$HomeArticlesToJson(this);
}

@JsonSerializable()
class ArticlesBean {
  num curPage;
  List<DataBean> datas;
  num offset;
  bool over;
  num pageCount;
  num size;
  num total;

  ArticlesBean({required this.curPage,required this.datas,required this.offset,required this.over,required this.pageCount,required this.size,required this.total});

  factory ArticlesBean.fromJson(Map<String, dynamic> json) => _$ArticlesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesBeanToJson(this);
}


