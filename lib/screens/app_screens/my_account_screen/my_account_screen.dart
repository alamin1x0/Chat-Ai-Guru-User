
import 'package:probot/config.dart';


class MyAccountScreen extends StatelessWidget {
  final myAccountCtrl = Get.put(MyAccountController());

  MyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAccountController>(builder: (_) {
      return Scaffold(
          appBar: AppAppBarCommon(
              title: appFonts.myAccount, leadingOnTap: () => Get.back()),
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('id', isEqualTo: myAccountCtrl.id)
                  .limit(1)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(children: [
                      const VSpace(Sizes.s10),
                      UserImage(
                              name: snapshot.data!.docs[0].data()["email"],
                              image: snapshot.data!.docs[0].data()["image"],
                              isLoading: myAccountCtrl.isLoading)
                          .inkWell(
                              onTap: () =>
                                  myAccountCtrl.imagePickerOption(context)),
                      const VSpace(Sizes.s15),
                      const AllTextForm()
                          .paddingSymmetric(
                              horizontal: Insets.i20, vertical: Insets.i25)
                          .authBoxExtension(),
                    ])
                        .paddingSymmetric(horizontal: Insets.i20)
                        .alignment(Alignment.center),
                  );
                } else {
                  return Container();
                }
              }));
    });
  }
}
