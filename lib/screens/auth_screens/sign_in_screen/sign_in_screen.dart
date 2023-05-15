import '../../../config.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final signInCtrl = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(builder: (_) {
      return Scaffold(
          key: scaffoldKey,
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: const AppBarCommon(isArrow: false),
          body: Stack(
            children: [
              ListView(children: [
                const VSpace(Sizes.s5),
                Form(
                        key: signInCtrl.signInGlobalKey,
                        child: const SingleChildScrollView(
                            child: SignInTextField()))
                    .paddingSymmetric(
                        horizontal: Insets.i20, vertical: Insets.i15),
                textCommon.simplyUseTextAuth(),
              ]).height(MediaQuery.of(context).size.height),
              if (signInCtrl.isLoading == true)
                const Center(child: CircularProgressIndicator())
            ],
          ));
    });
  }
}
