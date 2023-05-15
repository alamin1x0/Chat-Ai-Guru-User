import '../config.dart';

class TextFieldCommon extends StatelessWidget {
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon, prefixIcon;
  final Color? fillColor;
  final bool obscureText;
  final InputBorder? border;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final int? maxLength,minLines,maxLines;

  const TextFieldCommon(
      {Key? key,
      required this.hintText,
      this.validator,
      this.controller,
      this.suffixIcon,
      this.prefixIcon,
      this.border,
      this.obscureText = false,
      this.fillColor,
      this.keyboardType,
      this.focusNode,
      this.onChanged,
      this.maxLength,this.minLines, this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Text field common
    return TextFormField(
      maxLines: maxLines ?? 1,
      style: AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt),
      focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator ?? (value)=> Validation().commonValidation(value) ,
        controller: controller,
        onChanged: onChanged,
        minLines: minLines,
        maxLength: maxLength,
        decoration: InputDecoration(
            fillColor: fillColor ?? appCtrl.appTheme.textField,
            filled: true,
            border:
                const OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(AppRadius.r8)),
                    borderSide: BorderSide(width: 0, style: BorderStyle.none)),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: Insets.i15, vertical: Insets.i10),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintStyle:
            AppCss.outfitMedium14.textColor(appCtrl.appTheme.lightText),
            hintText: hintText.tr));
  }
}
