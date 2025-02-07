import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/controllers/jet_controller.dart';
import 'package:jet_framework/exceptions/jet_error.dart';
import 'package:jet_framework/exceptions/jet_exception_handler.dart';
import 'package:jet_framework/networking/jet_service.dart';
import 'package:jet_framework/state/jet_state.dart';

abstract class JetFutureController<T> extends JetController {
  JetState<T> _state = JetState<T>.loading();

  /// The current state of the controller.
  JetState<T> get state => _state;

  /// The global service instance.
  JetService get service => JetApp.apiService;

  /// Abstract method to initialize data. Must be implemented by subclasses.
  Future<T?> init();

  @override
  void onInit() {
    super.onInit();
    runInt();
  }

  /// Initializes data and updates the state accordingly.
  Future<void> runInt() async {
    try {
      final data = await _fetchData();
      _updateState(JetState<T>.success(data));
      onSuccess(data);
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
    }
  }

  void reload() {
    _updateState(JetState<T>.loading());
    runInt();
  }

  /// Fetches data using the [init] method.
  Future<T?> _fetchData() => init();

  /// Updates the state and notifies listeners.
  void _updateState(JetState<T> newState) {
    _state = newState;
    update();
  }

  /// Handles errors during data fetching.
  void _handleError(Object error, StackTrace stackTrace) {
    if (error is JetError) {
      throw error;
    }

    final String errorMessage = JetApp.errorHandler.handle(error, stackTrace);
    _updateState(JetState<T>.error(errorMessage));
    onError(error, stackTrace);
  }

  /// Called when data is successfully fetched.
  /// Subclasses can override this to handle success scenarios.
  void onSuccess(T? data) {}

  /// Called when an error occurs during data fetching.
  /// Subclasses can override this to handle errors.
  void onError(Object error, StackTrace stackTrace) {}
}
