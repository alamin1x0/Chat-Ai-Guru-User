import '../../../../config.dart';

class PasswordLayout extends StatelessWidget {
  const PasswordLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordController>(
      builder: (passwordCtrl) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textCommon.outfitSemiBoldTxt14(text: appFonts.passwordLength),
          const VSpace(Sizes.s70),
          const PasswordLengthSlider(),
          const VSpace(Sizes.s20),
          textCommon.outfitSemiBoldTxt14(text: appFonts.passwordType),
          const VSpace(Sizes.s10),
          ...passwordCtrl.passwordTypeLists
              .asMap()
              .entries
              .map((e) => PasswordRadioButtonLayout(
              data: e.value,
              index: e.key,
              selectIndex: passwordCtrl.selectedIndex,
              onTap: () =>
                  passwordCtrl.onChangePasswordType(e.key)))
              .toList(),
          const VSpace(Sizes.s10),
          textCommon.outfitSemiBoldTxt14(
              text: appFonts.passwordStrength),
          const VSpace(Sizes.s20),
          const PasswordStrengthSlider(),
          const VSpace(Sizes.s10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: passwordCtrl.passwordStrengthLists
                  .asMap()
                  .entries
                  .map((e) => Text(e.value.toString().tr,
                  style: AppCss.outfitMedium14.textColor(
                      passwordCtrl.strengthValue >= e.key
                          ? appCtrl.appTheme.primary
                          : appCtrl.appTheme.lightText)))
                  .toList())
        ])
            .paddingSymmetric(
            vertical: Insets.i20, horizontal: Insets.i15)
            .authBoxExtension();
      }
    );
  }
}
