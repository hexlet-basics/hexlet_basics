// @ts-check

import gon from 'gon';
import { ru, enUS } from 'date-fns/locale';

const locales = { ru, en: enUS };

export default locales[gon.getAsset('locale')];
