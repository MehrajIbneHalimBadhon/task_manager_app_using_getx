class NetworkResponse {
  final int statusCode;
  final bool isSuccess;
  final dynamic responseDate;
  final String? errorMessage;

  NetworkResponse(
      {required this.statusCode,
      required this.isSuccess,
      this.responseDate,
      this.errorMessage = 'Something went wrong'});
}
