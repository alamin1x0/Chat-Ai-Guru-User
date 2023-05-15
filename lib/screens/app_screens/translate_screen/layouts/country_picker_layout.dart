import 'package:flutter/cupertino.dart';
import '../../../../config.dart';

class LanguagePickerLayout extends StatelessWidget {
  final ValueChanged<int>? onSelectedItemChanged;
  final int? index;
  final List? list;
  final TextEditingController? controller;
  final SuggestionSelectionCallback? onSuggestionSelected;
  final FixedExtentScrollController? scrollController;
  final GestureTapCallback? selectOnTap;
  final ScrollController? thumbScrollController;
  final SuggestionsCallback<String>? suggestionsCallbacks;
  final String? title,image;

  const LanguagePickerLayout(
      {Key? key,
      this.onSelectedItemChanged,
      this.index,
      this.list,
      this.controller,
      this.onSuggestionSelected,
      this.scrollController,
      this.selectOnTap,
      this.thumbScrollController,this.suggestionsCallbacks,this.title,this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(title!.tr,
                    style: AppCss.outfitSemiBold20
                        .textColor(appCtrl.appTheme.txt)),
                SvgPicture.asset(eSvgAssets.cancel)
                    .inkWell(onTap: () => Get.back())
              ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i20),
              const DottedLines(),
              Column(children: [
                SizedBox(
                    width: double.infinity,
                    child: TypeAheadField(
                      noItemsFoundBuilder: (context) => SizedBox(
                          height: Sizes.s50,
                          child: Center(
                              child: Text(appFonts.noItemFound.tr,
                                  style: AppCss.outfitMedium16
                                      .textColor(appCtrl.appTheme.lightText)))),
                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                          color: appCtrl.appTheme.white,
                          elevation: 4.0,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      debounceDuration: const Duration(milliseconds: 400),
                      textFieldConfiguration: TextFieldConfiguration(
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(AppRadius.r8)),
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none)),
                              hintText: appFonts.selectLanguage.tr,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Insets.i15, vertical: Insets.i10),
                              hintStyle: AppCss.outfitMedium14
                                  .textColor(appCtrl.appTheme.lightText),
                              suffixIcon: SizedBox(
                                  height: 10,
                                  width: 5,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const VerticalDivider(
                                            width: 1,
                                            thickness: 2,
                                            indent: 10,
                                            endIndent: 10),
                                        SvgPicture.asset(eSvgAssets.search)
                                            .inkWell(onTap: () {})
                                            .paddingSymmetric(
                                                horizontal: Insets.i10)
                                      ])),
                              fillColor: appCtrl.appTheme.textField,
                              filled: true)),
                      suggestionsCallback: suggestionsCallbacks!,
                      itemBuilder: (context, String suggestion) {
                        return Row(children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Text(suggestion,
                                    maxLines: 1,
                                    style: AppCss.outfitMedium14
                                        .textColor(appCtrl.appTheme.txt),
                                    overflow: TextOverflow.ellipsis)
                              ]))
                        ]);
                      },
                      onSuggestionSelected: onSuggestionSelected!,
                    )).paddingSymmetric(horizontal: Insets.i20),
                const VSpace(Sizes.s10),
                Stack(alignment: Alignment.centerLeft, children: [
                  Stack(alignment: Alignment.center, children: [
                    SizedBox(
                        height: Sizes.s270,
                        child: CupertinoPicker(
                            scrollController: scrollController,
                            selectionOverlay:
                                CupertinoPickerDefaultSelectionOverlay(
                                    background: appCtrl.appTheme.trans,
                                    capStartEdge: false,
                                    capEndEdge: false),
                            magnification: 1,
                            backgroundColor: appCtrl.appTheme.white,
                            itemExtent: 60,
                            looping: true,
                            useMagnifier: true,
                            onSelectedItemChanged: onSelectedItemChanged,
                            children:
                                list!
                                    .asMap()
                                    .entries
                                    .map((e) => Center(
                                        child: Text(e.value,
                                            style: e.key == index
                                                ? AppCss.outfitSemiBold20
                                                    .textColor(appCtrl
                                                        .appTheme.primary)
                                                : AppCss.outfitSemiBold16
                                                    .textColor(appCtrl
                                                        .appTheme.lightText))))
                                    .toList())),
                    Image.asset(eImageAssets.languageContainer,
                            width: Sizes.s250, height: Sizes.s50)
                        .paddingOnly(left: Insets.i40)
                  ]),
                  Stack(alignment: Alignment.centerRight, children: [
                    Image.asset(eImageAssets.slider, height: Sizes.s255),
                    SvgPicture.asset(image ?? eSvgAssets.language)
                        .paddingSymmetric(horizontal: Insets.i28)
                  ])
                ]),
                ButtonCommon(title: appFonts.select, onTap: selectOnTap)
                    .paddingSymmetric(horizontal: Insets.i20)
              ]).paddingSymmetric(vertical: Insets.i20)
            ])));
  }
}
