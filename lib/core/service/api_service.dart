import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> post(
      {required String url,
      required dynamic body,
      required String token,
      Map<String, dynamic>? headers,
      String? contentType}) async {
    final response = await _dio.post(
      url,
      data: body,
      options: Options(
        contentType: contentType,
        headers: headers ??
            {
              'Authorization': 'Bearer $token',
            },
      ),
    );
    return response;
  }
}
