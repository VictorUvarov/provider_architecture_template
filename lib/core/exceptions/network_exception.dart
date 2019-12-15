class NetworkException implements Exception {
  final String message;
  final StackTrace stackTrace;

  NetworkException(this.message, {this.stackTrace});
}
