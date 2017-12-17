import i18n from 'i18next';
import XHR from 'i18next-xhr-backend';
import Gon from 'gon';


i18n
  .use(XHR)
  .init({
    load: 'languageOnly',
    fallbackLng: false,
    lng: Gon.getAsset('locale'),
    debug: true,
    // react i18next special options (optional)
    react: {
      wait: true,
      bindI18n: 'languageChanged loaded',
      bindStore: 'added removed',
      nsMode: 'default',
    },
  });


export default i18n;
