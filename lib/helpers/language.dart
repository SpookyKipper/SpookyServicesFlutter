import 'package:spookyservices/helpers/shared_pref.dart';

class LangHelper {
  String language = sp.getString('spookysrv.language') ?? 'en';

  String locText(String textChi, String textEn) {
    //Localized Text
    if (language == 'en') {
      return textEn;
    } else {
      return textChi;
    }
  }

  String lt(String textChi, String textEn) => lh.locText(textChi, textEn);

  void setLang(String lang) {
    language = lang;
    sp.setString('language', lang);
  }

  String getLang() {
    return sp.getString("spookysrv.language") ?? 'en';
  }
}

final lh = LangHelper();
