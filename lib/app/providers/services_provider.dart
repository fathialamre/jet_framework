import 'package:jet_app/app/networking/api_service.dart';
import 'package:jet_framework/jet.dart';
import 'package:jet_framework/providers/jet_provider.dart';

class ServiceProvider implements JetProvider {
  @override
  Future<Jet?> boot(Jet jet) async {
    jet.addManyServices([
      ApiService(),
    ]);
    return jet;
  }

  @override
  Future<void> afterBoot(Jet jet) async {}
}
