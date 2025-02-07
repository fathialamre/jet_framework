import 'package:get/get_instance/src/bindings_interface.dart';

abstract class JetBindings extends Bindings {
  @override
  void dependencies();
}

class JetInjectionsBuilder extends BindingsBuilder {
  JetInjectionsBuilder(super.builder);
}

