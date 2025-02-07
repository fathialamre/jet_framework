import 'package:jet_app/app/bootstrap/boot.dart';
import 'package:jet_framework/jet.dart';

void main() async {
  await Jet.fly(
    setup: () => Boot.jet(),
    setupFinished: Boot.finished,
  );
}
