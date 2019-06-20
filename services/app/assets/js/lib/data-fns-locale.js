// @ts-check

import gon from 'gon';
import ru from 'date-fns/locale/ru';
import en from 'date-fns/locale/en';

const locales = { ru, en };

export default locales[gon.getAsset('locale')];
