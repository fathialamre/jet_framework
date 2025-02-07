import 'package:build/build.dart';
import 'package:jet_builder/builder/routes_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder jetRouteGenerator(BuilderOptions options) =>
    PartBuilder([JetRouteGenerator()], '.g.dart');
