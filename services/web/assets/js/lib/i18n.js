// @ts-check

import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import Gon from 'gon';
// import XHR from 'i18next-xhr-backend';
import ruTranslation from '../../locales/ru/translation.json';
import enTranslation from '../../locales/en/translation.json';

const resources = {
  ru: {
    translation: ruTranslation,
  },
  en: {
    translation: enTranslation,
  },
};

i18n
  .use(initReactI18next)
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
