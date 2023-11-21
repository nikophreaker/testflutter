class RequestApiError implements Exception {
  final String cause;

  const RequestApiError(this.cause);

  @override
  String toString() {
    return cause;
  }
}
