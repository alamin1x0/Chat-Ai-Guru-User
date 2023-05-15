import '../config.dart';

class CommonVolume extends StatelessWidget {
  final String? message;
  const CommonVolume({Key? key,this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(
      builder: (chatCtrl) {
        return SvgPicture.asset(eSvgAssets.volume,colorFilter: ColorFilter.mode(appCtrl.appTheme.sameWhite, BlendMode.srcIn),).inkWell(
            onTap: () {
              String code = appCtrl.languageVal == "en"
                  ? "US"
                  : appCtrl.languageVal == "fr"
                  ? "CA"
                  : appCtrl.languageVal == "ge"
                  ? "GE"
                  : appCtrl.languageVal == "hi"
                  ? "IN"
                  : appCtrl.languageVal ==
                  "it"
                  ? "IT"
                  : appCtrl.languageVal ==
                  "ja"
                  ? "JP"
                  : "US";
              chatCtrl.speechMethod(
                  message!,
                  '${appCtrl.languageVal}-$code');
            });
      }
    );
  }
}
