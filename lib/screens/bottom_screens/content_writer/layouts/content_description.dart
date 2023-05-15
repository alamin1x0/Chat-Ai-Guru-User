import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../../config.dart';

class ContentDescription extends StatelessWidget {
  const ContentDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentWriterController>(builder: (contentCtrl) {
      log("LENGTH : ${contentCtrl.htmlData}");
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(appFonts.description.tr,
                style: AppCss.outfitSemiBold18
                    .textColor(appCtrl.appTheme.primary)),
            Row(children: [
              SvgPicture.asset(eSvgAssets.share)
                  .descriptionOptionBg()
                  .inkWell(onTap: () => Share.share(contentCtrl.htmlData)),
              const HSpace(Sizes.s12),
              SvgPicture.asset(eSvgAssets.trash).descriptionOptionBg().inkWell(
                  onTap: () {
                contentCtrl.htmlData = null;
                contentCtrl.update();
              }),
              const HSpace(Sizes.s12),
              SvgPicture.asset(eSvgAssets.copy).descriptionOptionBg().inkWell(
                  onTap: () async {
                String parsedstring3 =
                    Bidi.stripHtmlIfNeeded(contentCtrl.htmlData);
                log(parsedstring3);
                Clipboard.setData(ClipboardData(text: parsedstring3));
              }),
             /* const HSpace(Sizes.s12),
              SvgPicture.asset(eSvgAssets.edit).descriptionOptionBg()*/
            ])
          ]),
          const VSpace(Sizes.s15),
          const ResponseData()
        ],
      );
    });
  }
}
