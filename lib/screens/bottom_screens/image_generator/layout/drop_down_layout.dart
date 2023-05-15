import '../../../../config.dart';

class DropDownLayout extends StatelessWidget {
  final String? title,hintText,value;
  final ValueChanged? onChanged;
  final List<DropdownMenuItem<Object>>? dropDownList;
  const DropDownLayout({Key? key,this.title,this.hintText,this.onChanged,this.dropDownList,this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title!.toString().tr,
          style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.txt)),
      const VSpace(Sizes.s10),
      SizedBox(
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                      child: DropdownButton(
                        value: value,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppRadius.r8)),
                          style: AppCss.outfitMedium14
                              .textColor(appCtrl.appTheme.lightText),
                          icon: SvgPicture.asset(eSvgAssets.dropDown),
                          isDense: true,
                          isExpanded: true,
                          hint: Text(hintText!.toString().tr),
                          items: dropDownList!,
                          onChanged: onChanged)
                    )))
                  ]))
          .paddingSymmetric(vertical: Insets.i10, horizontal: Insets.i15)
          .decorated(
              color: appCtrl.appTheme.textField,
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadius.r8)))
    ]));
  }
}
