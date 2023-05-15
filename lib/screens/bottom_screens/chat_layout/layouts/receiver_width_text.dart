import '../../../../config.dart';

class ReceiverWidthText extends StatelessWidget {
  final String? text;
  final int? time;
  final double? width;


  const ReceiverWidthText(
      {Key? key, this.text, this.width, this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return Container(
          width: width!,
          padding: const EdgeInsets.symmetric(
              horizontal: Insets.i10, vertical: Insets.i12),
          decoration: BoxDecoration(
              color: appCtrl.appTheme.boxBg,
              boxShadow: appCtrl.isTheme
                  ? null
                  : [
                      BoxShadow(
                          color: appCtrl.appTheme.primaryShadow,
                          offset: const Offset(0, 10),
                          blurRadius: 20)
                    ],
              borderRadius: BorderRadius.circular(AppRadius.r6)),
          child: Column(children: [
            Text(text!,
                overflow: TextOverflow.clip,
                style: AppCss.outfitMedium14
                    .textColor(appCtrl.appTheme.txt)
                    .textHeight(1.2)),
            const VSpace(Sizes.s10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ChatCommonWidget().timeTextLayout(time!.toString()),
              SvgPicture.asset(eSvgAssets.volume).inkWell(onTap: () {
                String code = appCtrl.languageVal == "en"
                    ? "US"
                    : appCtrl.languageVal == "fr"
                        ? "CA"
                        : appCtrl.languageVal == "ge"
                            ? "GE"
                            : appCtrl.languageVal == "hi"
                                ? "IN"
                                : appCtrl.languageVal == "it"
                                    ? "IT"
                                    : appCtrl.languageVal == "ja"
                                        ? "JP"
                                        : "US";
                chatCtrl.speechMethod(text!, '${appCtrl.languageVal}-$code');
              })
            ])
          ]));
    });
  }
}
