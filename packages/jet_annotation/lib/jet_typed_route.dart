class JetTypedRoute {
  final String path;
  final bool initial;

  final List<Object> bindings;

  const JetTypedRoute(this.path,
      {this.initial = false, this.bindings = const []});
}
