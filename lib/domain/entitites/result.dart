import 'package:equatable/equatable.dart';
import 'package:labhouse_app/domain/error/failures.dart';

class Result<T> extends Equatable {
  final T? _value;
  final Failure? _error;

  const Result._({
    required T? value,
    required Failure? error,
  })  : _value = value,
        _error = error;

  factory Result.success(T value) => Result._(
        value: value,
        error: null,
      );
  factory Result.error(Failure failure) => Result._(
        value: null,
        error: failure,
      );

  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) error,
  }) {
    if (_value != null) {
      return success(_value as T);
    } else if (_error != null) {
      return error(_error!);
    }

    throw StateError('Unhandled case');
  }

  @override
  List<Object?> get props => [_value, _error];
}
