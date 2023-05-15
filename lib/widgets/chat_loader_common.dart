import '../config.dart';

class ChatLoaderCommon extends StatelessWidget {
  const ChatLoaderCommon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: Insets.i10),
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
        child: Image.asset(eGifAssets.loading, height: Sizes.s40));
  }
}
