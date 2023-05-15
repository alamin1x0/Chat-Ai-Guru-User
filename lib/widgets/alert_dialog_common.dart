import 'package:flutter/cupertino.dart';

import '../../config.dart';

class AlertDialogCommon extends StatelessWidget {
  final String? image, title, subtext, bText1, reward;
  final GestureTapCallback? b1OnTap, crossOnTap;
  final TextStyle? style;
  final double? height;
  final bool? isReward;

  const AlertDialogCommon(
      {Key? key,
      this.title,
      this.b1OnTap,
      this.bText1,
      this.image,
      this.subtext,
      this.crossOnTap,
      this.height,
      this.isReward = false,
      this.style,
      this.reward})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.r14))),
        backgroundColor: appCtrl.appTheme.white,
        content: Stack(alignment: Alignment.topRight, children: [
          Column(mainAxisSize: MainAxisSize.min, children: [
            const VSpace(Sizes.s55),
            // Gif
            Image.asset(image!, height: height ?? Sizes.s190),
            if (isReward == true)
              Column(children: [
                DottedLines(width: Sizes.s40, color: appCtrl.appTheme.primary),
                const VSpace(Sizes.s10),
                Text("$reward ${appFonts.rewardLeft.tr}",
                    style: AppCss.outfitblack20
                        .textColor(appCtrl.appTheme.primary))
              ]),
            const VSpace(Sizes.s18),
            // Sub text
            Text(subtext!.tr,
                    textAlign: TextAlign.center,
                    style: style ??
                        AppCss.outfitMedium16
                            .textColor(appCtrl.appTheme.txt)
                            .textHeight(1.3))
                .paddingSymmetric(horizontal: Insets.i5),
            const VSpace(Sizes.s25),
            ButtonCommon(onTap: b1OnTap, title: bText1!)
          ]).paddingAll(Insets.i20),
          Column(mainAxisSize: MainAxisSize.min, children: [
            const VSpace(Sizes.s5),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              // Title
              Text(title!.tr,
                      style: AppCss.outfitSemiBold20
                          .textColor(appCtrl.appTheme.txt))
                  .paddingSymmetric(horizontal: Insets.i20),
              IconButton(
                  onPressed: crossOnTap,
                  icon: Icon(CupertinoIcons.multiply,
                      size: Sizes.s20, color: appCtrl.appTheme.lightText))
            ]),
            const VSpace(Sizes.s5),
            DottedLines(width: MediaQuery.of(context).size.width)
          ])
        ]));
  }
}
