import '../../../../config.dart';

class EmailGeneratorTopLayout extends StatelessWidget {
  final String? fTitle, sTitle, fHint, sHint;
  final TextEditingController? fController, sController;

  const EmailGeneratorTopLayout(
      {Key? key,
      this.fTitle,
      this.sTitle,
      this.fController,
      this.fHint,
      this.sController,
      this.sHint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(fTitle!.tr,
            style: AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt)),
        const VSpace(Sizes.s10),
        TextFieldCommon(
          hintText: fHint!.tr,
          controller: fController!,
        )
      ])),
      const HSpace(Sizes.s15),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(sTitle!.tr,
            style: AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt)),
        const VSpace(Sizes.s10),
        TextFieldCommon(hintText: sHint!.tr, controller: sController!)
      ]))
    ]);
  }
}
