import 'package:dio/dio.dart';


class HttpClient{
  ///超时时间
  static const int contentTime = 30000;
  static const int receiveTime = 30000;

  static final BaseOptions baseOptions=BaseOptions(
    baseUrl: "https://www.wanandroid.com",
    connectTimeout: contentTime,
    receiveTimeout: receiveTime
  );
  static final Dio dio=Dio(baseOptions);


  /**
   * 封装Get请求
    */
 static Future get(String path, Map<String, dynamic>? queryParameters,) async{
     Response respose= await dio.request(path,queryParameters: queryParameters);
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