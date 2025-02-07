import 'package:jet_app/app/providers/app_provider.dart';
import 'package:jet_app/app/providers/routes_provider.dart';
import 'package:jet_app/app/providers/services_provider.dart';
import 'package:jet_framework/providers/jet_provider.dart';

final Map<Type, JetProvider> providers = {
  AppProvider: AppProvider(),
  RoutesProvider: RoutesProvider(),
  ServiceProvider: ServiceProvider(),
};
