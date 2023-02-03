import 'package:flutter/material.dart';
import '../../../_lib.dart';
import 'safety_first.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(builder: (context, ref, _) {
      final vm = ref.watch(registerVm);
      return SafeArea(
          child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: vm.controller,
        children: [const Register(), RegFinal()],
      ));
    }));
  }
}
