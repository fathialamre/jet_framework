import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:jet_annotation/jet_typed_route.dart';
import 'package:source_gen/source_gen.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

class JetRouteGenerator extends GeneratorForAnnotation<JetTypedRoute> {
  String getClassRouteName(String className) {
    final regex = RegExp(r'TypedRoute\$?');
    String clazzName = className.replaceAll(regex, '');
    return className.contains('Page')
        ? '${clazzName}Route'
        : '${clazzName}PageRoute';
  }

  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      final name = element.displayName;
      throw InvalidGenerationSourceError(
        'Generator cannot target `$name`.',
      );
    }

    String className = element.name;
    String path = annotation.read('path').stringValue;
    bool initialRoute = annotation.read('initial').boolValue;

    // Find the `page` method and extract its return type
    final pageGetter = element.getMethod('page');
    if (pageGetter == null) {
      throw InvalidGenerationSourceError(
        'The class `$className` must have a `page` method.',
      );
    }

    final returnType = pageGetter.returnType;
    if (returnType is! InterfaceType) {
      throw InvalidGenerationSourceError(
        'The `page` method in `$className` must return a valid type.',
      );
    }

    // Extract the return type of the `page` method
    final pageClassName = returnType.getDisplayString(withNullability: false);

    // Extract fields from the original class
    final fields = (element)
        .fields
        .where((field) => !field.isStatic && field.isFinal)
        .map((field) => Field((b) => b
          ..name = field.name
          ..type = refer(field.type.getDisplayString(withNullability: false))
          ..modifier = FieldModifier.final$))
        .toList();

    // Create the generated class name by appending "Route" to the class name

    final routeClassName = getClassRouteName(className);

    // Create the static `name` field
    final nameField = Field((b) => b
      ..name = 'name'
      ..static = true
      ..modifier = FieldModifier.constant
      ..type = refer('String')
      ..assignment = Code("'$path'"));

    // Create the constructor with required positional parameters
    final constructor = Constructor(
      (b) => b
        ..requiredParameters.addAll(fields.map((field) => Parameter((p) => p
          ..name = field.name
          ..toThis = true))),
    );

    // Create the static `route` method
    final routeMethod = Method((b) => b
      ..name = 'route'
      ..static = true
      ..type = MethodType.getter
      ..returns = refer('JetPage')
      ..lambda = true
      ..body = Block.of([
        refer('JetPage').newInstance([], {
          'name': refer('name'),
          'page': Method(
            (m) => m
              ..lambda = true
              ..body = refer(pageClassName).newInstance(
                [],
                {
                  for (final field in fields)
                    field.name: refer('routeArgs').call([
                      literalString(field.name),
                    ]), // Use the field name directly
                },
              ).code,
          ).closure,
          if (initialRoute) 'initial': literalBool(initialRoute),
        }).code,
      ]));

    // Create the instance `go` method
    final goMethod = Method((b) => b
      ..name = 'go'
      ..returns = refer('void')
      ..body = Block.of([
        refer('routeTo').call([
          refer('name'),
        ], {
          'arguments': literalMap({
            for (final field in fields)
              literalString(field.name): refer(field.name),
          }),
        }).statement,
        // Add .statement to ensure the call ends with a semicolon
      ]));

    // Create the generated class
    final classBuilder = Class((b) => b
      ..name = routeClassName
      ..fields.addAll([nameField])
      ..constructors.add(constructor)
      ..methods.addAll([routeMethod, goMethod])
      ..fields.addAll(fields));

    // Format the generated code
    final emitter = DartEmitter();
    final code = '${classBuilder.accept(emitter)}';

    return DartFormatter().format(code);
  }
}
