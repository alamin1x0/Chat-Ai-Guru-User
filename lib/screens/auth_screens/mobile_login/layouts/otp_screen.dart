import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import '../../../../config.dart';

class OtpScreen extends StatelessWidget {
  final String? id;
  final dynamic user;
  const OtpScreen({Key? key,this.id,this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return GetBuilder<MobileLoginController>(
              builder: (mobileCtrl) {
                return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppRadius.r14))),
                    backgroundColor: appCtrl.appTheme.white,
                    content: Stack(children: [
                      Stack(alignment: Alignment.topRight, children: [
                        Form(
                            key: mobileCtrl.otpGlobalKey,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const VSpace(Sizes.s55),
                                  Text(appFonts.weHaveSentTheCode.tr,
                                      textAlign: TextAlign.center,
                                      style: AppCss.outfitMedium16
                                          .textColor(
                                          appCtrl.appTheme.txt)
                                          .textHeight(1.2)),

                                  const VSpace(Sizes.s18),
                                  // Number
                                  Text("“${mobileCtrl.mobileController.text}“",
                                      style: AppCss.outfitSemiBold16
                                          .textColor(
                                          appCtrl.appTheme.txt))
                                      .paddingSymmetric(
                                      horizontal: Insets.i5),
                                  const VSpace(Sizes.s25),
                                  OtpLayout(
                                      controller:  mobileCtrl.otpController,
                                      validator: (value) =>
                                          Validation().otpValidation(
                                              value),
                                      onSubmitted: (val) {
                                        mobileCtrl.otpController.text = val;
                                      },
                                      defaultPinTheme:  mobileCtrl.defaultPinTheme,
                                      errorPinTheme:  mobileCtrl.defaultPinTheme
                                          .copyWith(
                                          decoration: BoxDecoration(
                                              color: appCtrl.appTheme
                                                  .error,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  AppRadius.r5))),
                                      focusedPinTheme:  mobileCtrl.defaultPinTheme
                                          .copyWith(
                                          height: Sizes.s48,
                                          width: Sizes.s55,
                                          decoration:  mobileCtrl.defaultPinTheme
                                              .decoration!
                                              .copyWith(
                                              color: appCtrl
                                                  .appTheme.textField,
                                              border: Border.all(
                                                  color: appCtrl
                                                      .appTheme
                                                      .primary)))),
                                  const VSpace(Sizes.s25),
                                  ButtonCommon(
                                      onTap: () =>
                                          mobileCtrl.onTapValidateOtp(
                                              id: id,
                                              pUser: user),
                                      title: appFonts.verifyProceed),
                                  const VSpace(Sizes.s15),
                                  RichText(
                                      text: TextSpan(
                                          text: appFonts.dontReciveOtp
                                              .tr,
                                          style: AppCss.outfitMedium14
                                              .textColor(appCtrl
                                              .appTheme.lightText),
                                          children: [
                                            TextSpan(
                                                recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap =
                                                      () =>
                                                          mobileCtrl.onVerifyCode(),
                                                text: appFonts
                                                    .resendIt.tr,
                                                style: AppCss
                                                    .outfitMedium14
                                                    .textColor(appCtrl
                                                    .appTheme
                                                    .primary))
                                          ]))
                                ]).paddingSymmetric(
                                horizontal: Insets.i20,
                                vertical: Insets.i20)),
                        Column(mainAxisSize: MainAxisSize.min,
                            children: [
                              const VSpace(Sizes.s5),
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Title
                                    Text(appFonts.otpVerification.tr,
                                        style: AppCss.outfitSemiBold20
                                            .textColor(
                                            appCtrl.appTheme.txt))
                                        .paddingSymmetric(
                                        horizontal: Insets.i20),
                                    IconButton(
                                        onPressed: () => Get.back(),
                                        icon: Icon(
                                            CupertinoIcons.multiply,
                                            size: Sizes.s20,
                                            color: appCtrl.appTheme
                                                .lightText))
                                  ]),
                              const VSpace(Sizes.s5),
                              DottedLines(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width)
                            ])
                      ]),
                      if ( mobileCtrl.isLoading == true)
                        const Center(
                            child: CircularProgressIndicator())
                    ]));
              });
        });
  }
}
