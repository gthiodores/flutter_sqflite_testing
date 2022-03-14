class State<T> {
  State._(); // Default constructor

  factory State.success(T data, {String? message}) = Success;

  factory State.loading({T? data}) = Loading;

  factory State.failure(Object exception, {T? data, String? message}) = Failure;

  /// Helper function to transform the State class with the 3 mapper functions
  /// passed in as parameters.
  R when<R>({
    required R Function(Success<T>) success,
    required R Function(Loading<T>) loading,
    required R Function(Failure<T>) failure,
  }) {
    if (this is Success<T>) {
      return success(this as Success<T>);
    }

    if (this is Failure<T>) {
      return failure(this as Failure<T>);
    }

    return loading(this as Loading<T>);
  }

  /// Helper function to retrieve data regardless of state.
  /// Since dart doesn't support reflection, we can't create a default value
  /// for type T and must instead return type T?.
  T? getAvailableData() {
    if (this is Success<T>) {
      return (this as Success<T>).data;
    }

    if (this is Loading<T>) {
      return (this as Loading<T>).data;
    }

    return (this as Failure<T>).data;
  }
}

class Loading<T> extends State<T> {
  final T? data;

  Loading({this.data}) : super._();
}

class Success<T> extends State<T> {
  final T data;
  final String? message;

  Success(this.data, {this.message}) : super._();
}

class Failure<T> extends State<T> {
  final T? data;
  final Object? exception;
  final String? message;

  Failure(this.exception, {this.data, this.message}) : super._();
}
