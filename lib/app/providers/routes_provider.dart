import 'package:jet_app/app/routes/app_routes.dart';
import 'package:jet_framework/jet.dart';
import 'package:jet_framework/providers/jet_provider.dart';

class RoutesProvider implements JetProvider {
  @override
  Future<Jet?> boot(Jet jet) async {
    jet.addPages(appPages);
    return jet;
  }

  @override
  Future<void> afterBoot(Jet jet) async {}
}
