import '../../../../config.dart';

class NotificationLayout extends StatelessWidget {
  final NotificationModel? data;

  const NotificationLayout({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: double.infinity,
            child: Row(children: [
              Image.asset(data!.image!, height: Sizes.s40),
              const HSpace(Sizes.s10),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(data!.title!.toString().tr,
                        overflow: TextOverflow.clip,
                        style: AppCss.outfitMedium14
                            .textColor(appCtrl.appTheme.txt)
                            .textHeight(1.2)),
                    const VSpace(Sizes.s5),
                    Text(data!.subtitle!.toString().tr,
                        style: AppCss.outfitMedium14
                            .textColor(appCtrl.appTheme.lightText))
                  ]))
            ]).paddingAll(Insets.i15))
        .decorated(
            color: appCtrl.appTheme.boxBg,
            borderRadius:
                const BorderRadius.all(Radius.circular(AppRadius.r10)))
        .paddingOnly(bottom: Insets.i15);
  }
}
