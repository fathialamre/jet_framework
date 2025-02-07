import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/controllers/jet_async_controller.dart';
import 'package:jet_framework/resources/widgets/jet_error_widget.dart';

class JetFutureWidget<T extends JetFutureController, R>
    extends StatelessWidget {
  const JetFutureWidget({
    super.key,
    this.tag,
  });

  final String? tag;

  T get controller => find<T>(tag: tag);

  Widget view(BuildContext context, R data) {
    throw UnimplementedError('view() not implemented');
  }

  Widget error(String error) {
    return JetErrorWidget(
      message: error,
      onPressed: () {
        controller.reload();
      },
    );
  }

  Widget loading() {
    return JetApp.style.appLoader;
  }

  Widget idle() {
    return const Center(
      child: Text('Idle'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<T>(
        init: controller,
        builder: (controller) {
          return controller.state.maybeWhen(
            idle: idle,
            loading: loading,
            success: (data) => view(context, data),
            error: (err) {
              return error(err);
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
