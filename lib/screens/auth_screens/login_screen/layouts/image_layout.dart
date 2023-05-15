import 'dart:developer';

import '../../../../config.dart';

class LoginImageLayout extends StatelessWidget {
  const LoginImageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("height: ${MediaQuery.of(context).size.height}");
    return Stack(alignment: Alignment.bottomLeft, children: [
      SizedBox(
          height: MediaQuery.of(context).size.height < 534
              ? MediaQuery.of(context).size.height * 0.37
              : MediaQuery.of(context).size.height * 0.55,
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(eGifAssets.login,
                        height: MediaQuery.of(context).size.height * 0.35)
                    .paddingOnly(right: Insets.i37, bottom: Insets.i30)
              ])).decorated(color: const Color(0xff1BA2EB)),
      Image.asset(eImageAssets.loginBot,
              width: Sizes.s170,
              height: MediaQuery.of(context).size.height < 534
                  ? MediaQuery.of(context).size.height * 0.25
                  : MediaQuery.of(context).size.height * 0.3)
          .paddingOnly(bottom: Insets.i28, left: Insets.i30)
    ]);
  }
}
