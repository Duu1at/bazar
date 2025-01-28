class LocalStorageException implements Exception {
  const LocalStorageException([this.error, this.stackTrace]);

  final dynamic error;
  final StackTrace? stackTrace;
}
