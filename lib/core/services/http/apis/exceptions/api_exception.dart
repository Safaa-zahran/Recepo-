class ApiException implements Exception {
  dynamic data;
  ApiException(this.data);

  @override
  String toString() {
    return data;
  }
}
