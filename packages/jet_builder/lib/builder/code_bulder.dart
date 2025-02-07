import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';


class CodeBuilder {
  static String build({
    required Class classBuilder,
    required List<Directive> directives,
  }) {
    final library = Library(
          (b) => b
        ..directives.addAll(directives)
        ..body.add(classBuilder),
    );

    // Generate the Dart code
    final emitter = DartEmitter();
    final code = DartFormatter().format('${library.accept(emitter)}');

    return code;
  }
}
