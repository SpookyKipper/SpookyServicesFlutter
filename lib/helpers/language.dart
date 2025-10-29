import 'package:spookyservices/helpers/shared_pref.dart';

class LangHelper {
  String language = sp.getString('language') ?? 'en';

  String LocText(String textChi, String textEn) { //Localized Text
    if (language == 'en') {
      return textEn;
    } else {
      return textChi;
    }
  }

  void setLang(String lang) {
    language = lang;
    sp.setString('language', lang);
  }


  String getLang() {
    return sp.getString("language") ?? 'en';
  }
}

final lh = LangHelper();
