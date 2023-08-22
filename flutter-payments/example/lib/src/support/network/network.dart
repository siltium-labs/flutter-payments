// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'content_type_enum.dart';
import 'http_method_enum.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'network_request.dart';
import 'network_response.dart';

enum HttpCodesEnum {
  NoInternetConnection,
  s204_NoContent,
  e400_BadRequest,
  e401_Unauthorized,
  e402_PaymentRequired,
  e403_Forbidden,
  e404_NotFound,
  e405_MethodNotAllowed,
  e406_NotAcceptable,
  e407_ProxyAuthenticationRequired,
  e408_RequestTimeout,
  e409_Conflict,
  e410_Gone,
  e411_LengthRequired,
  e412_PreconditionFailed,
  e413_PayloadTooLarge,
  e414_URITooLong,
  e415_UnsupportedMediaType,
  e416_RangeNotSatisfiable,
  e417_ExpectationFailed,
  e418_ImAteapot,
  e422_UnprocessableEntity,
  e425_TooEarly,
  e426_UpgradeRequired,
  e428_PreconditionRequired,
  e429_TooManyRequests,
  e431_RequestHeaderFieldsTooLarge,
  e451_UnavailableForLegalReasons,
  e500_InternalServerError,
  e501_NotImplemented,
  e502_BadGateway,
  e503_ServiceUnavailable,
  e504_GatewayTimeout,
  e505_HTTPVersionNotSupported,
  e506_VariantAlsoNegotiates,
  e507_InsufficientStorage,
  e508_LoopDetected,
  e510_NotExtended,
  e511_NetworkAuthenticationRequired
}

class HttpResult implements Exception {
  final String msg;
  final HttpCodesEnum type;
  const HttpResult({this.msg = "", required this.type});
  @override
  String toString() => 'Error: $msg';
}

class Network {
  static final Network _singleton = Network._internal();
  static const maxConnectionAttempts = 1;
  String? token;
  //var _dioCacheManager = DioCacheManager(CacheConfig());

  final _options = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.request,
    hitCacheOnErrorExcept: [401, 403],
    maxStale: const Duration(minutes: 5),
    priority: CachePriority.normal,
    cipher: null,
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    allowPostMethod: false,
  );

  factory Network() {
    return _singleton;
  }

  Network._internal();

  setToken(String token) {
    this.token = token;
  }

  Future checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return;
      }
    } catch (e) {
      throw const HttpResult(type: HttpCodesEnum.NoInternetConnection);
    }

    throw const HttpResult(type: HttpCodesEnum.NoInternetConnection);
  }

  Future<NetworkResponse?> callApi(NetworkRequest request) async {
    try {
      await checkInternetConnection();
      Response? response;

      switch (request.httpMethod) {
        case HttpMethodEnum.httpGet:
          response = await _get(request);
          break;
        case HttpMethodEnum.httpPost:
          response = await _post(request);
          break;
        case HttpMethodEnum.httpPut:
          response = await _put(request);
          break;
        case HttpMethodEnum.httpDelete:
          response = await _delete(request);
          break;
      }

      return _processResult(response!);
    } on DioError catch (er) {
      _processStatusCode(er.response);
    } on Exception {
      rethrow;
    }

    return null;
  }

  Object? _buildRequestData({
    required ContentTypeEnum contentTypeEnum,
    String? jsonBody,
    Map<String, File>? files,
  }) {
    Map<String, dynamic> formData = {};
    switch (contentTypeEnum) {
      case ContentTypeEnum.applicationJsonUtf8:
        return jsonBody;
      case ContentTypeEnum.multipartDataForm:
        if (jsonBody != null) {
          formData["application/json"] = jsonBody;
        }
        if ((files ?? {}).isNotEmpty) {
          for (String fileCode in files!.keys) {
            formData[fileCode] = MultipartFile.fromFile(
              files[fileCode]!.path,
              contentType: MediaType(
                "image",
                extension(files[fileCode]!.path).isEmpty
                    ? "jpg"
                    : extension(files[fileCode]!.path),
              ),
            );
          }
        }
        return FormData.fromMap(formData);
    }
  }

  String getContentTypeString(ContentTypeEnum contentTypeEnum) {
    switch (contentTypeEnum) {
      case ContentTypeEnum.applicationJsonUtf8:
        return "application/json charset=utf-8";
      case ContentTypeEnum.multipartDataForm:
        return "multipart/form-data";
    }
  }

  Future<Response?> _get(NetworkRequest request) async {
    for (int attempt = 0;
        attempt <
            ((request.httpMethod == HttpMethodEnum.httpGet &&
                    request.enableRepeat)
                ? maxConnectionAttempts
                : 1);) {
      Options options = Options();
      options.headers = {"authorization": 'Bearer $token'};
      Dio dio = Dio();

      if (request.enableCache) {
        dio.interceptors.add(DioCacheInterceptor(options: _options));
      }

      Response result = await dio
          .get<String>(request.url, options: options)
          .timeout(Duration(seconds: request.timeOutInSeconds));
      return result;
    }

    return null;
  }

  Future<Response> _post(NetworkRequest request) async {
    Map<String, String> optionHeaders = {
      'authorization': 'Bearer $token',
      'content-type': getContentTypeString(request.contentType),
    };

    Options options = Options(headers: optionHeaders);
    Object? data = _buildRequestData(
      contentTypeEnum: request.contentType,
      jsonBody: request.jsonBody,
      files: request.files,
    );
    return await Dio()
        .post<String>(request.url, data: data, options: options)
        .timeout(Duration(seconds: request.timeOutInSeconds));
  }

  Future<Response> _put(NetworkRequest request) async {
    Map<String, String> optionHeaders = {
      'authorization': 'Bearer $token',
      'content-type': getContentTypeString(request.contentType),
    };

    Options options = Options(headers: optionHeaders);
    Object? data = _buildRequestData(
      contentTypeEnum: request.contentType,
      jsonBody: request.jsonBody,
      files: request.files,
    );
    return await Dio()
        .put<String>(request.url, data: data, options: options)
        .timeout(Duration(seconds: request.timeOutInSeconds));
  }

  Future<Response> _delete(NetworkRequest request) async {
    Map<String, String> optionHeaders = {
      'authorization': 'Bearer $token',
      'content-type': getContentTypeString(request.contentType),
    };

    Options options = Options(headers: optionHeaders);
    Object? data = _buildRequestData(
      contentTypeEnum: request.contentType,
      jsonBody: request.jsonBody,
      files: request.files,
    );
    return await Dio()
        .delete<String>(request.url, data: data, options: options)
        .timeout(Duration(seconds: request.timeOutInSeconds));
  }

  NetworkResponse? _processResult(Response? response) {
    NetworkResponse result = NetworkResponse();

    if (response != null) {
      _processStatusCode(response);

      if (response.data.isNotEmpty) {
        result.response = response.data;
        result.statusCode = response.statusCode;
        result.message = response.statusMessage;
        return result;
      } else {
        return throw const HttpResult(type: HttpCodesEnum.s204_NoContent);
      }
    }
    return null;
  }

  _processStatusCode(Response? response) {
    if (response != null) {
      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode != null) {
        throw HttpResult(type: getErrorEnum(response.statusCode!));
      }
    }
  }

  HttpCodesEnum getErrorEnum(int code) {
    try {
      return HttpCodesEnum.values
          .where((x) => x.toString().contains(code.toString()))
          .single;
    } catch (e) {
      return HttpCodesEnum.e500_InternalServerError;
    }
  }
}
