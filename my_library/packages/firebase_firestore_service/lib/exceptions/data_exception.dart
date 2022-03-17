class DataException {
  String message;
  DataException({
    required this.message,
  });
  @override
  String toString() {
    return message;
  }
}
