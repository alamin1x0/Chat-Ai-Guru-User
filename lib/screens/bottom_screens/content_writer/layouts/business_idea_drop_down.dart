

import '../../../../config.dart';

class BusinessIdeaDropDown extends StatelessWidget {
  const BusinessIdeaDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentWriterController>(
      builder: (contentCtrl) {
        return DropdownButtonHideUnderline(
            child: ButtonTheme(
                child: DropdownButtonFormField(
                    value: contentCtrl.selectedValue,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: Insets.i15),
                        border: ContentCommonWidget().commonBorder(),
                        disabledBorder: ContentCommonWidget().commonBorder(),
                        focusedBorder: ContentCommonWidget().commonBorder(),
                        enabledBorder: ContentCommonWidget().commonBorder(),
                        errorBorder: ContentCommonWidget().commonBorder(),
                        filled: true,
                        hintStyle: AppCss.outfitblack14.textColor(appCtrl.appTheme.txt),
                        hintText: "Name",
                        fillColor: appCtrl.appTheme.white),
                    borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r8)),
                    style: AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt),
                    icon: SvgPicture.asset(eSvgAssets.downArrow),
                    isDense: true,
                    isExpanded: true,
                    hint: Text(appFonts.businessIdea.tr),
                    items: contentCtrl.contentOptionList.asMap().entries.map((e) => DropdownMenuItem(value: e.value, child: Text(e.value.toString().tr))).toList(),
                    onChanged: (val) {})));
      }
    );
  }
}
