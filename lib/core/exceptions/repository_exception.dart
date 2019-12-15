class RepositoryException implements Exception {
  final String message;
  final StackTrace stackTrace;

  RepositoryException(this.message, {this.stackTrace});
}
