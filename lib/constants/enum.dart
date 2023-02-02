enum LoadingState { error, loading, idle }

extension ViewStateExtension on LoadingState {
  bool get isLoading => this == LoadingState.loading;
  bool get isIdle => this == LoadingState.idle;
  bool get isError => this == LoadingState.error;
}

enum TextType {
  headerText,
  bigText,
  largeText,
  mediumText,
  smallText,
  smallestText
}
