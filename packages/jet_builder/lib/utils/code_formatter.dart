import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

class CodeFormatter {
  static String format(
      {required Spec classBuilder, List<Directive> directives = const []}) {
    // Create the library and add the imports and class
    final library = Library((b) {
      b.body.addAll(directives);
      b.body.add(classBuilder);
    });

    // Generate the Dart code
    final emitter = DartEmitter();
    final code = DartFormatter().format('${library.accept(emitter)}');

    return code;
  }
}
