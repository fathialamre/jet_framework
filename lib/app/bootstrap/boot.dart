import 'package:flutter/material.dart';
import 'package:jet_app/app/config/providers.dart';
import 'package:jet_framework/jet.dart';
import 'package:jet_framework/providers/jet_provider.dart';
import 'package:jet_framework/resources/widgets/jet_main.dart';

class Boot {
  /// This method is called to initialize Jet.
  static Future<Jet> jet() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await bootApplication(providers);
  }

  /// This method is called after Jet is initialized.
  static Future<void> finished(Jet jet) async {
    await bootFinished(jet, providers);

    runApp(
      JetMain(jet: jet),
    );
  }
}
