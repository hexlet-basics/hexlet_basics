import i18n from 'i18next';
import { reactI18nextModule } from 'react-i18next';
// import XHR from 'i18next-xhr-backend';
import ruTranslation from '../../locales/ru/translation.json';
import enTranslation from '../../locales/en/translation.json';
import Gon from 'gon';

const resources = {
  ru: {
    translation: ruTranslation,
  },
  en: {
    translation: enTranslation,
  },
};

i18n
  .use(reactI18nextModule)
  .init({
    resources,
    load: 'languageOnly',
    fallbackLng: false,
    lng: Gon.getAsset('locale'),
    debug: process.env.NODE_ENV !== 'production',
    // react i18next special options (optional)
    // keySeparator: false,
    react: {
      wait: true,
    },
  });


export default i18n;
