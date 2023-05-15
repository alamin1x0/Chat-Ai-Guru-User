import '../../../config.dart';

class PersonalAdvisorScreen extends StatelessWidget {
  final personalCtrl = Get.put(PersonalAdvisorController());

  PersonalAdvisorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalAdvisorController>(builder: (_) {
      return DirectionalityRtl(
          child: Scaffold(
              backgroundColor: appCtrl.appTheme.bg1,
              appBar: AppAppBarCommon(
                  title: appFonts.personalAdvice,
                  leadingOnTap: () => Get.back()),
              body: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(appFonts.raiseYourAffection.tr,
                        style: AppCss.outfitSemiBold16
                            .textColor(appCtrl.appTheme.primary)),
                    const VSpace(Sizes.s15),
                    SizedBox(
                            child: Column(
                                children: personalCtrl.personalAdvisorLists
                                    .asMap()
                                    .entries
                                    .map((e) => SocialMediaListLayout(
                                        data: e.value,
                                        index: e.key,
                                        totalLength: personalCtrl
                                                .personalAdvisorLists.length -
                                            1,
                                        onTap: () =>
                                            personalCtrl.onGoPage(e.value)))
                                    .toList()))
                        .paddingSymmetric(
                            vertical: Insets.i20, horizontal: Insets.i15)
                        .authBoxExtension()
                  ]).paddingSymmetric(
                      vertical: Insets.i30, horizontal: Insets.i20))));
    });
  }
}
