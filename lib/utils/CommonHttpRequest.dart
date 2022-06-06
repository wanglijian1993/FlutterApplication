import 'dart:collection';

import 'package:my_appliciation/home/bean/CollectBean.dart';
import 'package:my_appliciation/utils/MyToast.dart';

import '../https/http_client.dart';

void toCollectOperation(bool collect,num id){
  if(collect){
    toUnCollectArticle(id);
  }else {
    toCollectArticle(id);
  }
}

/**
 * 收藏文章
 */
void toCollectArticle(num id) async {
   HttpClient.post('/lg/collect/$id/json', null).then((value) {
    CollectBean collectBean=CollectBean.fromJson(value.data);
    if(collectBean.errorCode==0){
          toast("收藏成功");
    }
  });
}
/**
 * 取消收藏
 */
void toUnCollectArticle(num id) async {
  Map<String,dynamic> params={};
  params['id']=id;
  HttpClient.post('/lg/collect/deletetool/json',params).then((value) {
     CollectBean collectBean=CollectBean.fromJson(value.data);
     if(collectBean.errorCode==0){
       toast("取消收藏");
     }
  });
}
