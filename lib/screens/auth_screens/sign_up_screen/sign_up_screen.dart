import '../../../config.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final signUpCtrl = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (_) {
      return Scaffold(
          key: scaffoldKey,
          appBar: const AppBarCommon(isArrow: false),
          body: Stack(alignment: Alignment.center, children: [
            ListView(children: [
              const VSpace(Sizes.s5),
              SizedBox(
                      width: double.infinity,
                      child: Form(
                          key: signUpCtrl.signUpGlobalKey,
                          child: const SignUpField()))
                  .authBoxExtension(),
              textCommon.simplyUseTextAuth(),
            ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i15),
            if (signUpCtrl.isLoading == true)
              const Center(child: CircularProgressIndicator())
          ]));
    });
  }
}
