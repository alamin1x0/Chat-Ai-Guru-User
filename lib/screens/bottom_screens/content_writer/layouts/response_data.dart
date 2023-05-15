
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../config.dart';

class ResponseData extends StatelessWidget {
  const ResponseData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentWriterController>(
      builder: (contentCtrl) {
        return RawScrollbar(
          controller: contentCtrl.scrollController,
          trackColor: appCtrl.appTheme.greyLight,
          thumbColor: appCtrl.appTheme.primary,
          radius: const Radius.circular(AppRadius.r4),
          thickness: 3,
          child: ListView(
              controller: contentCtrl.scrollController,
              padding: EdgeInsets.zero,
              children: [
                HtmlWidget(
                  contentCtrl.htmlData,
                  textStyle: AppCss.outfitMedium14
                      .textColor(appCtrl.appTheme.txt)
                      .textHeight(1.5),
                ).paddingAll(Insets.i20).decorated(
                    color: appCtrl.appTheme.bg1,
                    borderRadius: BorderRadius.circular(AppRadius.r6)),
              ]).height(contentCtrl.htmlData.length > 350
              ? Sizes.s350
              : contentCtrl.htmlData.length > 200
              ? Sizes.s180
              : Sizes.s120),
        );
      }
    );
  }
}
