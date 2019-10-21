// @ts-check

import storage from 'redux-persist/lib/storage';
import { persistReducer } from 'redux-persist';
import gon from 'gon';

const language = gon.getAsset('language');
const lesson = gon.getAsset('lesson');

const persistCodeConfig = {
  key: `code:${language.slug}:${lesson.slug}`,
  storage,
};

export const persistCodeReducer = (reducer) => persistReducer(persistCodeConfig, reducer);

