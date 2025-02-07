import 'package:jet_framework/networking/dio_api_service.dart';

typedef JetDecoder = Map<Type, dynamic>;

class JetService extends DioApiService {
  final bool isGlobal;

  JetService({
    super.initDio,
    super.baseOptions,
    this.isGlobal = false,
  });
}
