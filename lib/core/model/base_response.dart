class BaseResponse {
  final bool? status;
  final dynamic data;
  String? message;
  final String? title;

  BaseResponse(
      {this.data, this.message = "", this.status = false, this.title = ""});
}
