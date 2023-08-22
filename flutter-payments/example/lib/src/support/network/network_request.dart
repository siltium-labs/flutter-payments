import 'dart:io';
import 'content_type_enum.dart';
import 'http_method_enum.dart';

class NetworkRequest {
  String url;
  HttpMethodEnum httpMethod;
  bool enableCache;
  bool forceRefresh;
  bool enableRepeat;
  bool throwExceptions;
  int cacheDurationInMinutes;
  int timeOutInSeconds;
  int connectionTimeout;
  ContentTypeEnum contentType;
  String? jsonBody;
  Map<String, File> files;

  NetworkRequest({
    required this.url,
    required this.httpMethod,
    this.enableCache = true,
    this.forceRefresh = false,
    this.enableRepeat = false,
    this.throwExceptions = true,
    this.cacheDurationInMinutes = 15,
    this.timeOutInSeconds = 30,
    this.connectionTimeout = 15,
    this.contentType = ContentTypeEnum.applicationJsonUtf8,
    this.jsonBody,
    this.files = const {},
  });
}
