import '../config.dart';

class Validation {
  RegExp digitRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  RegExp regex = RegExp("^([0-9]{4}|[0-9]{6})");
  // Email Validation
  emailValidation(email) {
    if (email.isEmpty) {
      return appFonts.pleaseEnterEmail.tr;
    } else if (!digitRegex.hasMatch(email)) {
      return appFonts.pleaseEnterValid.tr;
    }
    return null;
  }

  // Password Validation
  passValidation(password) {
    if (password.isEmpty) {
      return appFonts.pleaseEnterPassword.tr;
    }
    if (password.length < 8) {
      return appFonts.passwordMustBe.tr;
    }
    return null;
  }

  // name validation
  nameValidation(name) {
    if (name.isEmpty) {
      return appFonts.pleaseEnterValue.tr;
    }
    if (name.length < 6) {
      return appFonts.enterAtLeast.tr;
    }
    return null;
  }


  // phone validation
  phoneValidation(phone) {
    if (phone.isEmpty) {
      return appFonts.pleaseEnterValue.tr;
    }
    if(!regex.hasMatch(phone)) {
      return appFonts.enterValidNumber;
    }

    return null;
  }

  // Otp Validation
  otpValidation (value) {
    if (value!.isEmpty) {
      return ("Enter otp ");
    }
    if (!regex.hasMatch(value)) {
      return ("Enter valid otp");
    }
    return null;
  }

  // Common field validation
 commonValidation(value){
   if (value!.isEmpty) {
     return appFonts.pleaseEnterValue.tr;
   }
 }

}
