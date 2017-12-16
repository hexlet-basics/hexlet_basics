import gon from 'gon';
import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { I18nextProvider } from 'react-i18next';
import i18n from '../lib/i18n';

import configureStore from '../lib/configureStore';
import AppContainer from './containers/App';
import reducers from './reducers';

const lesson = gon.getAsset('lesson');
const language = gon.getAsset('language');
const description = gon.getAsset('lesson_description');

const store = configureStore(reducers, { code: lesson.prepared_code });

ReactDOM.render(
  <Provider store={store}>
    <I18nextProvider i18n={i18n}>
      <AppContainer lesson={{ ...lesson, ...description }} language={language} />
    </I18nextProvider>
  </Provider>,
  document.getElementById('basics-lesson-container'),
);
