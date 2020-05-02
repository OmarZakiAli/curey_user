import 'package:dio/dio.dart';

class ApiHelper {
  Dio dio = Dio();
  Future<Map<String, dynamic>> getData({String uri}) async {
    print(uri);
    dio.options.baseUrl = "removed this for privacy";
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    Response response = await dio.get(uri).catchError((onError) {
      print(onError.toString());
      throw "network or server problem";
    });
    if (response.statusCode == 200) {
      print(response.data.toString());
  
      return response.data;
    } else {
      throw "network or server problem";
    }
  }

  Future<Map<String, dynamic>> postData({String uri, Map body}) async {
    dio.options.baseUrl = "https://curey-backend.herokuapp.com/";
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
    Response response = await dio.post(uri, data: body).catchError((e) {
      print(e.toString());
      throw "network or server problem";
    });
    print(response.data);
    if (response.statusCode == 200) {
      print(response.data.toString());

      return response.data;
    } else {
      throw "notwork or server problem";
    }
  }
}
