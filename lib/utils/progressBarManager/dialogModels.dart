class ProgressRequest {
  final String? title;
  final String? description;
  final String? buttonTitle;
  final String? cancelTitle;

  ProgressRequest(
      {required this.title,
      required this.description,
      required this.buttonTitle,
      this.cancelTitle});
}

class ProgressResponse {
  final String? fieldOne;
  final String? fieldTwo;
  final bool? confirmed;

  ProgressResponse({
    this.fieldOne,
    this.fieldTwo,
    this.confirmed,
  });
}
