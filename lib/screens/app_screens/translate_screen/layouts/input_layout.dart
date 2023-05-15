import 'package:flutter/services.dart';
import '../../../../config.dart';

class InputLayout extends StatelessWidget {
  final String? title, hintText, responseText, text;
  final TextEditingController? controller;
  final bool? isMax, isAnimated;
  final GestureTapCallback? onTap, microPhoneTap;
  final Color? color, txtColor;
  final int? maxLine;
  final double? height;

  const InputLayout(
      {Key? key,
      this.title,
      this.controller,
      this.isMax,
      this.isAnimated = false,
      this.hintText,
      this.onTap,
      this.microPhoneTap,
      this.color,
      this.txtColor,
      this.maxLine,
      this.responseText,
      this.height,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
            width: isMax == true ? Sizes.s250 : Sizes.s180,
            child: Text(title!.toString().tr,
                overflow: TextOverflow.ellipsis,
                style: AppCss.outfitSemiBold14
                    .textColor(txtColor ?? appCtrl.appTheme.txt))),
        if (isMax == true)
          SvgIconsCommon(
              icon: eSvgAssets.microphone,
              onTap: microPhoneTap,
              isAnimated: isAnimated!,
              height: height),
        if (isMax != true)
          Row(children: [
            SvgIconsCommon(icon: eSvgAssets.volume)
                .inkWell(onTap: () => textToSpeechCtrl.speechMethod(text!)),
            SvgIconsCommon(icon: eSvgAssets.share)
                .paddingSymmetric(horizontal: Insets.i10)
                .inkWell(
                    onTap: text!.isNotEmpty ? () => Share.share(text!) : () {}),
            SvgIconsCommon(icon: eSvgAssets.copy).inkWell(
                onTap: () => Clipboard.setData(ClipboardData(text: text!)))
          ])
      ]),
      const VSpace(Sizes.s10),
      Stack(
          alignment:
              appCtrl.isRTL ? Alignment.bottomLeft : Alignment.bottomRight,
          children: [
            SizedBox(
                    width: double.infinity,
                    child: isMax == false
                        ? AnimatedTextKit(
                            isRepeatingAnimation: false,
                            animatedTexts: [
                                TyperAnimatedText(responseText!,
                                    textStyle: AppCss.outfitMedium14
                                        .textColor(appCtrl.appTheme.txt)
                                        .textHeight(1.3),
                                    speed: const Duration(milliseconds: 50))
                              ]).paddingAll(Insets.i15)
                        : TextFieldCommon(
                            controller: controller!,
                            hintText: hintText ?? appFonts.writeAnything,
                            minLines: 8,
                            validator: (value) =>
                                Validation().commonValidation(value),
                            maxLines: maxLine ?? 100,
                            fillColor: color ?? appCtrl.appTheme.textField,
                            keyboardType: TextInputType.multiline))
                .authBoxExtension(),
            if (isMax == true)
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                SvgPicture.asset(eSvgAssets.cancel,
                        colorFilter: ColorFilter.mode(
                            appCtrl.appTheme.lightText, BlendMode.srcIn))
                    .paddingSymmetric(horizontal: Insets.i10)
                    .inkWell(onTap: onTap),
                VSpace(MediaQuery.of(context).size.height * 0.09),
                Text(appFonts.max50.tr,
                        style: AppCss.outfitMedium12
                            .textColor(appCtrl.appTheme.lightText))
                    .paddingAll(Insets.i10)
              ])
          ])
    ]);
  }
}
