/// Represents the status of an asynchronous operation.
enum JetStatus {
  idle, // No operation is in progress.
  loading, // An operation is in progress.
  success, // The operation completed successfully.
  error, // The operation failed with an error.
}

/// A state class that encapsulates the status, data, and error of an asynchronous operation.
class JetState<T> {
  final JetStatus status;
  final T? data;
  final String? error;

  const JetState._({
    required this.status,
    this.data,
    this.error,
  });

  /// Factory constructor for the idle state.
  factory JetState.idle() => const JetState._(status: JetStatus.idle);

  /// Factory constructor for the loading state.
  factory JetState.loading() => const JetState._(status: JetStatus.loading);

  /// Factory constructor for the success state.
  factory JetState.success(T? data) =>
      JetState._(status: JetStatus.success, data: data);

  /// Factory constructor for the error state.
  factory JetState.error(String error) =>
      JetState._(status: JetStatus.error, error: error);

  /// Maps the current state to a specific handler function.
  R when<R>({
    required R Function() idle,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String error) error,
  }) {
    switch (status) {
      case JetStatus.idle:
        return idle();
      case JetStatus.loading:
        return loading();
      case JetStatus.success:
        if (data == null) {
          throw StateError('Data is null in success state');
        }
        return success(data as T);
      case JetStatus.error:
        if (this.error == null) {
          throw StateError('Error is null in error state');
        }
        return error(this.error!);
    }
  }

  /// Similar to [when], but provides a fallback for unmatched cases.
  R maybeWhen<R>({
    R Function()? idle,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String error)? error,
    required R Function() orElse,
  }) {
    switch (status) {
      case JetStatus.idle:
        if (idle != null) return idle();
        break;
      case JetStatus.loading:
        if (loading != null) return loading();
        break;
      case JetStatus.success:
        if (success != null && data != null) return success(data as T);
        break;
      case JetStatus.error:
        if (error != null && this.error != null) return error(this.error!);
        break;
    }
    return orElse();
  }

  /// Creates a copy of the current state with updated values.
  JetState<T> copyWith({
    JetStatus? status,
    T? data,
    String? error,
  }) {
    return JetState._(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is JetState<T> &&
        other.status == status &&
        other.data == data &&
        other.error == error;
  }

  @override
  int get hashCode => Object.hash(status, data, error);

  @override
  String toString() => 'JetState(status: $status, data: $data, error: $error)';
}

/// Enum representing the state status.
