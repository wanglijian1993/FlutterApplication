import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

class HttpClient {
  ///超时时间
  static const int contentTime = 30000;
  static const int receiveTime = 30000;

  static final BaseOptions baseOptions = BaseOptions(
      baseUrl: "https://www.wanandroid.com",
      connectTimeout: contentTime,
      receiveTimeout: receiveTime);
  static final Dio dio = Dio(baseOptions);

  static init() {
    var cookieJar = getCookieJar();
    cookieJar.then((cookieJar) {
      dio.interceptors.add(CookieManager(cookieJar));
    });
  }

  static Future<PersistCookieJar> getCookieJar() async {
    Directory tempDir = await getTemporaryDirectory();
    var tempPath = tempDir.path;
    var cj =
        PersistCookieJar(ignoreExpires: true, storage: FileStorage(tempPath));
    return cj;
  }

  /**
   * 封装Get请求
   */
  static Future get(
    String path,
    Map<String, dynamic>? queryParameters,
  ) async {
    Response respose =
        await dio.request(path, queryParameters: queryParameters);
    return respose;
  }

  /**
   * 封装post请求
   */
  static Future post(String path, Map<String, dynamic>? queryParameters) async{
    Response respose= await dio.post(path,queryParameters: queryParameters);
    return respose.data;
  }
}