import 'package:jet_framework/helpers/jet_logger.dart';

class DefaultResponse<T> {
  DefaultResponse({
    required this.data,
  });

  late final T? data;

  DefaultResponse.fromJson(json, Map<Type, dynamic> decoders,
      {required Type type}) {
    assert(decoders.containsKey(type),
        'Your config/decoders.dart file does not contain a decoder for the following class: ${type.toString()} in apiDecoders');
    try {
      dynamic jsonResponse = decoders[type]!(json['data']);
      if (jsonResponse == null) {
        data = null;
        return;
      }
      data = jsonResponse as T;
    } catch (e) {
      rethrow;
    }
  }
}
