import 'package:dio/dio.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/helpers/helper.dart';
import 'package:jet_framework/helpers/jet_logger.dart';
import 'package:jet_framework/networking/models/base_response.dart';

import 'interceptors/jet_dio_logger_interceptor.dart';

typedef JetDio = Dio;

class DioApiService {
  late final Dio _api;
  final BaseOptions _baseOptions;
  final Dio Function(Dio api)? _initDio;

  DioApiService({
    BaseOptions Function(BaseOptions baseOptions)? baseOptions,
    Dio Function(Dio api)? initDio,
  })  : _initDio = initDio,
        _baseOptions = _createBaseOptions(baseOptions) {
    init();
  }

  static BaseOptions _createBaseOptions(
    BaseOptions Function(BaseOptions baseOptions)? config,
  ) {
    final defaultOptions = BaseOptions(
      baseUrl: getBaseUrl,
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
      },
    );

    return config?.call(defaultOptions) ?? defaultOptions;
  }

  void init() {
    _api = Dio(_baseOptions);
    _addInterceptors();
    _initDio?.call(_api);
  }

  Dio get dioInstance => _api;

  Future<T?> get<T>(String path, {dynamic parser}) => _request<T>(
        () => _api.get(path),
        parser: parser,
      );

  Future<T?> post<T>(
    String path, {
    dynamic data,
    dynamic parser,
    Options? options,
  }) {
    return _request<T>(
      () => _api.post(path, data: data, options: options),
      parser: parser,
    );
  }

  Future<T?> _request<T>(
    Future<Response<dynamic>> Function() request, {
    dynamic parser,
  }) async {
    try {
      final response = await request();
      return _parseResponse<T>(response.data, parser: parser);
    } on DioException catch (e) {
      onError(e);
      rethrow;
    }
  }

  T? _parseResponse<T>(dynamic data, {dynamic parser}) {
    try {
      if (T == dynamic) return data as T?;

      if (parser != null) return parser(data);

      final apiDecoders = JetApp.apiDecoders;

      assert(apiDecoders.containsKey(T),
          "Missing parser for type $T in config/decoders.dart");

      return _morphJsonResponse<T>(data);
    } catch (e) {
      dump(e.toString(), details: data, tag: 'Json Parsing Error');
      return null;
    }
  }

  _morphJsonResponse<T>(dynamic json) {
    DefaultResponse defaultResponse = DefaultResponse<T>.fromJson(
      json,
      JetApp.apiDecoders,
      type: T,
    );
    return defaultResponse.data;
  }

  void onError(DioException dioException) {
    // Add error handling logic here
  }

  Map<Type, Interceptor> get interceptors => {
        if (isDebug()) JetDioLogger: JetDioLogger(),
      };

  bool get useInterceptors => interceptors.isNotEmpty;

  _addInterceptors() {
    _api.interceptors.addAll(interceptors.values);
  }
}
