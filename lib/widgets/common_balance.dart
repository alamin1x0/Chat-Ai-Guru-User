
import '../config.dart';

class CommonBalance extends StatelessWidget {
  const CommonBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return appCtrl.isLocalChatApi  == true
        ? Container()
        : GetBuilder<AppController>(
          builder: (appCtrl) {
            return IntrinsicHeight(
                child: Row(children: [
                  Text(
                    appCtrl.envConfig["balance"].toString(),
                    style: AppCss.outfitSemiBold16
                        .textColor(appCtrl.appTheme.sameWhite),
                  ),
                  const HSpace(Sizes.s3),
                  Image.asset(eGifAssets.coin1, height: Sizes.s20, fit: BoxFit.fill)
                      .clipRRect(all: 50)
                ])
                    .paddingSymmetric(vertical: Insets.i10, horizontal: Insets.i8)
                    .decorated(
                        color: appCtrl.appTheme.sameWhite.withOpacity(.4),
                        border: Border.all(
                            color: appCtrl.appTheme.sameWhite.withOpacity(.12)),
                        borderRadius: BorderRadius.circular(AppRadius.r6)),
              ).inkWell(onTap: () => appCtrl.balanceTopUpDialog());
          }
        );
  }
}
