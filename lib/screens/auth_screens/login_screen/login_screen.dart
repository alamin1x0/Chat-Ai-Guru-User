import 'package:flutter/services.dart';
import '../../../config.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          body: Column(children: [
        const LoginImageLayout(),
        const VSpace(Sizes.s20),
        const LoginBody().paddingSymmetric(horizontal: Insets.i20)
      ]).paddingOnly(bottom: Insets.i10)),
    );
  }
}
