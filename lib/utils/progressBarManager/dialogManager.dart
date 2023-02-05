import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';

class ProgressManager extends StatefulWidget {
  final Widget? child;
  const ProgressManager({Key? key, this.child}) : super(key: key);

  @override
  _ProgressManagerState createState() => _ProgressManagerState();
}

class _ProgressManagerState extends State<ProgressManager> {
  final ProgressService _progressService = locator<ProgressService>();

  @override
  void initState() {
    super.initState();
    _progressService.registerProgressListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }

  void _showDialog(ProgressRequest request) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black38,
        builder: (context) {
          return const WaitDialog();
        });
  }
}
