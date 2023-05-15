import 'dart:developer';
import '../../../../config.dart';

class SettingUser extends StatelessWidget {
  const SettingUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FirebaseAuth.instance.currentUser != null
        ? StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .limit(1)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                log("message : ${snapshot.data!.docs}");
                return snapshot.data!.docs[0].data()["image"] != null
                    ? Container(
                        margin: const EdgeInsets.only(top: Insets.i10),
                        height: Sizes.s68,
                        width: Sizes.s68,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    snapshot.data!.docs[0].data()["image"]))),
                      )
                    : Text(
                            snapshot.data!.docs[0].data()["email"] != null && snapshot.data!.docs[0].data()["email"] != ""
                                ? snapshot.data!.docs[0].data()["email"]![0]
                                : "S",
                            style: AppCss.outfitExtraBold30
                                .textColor(appCtrl.appTheme.sameWhite))
                        .paddingSymmetric(
                            horizontal: Insets.i22, vertical: Insets.i18)
                        .decorated(
                            shape: BoxShape.circle,
                            color: appCtrl.appTheme.primary);
              } else {
                return Text("S",
                        style: AppCss.outfitExtraBold30
                            .textColor(appCtrl.appTheme.sameWhite))
                    .paddingSymmetric(
                        horizontal: Insets.i22, vertical: Insets.i18)
                    .decorated(
                        shape: BoxShape.circle,
                        color: appCtrl.appTheme.primary);
              }
            })
        : Text("S",
                style: AppCss.outfitExtraBold30
                    .textColor(appCtrl.appTheme.sameWhite))
            .paddingSymmetric(horizontal: Insets.i22, vertical: Insets.i18)
            .decorated(shape: BoxShape.circle, color: appCtrl.appTheme.primary);
  }
}
