import 'package:spookyservices/helpers/shared_pref.dart';

class LangHelper {
  String language = sp.getString('spookysrv.language') ?? 'en';

  String locText(String textChi, String textEn) {
    //Localized Text
    if (getLang() == 'en') {
      return textEn;
    } else {
      return textChi;
    }
  }

  String lt(String textChi, String textEn) => lh.locText(textChi, textEn);

  String locTextList(List<String> texts) {
    return locText(texts[0], texts[1]);
  }

  String ltl(List<String> texts) => lh.locTextList(texts);

  void setLang(String lang) {
    language = lang;
    sp.setString('spookysrv.language', lang);
  }

  String getLang() {
    return sp.getString("spookysrv.language") ?? 'en';
  }
}

final lh = LangHelper();
