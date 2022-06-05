import '../https/http_client.dart';

/**
 * 收藏文章
 */
void toCollectArticle(num id) async {
  HttpClient.post('/lg/collect/$id/json', null).then((value) {
    print('收藏$value');
  });
}
