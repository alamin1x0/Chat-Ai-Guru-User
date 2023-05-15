import '../../../../config.dart';

class CvMakerLayout extends StatelessWidget {
  const CvMakerLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CvMakerController>(builder: (cvCtrl) {
      return Stack(children: [
        SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                textCommon.outfitSemiBoldPrimary16(
                    text: appFonts.createProfessional),
                const VSpace(Sizes.s20),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  textCommon.outfitSemiBoldTxt14(text: appFonts.personalInfo),
                  const VSpace(Sizes.s15),
                  EmailGeneratorTopLayout(
                      fTitle: appFonts.name,
                      fHint: appFonts.writeFullName,
                      fController: cvCtrl.nameController,
                      sTitle: appFonts.phoneNo,
                      sHint: appFonts.writeNumber,
                      sController: cvCtrl.phoneController),
                  const VSpace(Sizes.s15),
                  textCommon.outfitSemiBoldTxt14(text: appFonts.email),
                  const VSpace(Sizes.s10),
                  TextFieldCommon(
                      hintText: appFonts.writeMail,
                      controller: cvCtrl.mailController),
                  const VSpace(Sizes.s15),
                  EmailGeneratorTopLayout(
                      fTitle: appFonts.positionLooking,
                      fHint: appFonts.enterValue,
                      fController: cvCtrl.positionController,
                      sTitle: appFonts.experience,
                      sHint: appFonts.enterValue,
                      sController: cvCtrl.experienceController),
                  const VSpace(Sizes.s15),
                  textCommon.outfitSemiBoldTxt14(
                      text: appFonts.whyYouWantThisJob),
                  const VSpace(Sizes.s10),
                  TextFieldCommon(
                      minLines: 1,
                      maxLines: 5,
                      hintText: appFonts.enterValue,
                      controller: cvCtrl.jobController),
                  const VSpace(Sizes.s15),
                  textCommon.outfitSemiBoldTxt14(text: appFonts.customMessage),
                  const VSpace(Sizes.s10),
                  TextFieldCommon(
                      hintText: appFonts.writeOtherThings,
                      controller: cvCtrl.customController)
                ])
                    .paddingSymmetric(
                        vertical: Insets.i20, horizontal: Insets.i15)
                    .authBoxExtension()
              ]),
              const VSpace(Sizes.s30),
              ButtonCommon(
                  title: appFonts.createProfessionalCv,
                  onTap: () => cvCtrl.onCvGenerate())
            ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i30)),
        if (cvCtrl.isLoader == true) const LoaderLayout()
      ]);
    });
  }
}
