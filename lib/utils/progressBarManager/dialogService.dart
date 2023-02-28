import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'dialogModels.dart';

class ProgressService {
  final GlobalKey<NavigatorState> _progressNavigationKey =
      GlobalKey<NavigatorState>();
  late Function(ProgressRequest) _showProgressListener;
  late Completer<ProgressResponse>? _progressCompleter;

  GlobalKey<NavigatorState> get progressNavigationKey => _progressNavigationKey;

  /// Registers a callback function. Typically to show the dialog
  void registerProgressListener(
      Function(ProgressRequest) showProgressListener) {
    _showProgressListener = showProgressListener;
  }

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<ProgressResponse> showDialog({
    String? title,
    String? description,
    String? buttonTitle = 'Ok',
  }) {
    _progressCompleter = Completer<ProgressResponse>();
    _showProgressListener(ProgressRequest(
      title: title,
      description: description,
      buttonTitle: buttonTitle,
    ));
    return _progressCompleter!.future;
  }

  /// Shows a confirmation dialog
  Future<ProgressResponse> showConfirmationDialog(
      {String? title,
      String? description,
      String? confirmationTitle = 'Ok',
      String? cancelTitle = 'Cancel'}) {
    _progressCompleter = Completer<ProgressResponse>();
    _showProgressListener(ProgressRequest(
        title: title,
        description: description,
        buttonTitle: confirmationTitle,
        cancelTitle: cancelTitle));
    return _progressCompleter!.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete() {
    _progressNavigationKey.currentState!.pop();
    _progressCompleter!.future;
    _progressCompleter = null;
  }
}
