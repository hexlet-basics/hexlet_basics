// @ts-check

import storage from 'redux-persist/lib/storage';
import { persistReducer } from 'redux-persist';
import gon from 'gon';

const language = gon.getAsset('language');
const lesson = gon.getAsset('lesson');

const persistChangeCodeConfig = {
  key: `code:${language.slug}:${lesson.slug}`,
  storage,
};

const persistChangeCodeReducer = (reducer) => persistReducer(persistChangeCodeConfig, reducer);

export default {
  persistChangeCodeReducer,
}
