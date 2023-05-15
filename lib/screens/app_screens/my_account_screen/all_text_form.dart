import '../../../config.dart';

class AllTextForm extends StatelessWidget {
  const AllTextForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAccountController>(builder: (myAccountCtrl) {
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('id', isEqualTo: myAccountCtrl.id)
              .limit(1)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              myAccountCtrl.firstNameController.text =
                  snapshot.data!.docs[0].data()["nickname"] ?? "";
              myAccountCtrl.emailController.text =
                  snapshot.data!.docs[0].data()["email"] ?? "";
              myAccountCtrl.numberController.text =
                  snapshot.data!.docs[0].data()["phone"] ?? "";
              return SizedBox(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(appFonts.firstName.tr,
                        style: AppCss.outfitMedium16
                            .textColor(appCtrl.appTheme.txt)),
                    const VSpace(Sizes.s10),
                    TextFieldCommon(
                        validator: (name) => Validation().emailValidation(name),
                        controller: myAccountCtrl.firstNameController,
                        hintText: appFonts.enterFirstName.tr),
                    const VSpace(Sizes.s15),
                    Text(appFonts.phone.tr,
                        style: AppCss.outfitMedium16
                            .textColor(appCtrl.appTheme.txt)),
                    const VSpace(Sizes.s10),
                    TextFieldCommon(
                        keyboardType: TextInputType.number,
                        validator: (name) => Validation().phoneValidation(name),
                        controller: myAccountCtrl.numberController,
                        hintText: appFonts.enterPhoneNo.tr),
                    const VSpace(Sizes.s15),
                    Text(appFonts.email.tr,
                        style: AppCss.outfitMedium16
                            .textColor(appCtrl.appTheme.txt)),
                    const VSpace(Sizes.s10),
                    TextFieldCommon(
                        validator: (email) =>
                            Validation().emailValidation(email),
                        controller: myAccountCtrl.emailController,
                        hintText: appFonts.enterEmailName.tr),
                    const VSpace(Sizes.s40),
                    ButtonCommon(
                        title: appFonts.update,
                        onTap: () => myAccountCtrl.onUpdate()),
                    const VSpace(Sizes.s20),
                    ButtonCommon(
                        onTap: () => myAccountCtrl.buildPopupDialog(),
                        title: appFonts.deleteAccount)
                  ]));
            } else {
              return Container();
            }
          });
    });
  }
}
