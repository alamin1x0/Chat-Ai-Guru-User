import 'package:country_list_pick/country_list_pick.dart';
import '../../../../config.dart';

class CountryListLayout extends StatelessWidget {
  const CountryListLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: Sizes.s48,
            child: CountryListPick(
                appBar: AppBar(
                    centerTitle: true,
                    title: Text(appFonts.selectCountry,
                        style: AppCss.outfitSemiBold18
                            .textColor(appCtrl.appTheme.sameWhite)),
                    elevation: 0,
                    backgroundColor: appCtrl.appTheme.primary),
                pickerBuilder: (context, CountryCode? countryCode) {
                  return Row(children: [
                    Image.asset(countryCode!.flagUri.toString(),
                        package: 'country_list_pick',
                        height: Sizes.s30,
                        width: Sizes.s30),

                    Text(countryCode.dialCode.toString(),
                            style: AppCss.outfitMedium14
                                .textColor(appCtrl.appTheme.txt))
                        .paddingSymmetric(horizontal: Insets.i5),
                    SvgPicture.asset(eSvgAssets.dropDown)
                  ]);
                },
                theme: CountryTheme(
                    alphabetSelectedBackgroundColor: appCtrl.appTheme.primary),
                initialSelection: '+91',
                onChanged: (CountryCode? code) {}))
        .decorated(
            color: appCtrl.appTheme.textField,
            borderRadius:
                const BorderRadius.all(Radius.circular(AppRadius.r8)));
  }
}
