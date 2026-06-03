import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:imposto/utils/app_exception.dart';

enum Method {
  get,
  put,
  post,
  delete,
  options,
}

class ApiService {
  static const String devSipecUrl = "http://localhost:8080";
  static const String prodSipecUrl = "https://sipec.w5i.com.br";
  
  static final _exceptionMap =  <int, AppException Function()>{
    400: () => BadRequestException(),
    401: () => UnauthorizedException(),
    500: () => InternalServerError(),
    404: () => NotFoundException(),
  };

  static final Map<Method, Future<http.Response> Function(Uri, {Map<String, String>? headers, Object? body})> _methodMap = {
    Method.get: (uri, {headers, body}) => http.get(uri, headers: headers),
    Method.post: (uri, {headers, body}) => http.post(uri, headers: headers, body: body),
    Method.put: (uri, {headers, body}) => http.put(uri, headers: headers, body: body),
    Method.delete: (uri, {headers, body}) => http.delete(uri, headers: headers, body: body),
    Method.options: (uri, {headers, body}) => http.Request('OPTIONS', uri).send().then(http.Response.fromStream),
  };

  /// @summary funcao post para realizacao de queries com formato get apenas obtendo
  /// @author Lucas Cid
  /// @since 27/10/2025
  static Future<T> get<T>(String url, T Function(Map<String, dynamic>) fromJson) async {
    final String apiUrl = "$prodSipecUrl$url";

    try {
      final http.Response res = await http.get(Uri.parse(apiUrl));

      final Map<String, dynamic> data = jsonDecode(res.body);

      return fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  /// @summary funcao post para realizacao de queries com formato post enviando dados
  /// @author Lucas Cid
  /// @since 27/10/2025
  static Future<T> post<T>(
    String url,
    Map<String, dynamic> payload,
  ) async {
    final parsedUrl = url.startsWith("/") ? url : '/$url';
    final String apiUrl = "$prodSipecUrl$parsedUrl";

    try {
      final http.Response res = await http.post(Uri.parse(apiUrl));
      if (res.statusCode == 401) throw Exception('Unauthorized');

      return jsonDecode(res.body) as T;
    } catch (e) {
      rethrow;
    }
  }

  /// @summary Funcao dinamica para realização de fetches com base em retorno tipado para tipagem
  /// @author Lucas Cid
  /// @since 28/10/2025
  /// @param url url da requisicao
  /// @param method metodo da requisicao
  /// @param payload, objeto em caso de post, put, delete... dados para envio via req.body
  /// @param fromJson method para transpilar o retorno da api
  /// @param headers em caso de propriedades especiais dentro dos headers da requisicao
  static Future<T> fetch <T>({
    required String url,
    required Method method,
    Map<String, dynamic>? payload,
    T Function(dynamic)? fromJson,
    Map<String, String>? headers,
  }) async {
    final jsonBody = payload != null ? jsonEncode(payload) : null;

    final http.Response res = await _methodMap[method]!(
      Uri.parse(url),
      headers: {
        'content-type' : 'application/json',
        if(headers != null) ...headers
      },
      body: jsonBody
    );
    if (_exceptionMap.containsKey(res.statusCode)) throw _exceptionMap[res.statusCode]!();

    final data = jsonDecode(res.body);

    return fromJson != null ? fromJson(data)  : data;

  }
}
