import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'en.dart';
import 'fr.dart';
import 'ge.dart';
import 'hi.dart';
import 'it.dart';
import 'ja.dart';

class Language extends Translations {
  // TODO: implement keys
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en,
    'hi_IN': hi,
    'fr_CA': fr,
    'ja_JP': ja,
    'it_IT': it,
    'ge_GE': ge,
  };
}
